class AppConfig {
  static const _preferredApiBaseUrl = String.fromEnvironment("API_BASE_URL");
  static const _legacyApiBaseUrl =
      String.fromEnvironment("BETTER_SKD_API_BASE_URL");
  static const _productionApiBaseUrl = "https://example.invalid/api/v1";

  static String get apiBaseUrl {
    if (_preferredApiBaseUrl.isNotEmpty) {
      return _preferredApiBaseUrl.replaceAll(RegExp(r"/+$"), "");
    }
    if (_legacyApiBaseUrl.isNotEmpty) {
      return _legacyApiBaseUrl.replaceAll(RegExp(r"/+$"), "");
    }
    return _productionApiBaseUrl;
  }
}
