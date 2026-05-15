import 'better_theme.dart';
import 'home/home_slot_bundle.dart';
import 'chrome/chrome_bundle.dart';
import '../themes/sunlit_light.dart';
import '../themes/sunlit_dark.dart';
import '../themes/terminal_cream.dart';
import 'home/sunlit_v1_home.dart';
import 'home/terminal_v1_home.dart';
import 'chrome/sunlit_v1_chrome.dart';
import 'chrome/terminal_v1_chrome.dart';

class ThemeRegistry {
  static const List<BetterTheme> all = [
    sunlitDarkTheme,
    sunlitLightTheme,
    terminalCreamTheme,
  ];

  static bool exists(String id) {
    for (final t in all) {
      if (t.id == id) return true;
    }
    return false;
  }

  static BetterTheme resolve(String id) {
    for (final t in all) {
      if (t.id == id) return t;
    }
    for (final t in all) {
      if (t.id == 'sunlit_light') return t;
    }
    return all.first;
  }
}

class HomeStyleRegistry {
  static final Map<HomeStyleId, HomeSlotBundle> _bundles = {
    HomeStyleId.sunlitV1: sunlitV1HomeBundle(),
    HomeStyleId.terminalV1: terminalV1HomeBundle(),
  };

  static HomeSlotBundle resolve(HomeStyleId id) =>
      _bundles[id] ?? _bundles[HomeStyleId.sunlitV1]!;
}

class ChromeRegistry {
  static final Map<ChromeStyleId, ChromeBundle> _bundles = {
    ChromeStyleId.sunlitV1: sunlitV1ChromeBundle(),
    ChromeStyleId.terminalV1: terminalV1ChromeBundle(),
  };

  static ChromeBundle resolve(ChromeStyleId id) =>
      _bundles[id] ?? _bundles[ChromeStyleId.sunlitV1]!;
}
