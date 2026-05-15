import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'app_config.dart';
import 'models.dart';
import 'secure_store.dart';

/// Top-level helper for [compute] to parse JSON.
dynamic _parseJson(String text) => jsonDecode(text);

class ApiException implements Exception {
  ApiException(
    this.message, {
    this.statusCode,
    this.code,
    this.detail,
  });

  final String message;
  final int? statusCode;
  final String? code;
  final Object? detail;

  String get displayMessage {
    final parts = <String>[];
    if (statusCode != null) {
      parts.add("HTTP $statusCode");
    }
    if (code != null && code!.isNotEmpty) {
      parts.add(code!);
    }
    final header = parts.isEmpty ? "" : "[${parts.join(" / ")}] ";
    final detailText = _stringifyDetail(detail);
    if (detailText == null || detailText.isEmpty || detailText == message) {
      return "$header$message";
    }
    return "$header$message\n$detailText";
  }

  @override
  String toString() => displayMessage;
}

class AuthRequiredException extends ApiException {
  AuthRequiredException([super.message = "请先登录"])
      : super(statusCode: 401, code: "AUTH_REQUIRED");
}

enum AuthPolicy {
  none,
  optional,
  required,
}

String? _stringifyDetail(Object? detail) {
  if (detail == null) {
    return null;
  }
  if (detail is String) {
    return detail.trim().isEmpty ? null : detail;
  }
  if (detail is Map || detail is List) {
    return const JsonEncoder.withIndent("  ").convert(detail);
  }
  return detail.toString();
}

class ApiClient {
  ApiClient._();

  static final ApiClient instance = ApiClient._();
  static const Duration _requestTimeout = Duration(seconds: 25);
  static const Duration _sessionCacheTtl = Duration(seconds: 10);
  final http.Client _httpClient = http.Client();
  Future<void>? _refreshFuture;
  Map<String, dynamic>? _sessionCachePayload;
  DateTime? _sessionCacheExpiresAt;
  Future<Map<String, dynamic>>? _sessionRequestFuture;
  final Map<String, Future<Map<String, dynamic>>> _jsonGetRequestFutures = {};

  Uri _uri(String path, [Map<String, String>? query]) {
    final normalized = path.startsWith("/") ? path : "/$path";
    final base = AppConfig.apiBaseUrl;
    return Uri.parse("$base$normalized").replace(
      queryParameters: query
          ?.map((key, value) => MapEntry(key, value.isEmpty ? null : value)),
    );
  }

  Future<Map<String, String>> _headers({required AuthPolicy authPolicy}) async {
    final headers = <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
      "X-Better-SKD-Client": "mobile-app",
    };
    if (authPolicy != AuthPolicy.none) {
      final accessToken = await SecureStore.readAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        headers["Authorization"] = "Bearer $accessToken";
      }
    }
    return headers;
  }

  Future<void> _refreshOnce() {
    final pending = _refreshFuture;
    if (pending != null) {
      return pending;
    }
    final next = _refresh();
    _refreshFuture = next;
    next.whenComplete(() {
      if (identical(_refreshFuture, next)) {
        _refreshFuture = null;
      }
    });
    return next;
  }

  Future<void> _refresh() async {
    final refreshToken = await SecureStore.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      throw ApiException("登录已失效", statusCode: 401);
    }
    final response = await _httpClient.post(
      _uri("/auth/refresh"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode({"refresh_token": refreshToken}),
    );
    final payload = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200 || payload["ok"] != true) {
      await SecureStore.clearTokens();
      final error = payload["error"] as Map<String, dynamic>?;
      throw ApiException(
        payload["message"] as String? ?? "刷新登录态失败",
        statusCode: response.statusCode,
        code: error?["code"] as String?,
        detail: error?["detail"] ?? payload["detail"],
      );
    }
    final data = payload["data"] as Map<String, dynamic>;
    await SecureStore.writeTokens(
      accessToken: data["access_token"] as String,
      refreshToken: data["refresh_token"] as String,
    );
    invalidateSessionCache();
  }

  bool _isSessionRequest({
    required String path,
    required String method,
    required Map<String, String>? query,
    required Map<String, dynamic>? body,
  }) {
    return method.toUpperCase() == "GET" &&
        path == "/auth/session" &&
        (query == null || query.isEmpty) &&
        body == null;
  }

  void invalidateSessionCache() {
    _sessionCachePayload = null;
    _sessionCacheExpiresAt = null;
    _sessionRequestFuture = null;
  }

  Map<String, dynamic>? _readSessionCache() {
    final payload = _sessionCachePayload;
    final expiresAt = _sessionCacheExpiresAt;
    if (payload == null || expiresAt == null) {
      return null;
    }
    if (DateTime.now().isAfter(expiresAt)) {
      invalidateSessionCache();
      return null;
    }
    return payload;
  }

  void _writeSessionCache(Map<String, dynamic> payload) {
    _sessionCachePayload = payload;
    _sessionCacheExpiresAt = DateTime.now().add(_sessionCacheTtl);
  }

  void seedSessionCache(Map<String, dynamic> sessionData) {
    _writeSessionCache({
      "ok": true,
      "message": "ok",
      "data": sessionData,
    });
  }

  bool _canMergeJsonRequest({
    required String method,
    required Map<String, dynamic>? body,
  }) {
    return method.toUpperCase() == "GET" && body == null;
  }

  String _jsonRequestMergeKey({
    required String path,
    required String method,
    required Map<String, String>? query,
    required bool auth,
    required AuthPolicy? authPolicy,
  }) {
    final sortedQuery = <String, String>{
      for (final entry
          in ((query ?? const <String, String>{}).entries.toList()
            ..sort((left, right) => left.key.compareTo(right.key))))
        entry.key: entry.value,
    };
    return jsonEncode({
      "method": method.toUpperCase(),
      "path": path,
      "query": sortedQuery,
      "auth": auth,
      "auth_policy": authPolicy?.name,
    });
  }

  Future<http.StreamedResponse> _send(
    String path, {
    String method = "GET",
    Map<String, String>? query,
    Map<String, dynamic>? body,
    bool auth = true,
    AuthPolicy? authPolicy,
    bool retryOnUnauthorized = true,
  }) async {
    final resolvedAuthPolicy =
        authPolicy ?? (auth ? AuthPolicy.required : AuthPolicy.none);
    if (resolvedAuthPolicy == AuthPolicy.required) {
      final token = await SecureStore.readAccessToken();
      if (token == null || token.isEmpty) {
        throw AuthRequiredException();
      }
    }
    final uri = _uri(path, query);
    final httpRequest = http.Request(method, uri)
      ..headers.addAll(await _headers(authPolicy: resolvedAuthPolicy))
      ..body = body == null ? "" : jsonEncode(body);
    final streamed =
        await _httpClient.send(httpRequest).timeout(_requestTimeout);

    if (streamed.statusCode == 401 &&
        resolvedAuthPolicy != AuthPolicy.none &&
        retryOnUnauthorized) {
      await streamed.stream.drain();
      await _refreshOnce();
      return _send(
        path,
        method: method,
        query: query,
        body: body,
        auth: auth,
        authPolicy: resolvedAuthPolicy,
        retryOnUnauthorized: false,
      );
    }

    return streamed;
  }

  Future<Map<String, dynamic>> request(
    String path, {
    String method = "GET",
    Map<String, String>? query,
    Map<String, dynamic>? body,
    bool auth = true,
    AuthPolicy? authPolicy,
    bool retryOnUnauthorized = true,
  }) async {
    final sessionRequest = _isSessionRequest(
      path: path,
      method: method,
      query: query,
      body: body,
    );
    if (sessionRequest) {
      final cached = _readSessionCache();
      if (cached != null) {
        return cached;
      }
      final pending = _sessionRequestFuture;
      if (pending != null) {
        return pending;
      }
    }
    final mergeKey =
        !sessionRequest && _canMergeJsonRequest(method: method, body: body)
            ? _jsonRequestMergeKey(
                path: path,
                method: method,
                query: query,
                auth: auth,
                authPolicy: authPolicy,
              )
            : null;
    if (mergeKey != null) {
      final pending = _jsonGetRequestFutures[mergeKey];
      if (pending != null) {
        return pending;
      }
    }

    Future<Map<String, dynamic>> perform() async {
      final streamed = await _send(
        path,
        method: method,
        query: query,
        body: body,
        auth: auth,
        authPolicy: authPolicy,
        retryOnUnauthorized: retryOnUnauthorized,
      );
      final raw =
          await streamed.stream.bytesToString().timeout(_requestTimeout);
      final statusCode = streamed.statusCode;
      Map<String, dynamic> payload;
      try {
        payload = raw.isEmpty
            ? <String, dynamic>{}
            : await compute(_parseJson, raw) as Map<String, dynamic>;
      } on FormatException catch (error) {
        final preview = raw.replaceAll(RegExp(r'\s+'), ' ').trim();
        throw ApiException(
          statusCode >= 500 ? '服务器返回异常内容' : '无法解析服务器响应',
          statusCode: statusCode,
          code: 'invalid_json_response',
          detail: {
            'error': error.message,
            'preview':
                preview.length > 180 ? preview.substring(0, 180) : preview,
          },
        );
      }

      if (statusCode < 200 || statusCode >= 300 || payload["ok"] == false) {
        final error = payload["error"] as Map<String, dynamic>?;
        throw ApiException(
          payload["message"] as String? ??
              payload["detail"] as String? ??
              "请求失败",
          statusCode: statusCode,
          code: error?["code"] as String?,
          detail: error?["detail"] ?? payload["detail"],
        );
      }
      if (sessionRequest) {
        _writeSessionCache(payload);
      }
      return payload;
    }

    if (!sessionRequest) {
      if (mergeKey == null) {
        return perform();
      }
      final future = perform();
      _jsonGetRequestFutures[mergeKey] = future;
      try {
        return await future;
      } finally {
        if (identical(_jsonGetRequestFutures[mergeKey], future)) {
          _jsonGetRequestFutures.remove(mergeKey);
        }
      }
    }

    final future = perform();
    _sessionRequestFuture = future;
    try {
      return await future;
    } finally {
      if (identical(_sessionRequestFuture, future)) {
        _sessionRequestFuture = null;
      }
    }
  }

  Future<Uint8List> requestBytes(
    String path, {
    String method = "GET",
    Map<String, String>? query,
    Map<String, dynamic>? body,
    bool auth = true,
    AuthPolicy? authPolicy,
    bool retryOnUnauthorized = true,
  }) async {
    final streamed = await _send(
      path,
      method: method,
      query: query,
      body: body,
      auth: auth,
      authPolicy: authPolicy,
      retryOnUnauthorized: retryOnUnauthorized,
    );
    final bytes = await streamed.stream.toBytes().timeout(_requestTimeout);
    final statusCode = streamed.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      return bytes;
    }

    Object? detail;
    String message = "请求失败";
    String? code;
    if (bytes.isNotEmpty) {
      final raw = utf8.decode(bytes, allowMalformed: true);
      try {
        final payload = await compute(_parseJson, raw) as Map<String, dynamic>;
        final error = payload["error"] as Map<String, dynamic>?;
        message = payload["message"] as String? ??
            payload["detail"] as String? ??
            message;
        code = error?["code"] as String?;
        detail = error?["detail"] ?? payload["detail"];
      } catch (_) {
        if (raw.trim().isNotEmpty) {
          detail = raw.trim();
        }
      }
    }

    throw ApiException(
      message,
      statusCode: statusCode,
      code: code,
      detail: detail,
    );
  }

  Future<ApiEnvelope<T>> getEnvelope<T>(
    String path, {
    String method = "GET",
    Map<String, String>? query,
    Map<String, dynamic>? body,
    required T Function(Object? json) parse,
    bool auth = true,
    AuthPolicy? authPolicy,
  }) async {
    final payload = await request(
      path,
      method: method,
      query: query,
      body: body,
      auth: auth,
      authPolicy: authPolicy,
    );
    return ApiEnvelope<T>(
      ok: payload["ok"] as bool? ?? true,
      message: payload["message"] as String? ?? "ok",
      data: parse(payload["data"]),
    );
  }
}
