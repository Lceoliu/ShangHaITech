import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app_config.dart';

class SecureStore {
  SecureStore._();

  static const _legacyAccessTokenKey = "better-skd.access-token";
  static const _legacyRefreshTokenKey = "better-skd.refresh-token";
  static const _storage = FlutterSecureStorage();
  static String? _cachedAccessToken;
  static String? _cachedRefreshToken;

  static String _storageNamespace() {
    final raw =
        "${Platform.operatingSystem}:${AppConfig.apiBaseUrl}".toLowerCase();
    final sanitized = raw
        .replaceAll(RegExp(r"[^a-z0-9]+"), ".")
        .replaceAll(RegExp(r"\.+"), ".")
        .replaceAll(RegExp(r"^\.|\.$"), "");
    return sanitized.isEmpty ? "default" : sanitized;
  }

  static String _accessTokenKey() =>
      "better-skd.${_storageNamespace()}.access-token";

  static String _refreshTokenKey() =>
      "better-skd.${_storageNamespace()}.refresh-token";

  static String? _normalize(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return value;
  }

  static Future<String?> _readScopedToken({
    required String scopedKey,
    required String legacyKey,
  }) async {
    final scopedValue = _normalize(await _storage.read(key: scopedKey));
    if (scopedValue != null) {
      return scopedValue;
    }

    final legacyValue = _normalize(await _storage.read(key: legacyKey));
    if (legacyValue == null) {
      return null;
    }

    await _storage.write(key: scopedKey, value: legacyValue);
    return legacyValue;
  }

  static Future<void> _clearKey(String key) {
    // On Windows, deleting the final secure-storage keys can trigger deletion
    // of the backing file while the plugin still holds an open handle.
    // Overwriting with empty strings avoids the PathAccessException and our
    // read helpers still treat empty values as "not logged in".
    return _storage.write(key: key, value: "");
  }

  static Future<String?> readAccessToken() async {
    final cached = _normalize(_cachedAccessToken);
    if (cached != null) {
      return cached;
    }
    final value = await _readScopedToken(
      scopedKey: _accessTokenKey(),
      legacyKey: _legacyAccessTokenKey,
    );
    _cachedAccessToken = value;
    return value;
  }

  static Future<String?> readRefreshToken() async {
    final cached = _normalize(_cachedRefreshToken);
    if (cached != null) {
      return cached;
    }
    final value = await _readScopedToken(
      scopedKey: _refreshTokenKey(),
      legacyKey: _legacyRefreshTokenKey,
    );
    _cachedRefreshToken = value;
    return value;
  }

  static Future<void> writeTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _cachedAccessToken = accessToken;
    _cachedRefreshToken = refreshToken;
    await _storage.write(key: _accessTokenKey(), value: accessToken);
    await _storage.write(key: _refreshTokenKey(), value: refreshToken);
    await _clearKey(_legacyAccessTokenKey);
    await _clearKey(_legacyRefreshTokenKey);
  }

  static Future<void> clearTokens() async {
    _cachedAccessToken = null;
    _cachedRefreshToken = null;
    await _clearKey(_accessTokenKey());
    await _clearKey(_refreshTokenKey());
    await _clearKey(_legacyAccessTokenKey);
    await _clearKey(_legacyRefreshTokenKey);
  }

  static String scopedKey(String suffix) {
    final sanitized = suffix
        .toLowerCase()
        .replaceAll(RegExp(r"[^a-z0-9._-]+"), ".")
        .replaceAll(RegExp(r"\.+"), ".")
        .replaceAll(RegExp(r"^\.|\.$"), "");
    return "better-skd.${_storageNamespace()}.$sanitized";
  }

  static Future<String?> readSecret(String suffix) async {
    return _normalize(await _storage.read(key: scopedKey(suffix)));
  }

  static Future<void> writeSecret(String suffix, String value) async {
    await _storage.write(key: scopedKey(suffix), value: value);
  }

  static Future<void> clearSecret(String suffix) async {
    await _clearKey(scopedKey(suffix));
  }
}
