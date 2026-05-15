import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../better_theme.dart';
import '../registry.dart';

const _activeThemeIdKey = 'better_skd.active_theme_id';
const _defaultThemeId = 'sunlit_light';

final activeThemeIdProvider = StateNotifierProvider<ThemeController, String>(
    (ref) => ThemeController()..load());

final activeThemeProvider = Provider<BetterTheme>((ref) {
  final id = ref.watch(activeThemeIdProvider);
  return ThemeRegistry.resolve(id);
});

class ThemeController extends StateNotifier<String> {
  ThemeController() : super(_defaultThemeId);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(_activeThemeIdKey);
    if (id != null && ThemeRegistry.exists(id)) {
      state = id;
    }
  }

  Future<void> setTheme(String id) async {
    if (!ThemeRegistry.exists(id)) return;
    state = id;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_activeThemeIdKey, id);
  }
}
