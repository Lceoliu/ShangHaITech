import 'package:flutter/material.dart';

// ── Sunlit Commons Palette ────────────────────────────────────────────────────
// These are shared across the app — import this file to access them.
const kColorPrimary = Color(0xFF9F4E00);
const kColorOnPrimary = Color(0xFFFFFFFF);
const kColorPrimaryContainer = Color(0xFFF97F06);
const kColorOnPrimaryContainer = Color(0xFF3B1900);

const kColorSurface = Color(0xFFFEFCF4);
const kColorOnSurface = Color(0xFF383833);
const kColorOnSurfaceVariant = Color(0xFF65655F);
const kColorOutlineVariant = Color(0xFFBAB9B2);

const kColorSurfaceContainerLowest = Color(0xFFFFFFFF);
const kColorSurfaceContainerLow = Color(0xFFFBF9F1);
const kColorSurfaceContainer = Color(0xFFF5F4EB);
const kColorSurfaceContainerHigh = Color(0xFFEFEEE5);
const kColorSurfaceContainerHighest = Color(0xFFE9E9DE);

const kColorTertiaryContainer = Color(0xFFF9DB7D);
const kColorOnTertiaryContainer = Color(0xFF5F4C00);
const kColorTertiary = Color(0xFF78620E);

const kColorError = Color(0xFFBE2D06);
const kColorErrorContainer = Color(0xFFF95630);

// Sunlit Shadow: primary tinted at ~6% — never use pure black
const kSunlitShadow = Color(0x0F9F4E00);

ThemeData buildBetterSkdTheme() {
  const colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: kColorPrimary,
    onPrimary: kColorOnPrimary,
    primaryContainer: kColorPrimaryContainer,
    onPrimaryContainer: kColorOnPrimaryContainer,
    secondary: Color(0xFF865C00),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFC96F),
    onSecondaryContainer: Color(0xFF614100),
    tertiary: kColorTertiary,
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: kColorTertiaryContainer,
    onTertiaryContainer: kColorOnTertiaryContainer,
    error: kColorError,
    onError: Color(0xFFFFFFFF),
    errorContainer: kColorErrorContainer,
    onErrorContainer: Color(0xFF520C00),
    surface: kColorSurface,
    onSurface: kColorOnSurface,
    surfaceContainerLowest: kColorSurfaceContainerLowest,
    surfaceContainerLow: kColorSurfaceContainerLow,
    surfaceContainer: kColorSurfaceContainer,
    surfaceContainerHigh: kColorSurfaceContainerHigh,
    surfaceContainerHighest: kColorSurfaceContainerHighest,
    onSurfaceVariant: kColorOnSurfaceVariant,
    outline: Color(0xFF81817A),
    outlineVariant: kColorOutlineVariant,
    inverseSurface: Color(0xFF0E0F0A),
    onInverseSurface: Color(0xFF9E9D96),
    inversePrimary: kColorPrimaryContainer,
    shadow: kColorPrimary,
    scrim: Color(0xFF000000),
    surfaceTint: Colors.transparent,
  );

  return ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: kColorSurface,
    useMaterial3: true,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 56, fontWeight: FontWeight.w800, letterSpacing: -1.5),
      displayMedium: TextStyle(
          fontSize: 45, fontWeight: FontWeight.w800, letterSpacing: -1.0),
      displaySmall: TextStyle(
          fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -0.5),
      headlineLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.5),
      headlineMedium: TextStyle(
          fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.8),
      headlineSmall: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.5),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      titleMedium: TextStyle(
          fontSize: 17, fontWeight: FontWeight.w700, letterSpacing: -0.2),
      titleSmall: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: -0.1),
      bodyLarge: TextStyle(fontSize: 15, height: 1.5),
      bodyMedium: TextStyle(fontSize: 14, height: 1.45),
      bodySmall: TextStyle(fontSize: 12, height: 1.4),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      labelMedium: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      labelSmall: TextStyle(
          fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5),
    ),
    cardTheme: const CardThemeData(
      color: kColorSurfaceContainerLowest,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: kColorSurfaceContainerHigh,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(color: Color(0x669F4E00), width: 2),
      ),
      hintStyle: const TextStyle(
          color: kColorOnSurfaceVariant, fontWeight: FontWeight.w400),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    chipTheme: ChipThemeData(
      shape: const StadiumBorder(),
      side: BorderSide.none,
      backgroundColor: kColorSurfaceContainerHigh,
      selectedColor: kColorPrimary.withValues(alpha: 0.12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        color: kColorPrimary,
      ),
      iconTheme: IconThemeData(color: kColorPrimary),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}

// ── BuildContext theme extension ──────────────────────────────────────────────
// Convenience shortcut: `context.cs.surface`, `context.isDark`, etc.

extension BetterSkdThemeX on BuildContext {
  ColorScheme get cs => Theme.of(this).colorScheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // Theme-adaptive sunlit shadow (warm amber tint in dark, warm orange in light)
  Color get adaptiveShadow => isDark ? const Color(0x18FFB45C) : kSunlitShadow;
}

ThemeData buildBetterSkdDarkTheme() {
  const colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFFB45C),
    onPrimary: Color(0xFF402000),
    primaryContainer: Color(0xFF7A3D00),
    onPrimaryContainer: Color(0xFFFFD9AE),
    secondary: Color(0xFFE8BF75),
    onSecondary: Color(0xFF402B00),
    secondaryContainer: Color(0xFF5D430C),
    onSecondaryContainer: Color(0xFFFFDF9E),
    tertiary: Color(0xFFD8C36D),
    onTertiary: Color(0xFF393000),
    tertiaryContainer: Color(0xFF554800),
    onTertiaryContainer: Color(0xFFF5E48B),
    error: Color(0xFFFFB4A4),
    onError: Color(0xFF5F1500),
    errorContainer: Color(0xFF8B2100),
    onErrorContainer: Color(0xFFFFDAD1),
    surface: Color(0xFF16140F),
    onSurface: Color(0xFFE9E2D5),
    surfaceContainerLowest: Color(0xFF100F0B),
    surfaceContainerLow: Color(0xFF1E1B14),
    surfaceContainer: Color(0xFF242118),
    surfaceContainerHigh: Color(0xFF2F2B20),
    surfaceContainerHighest: Color(0xFF3B3629),
    onSurfaceVariant: Color(0xFFCFC6B6),
    outline: Color(0xFF9A907E),
    outlineVariant: Color(0xFF5A5348),
    inverseSurface: kColorSurface,
    onInverseSurface: kColorOnSurface,
    inversePrimary: kColorPrimary,
    shadow: Color(0xFFFFB45C),
    scrim: Color(0xFF000000),
    surfaceTint: Colors.transparent,
  );

  return buildBetterSkdTheme().copyWith(
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    cardTheme: CardThemeData(
      color: colorScheme.surfaceContainerLow,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerHigh,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      hintStyle: TextStyle(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    chipTheme: ChipThemeData(
      shape: const StadiumBorder(),
      side: BorderSide.none,
      backgroundColor: colorScheme.surfaceContainerHigh,
      selectedColor: colorScheme.primary.withValues(alpha: 0.22),
      labelStyle: TextStyle(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w700,
      ),
      secondaryLabelStyle: TextStyle(
        color: colorScheme.primary,
        fontWeight: FontWeight.w800,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        color: colorScheme.primary,
      ),
      iconTheme: IconThemeData(color: colorScheme.primary),
    ),
  );
}
