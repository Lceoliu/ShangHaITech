import 'package:flutter/material.dart';

import '../theming/better_theme.dart';
import '../theming/chrome/chrome_bundle.dart';
import '../theming/home/home_slot_bundle.dart';
import '../theming/tokens/better_tokens.dart';
import '../theming/tokens/subject_accents.dart';
import '../theming/tokens/variant_bundle.dart';

const _primary = Color(0xFF9F4E00);
const _onPrimary = Color(0xFFFFFFFF);
const _primaryContainer = Color(0xFFF97F06);
const _onPrimaryContainer = Color(0xFF3B1900);

const _surface = Color(0xFFFEFCF4);
const _onSurface = Color(0xFF383833);
const _onSurfaceVariant = Color(0xFF65655F);
const _outlineVariant = Color(0xFFBAB9B2);

const _surfaceContainerLowest = Color(0xFFFFFFFF);
const _surfaceContainerLow = Color(0xFFFBF9F1);
const _surfaceContainer = Color(0xFFF5F4EB);
const _surfaceContainerHigh = Color(0xFFEFEEE5);
const _surfaceContainerHighest = Color(0xFFE9E9DE);

const _tertiaryContainer = Color(0xFFF9DB7D);
const _onTertiaryContainer = Color(0xFF5F4C00);
const _tertiary = Color(0xFF78620E);

const _error = Color(0xFFBE2D06);
const _errorContainer = Color(0xFFF95630);

const _sunlitShadow = Color(0x0F9F4E00);

const _typeScale = TypeScale(
  displayLarge:
      TextStyle(fontSize: 56, fontWeight: FontWeight.w800, letterSpacing: -1.5),
  displayMedium:
      TextStyle(fontSize: 45, fontWeight: FontWeight.w800, letterSpacing: -1.0),
  displaySmall:
      TextStyle(fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: -0.5),
  headlineLarge:
      TextStyle(fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.5),
  headlineMedium:
      TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.8),
  headlineSmall:
      TextStyle(fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.5),
  titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
  titleMedium:
      TextStyle(fontSize: 17, fontWeight: FontWeight.w700, letterSpacing: -0.2),
  titleSmall:
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: -0.1),
  bodyLarge: TextStyle(fontSize: 15, height: 1.5),
  bodyMedium: TextStyle(fontSize: 14, height: 1.45),
  bodySmall: TextStyle(fontSize: 12, height: 1.4),
  labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
  labelMedium:
      TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5),
  labelSmall:
      TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5),
);

ThemeData _build() {
  const colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: _primary,
    onPrimary: _onPrimary,
    primaryContainer: _primaryContainer,
    onPrimaryContainer: _onPrimaryContainer,
    secondary: Color(0xFF865C00),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFC96F),
    onSecondaryContainer: Color(0xFF614100),
    tertiary: _tertiary,
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: _tertiaryContainer,
    onTertiaryContainer: _onTertiaryContainer,
    error: _error,
    onError: Color(0xFFFFFFFF),
    errorContainer: _errorContainer,
    onErrorContainer: Color(0xFF520C00),
    surface: _surface,
    onSurface: _onSurface,
    surfaceContainerLowest: _surfaceContainerLowest,
    surfaceContainerLow: _surfaceContainerLow,
    surfaceContainer: _surfaceContainer,
    surfaceContainerHigh: _surfaceContainerHigh,
    surfaceContainerHighest: _surfaceContainerHighest,
    onSurfaceVariant: _onSurfaceVariant,
    outline: Color(0xFF81817A),
    outlineVariant: _outlineVariant,
    inverseSurface: Color(0xFF0E0F0A),
    onInverseSurface: Color(0xFF9E9D96),
    inversePrimary: _primaryContainer,
    shadow: _primary,
    scrim: Color(0xFF000000),
    surfaceTint: Colors.transparent,
  );

  return ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: _surface,
    useMaterial3: true,
    extensions: [
      const BetterTokens(
        fontFamilies: FontFamilyTokens(sans: 'system', mono: 'monospace'),
        typeScale: _typeScale,
        radii: BorderRadiusTokens(
            none: 0, xs: 8, sm: 16, md: 24, lg: 32, pill: 999),
        borders: BorderWidthTokens(hairline: 0.5, thin: 1, regular: 2),
        spacing: SpacingTokens(),
        motion: MotionTokens(),
        shadows: ShadowTokens(
          none: [],
          subtle: [
            BoxShadow(
                color: _sunlitShadow, blurRadius: 12, offset: Offset(0, 4))
          ],
          elevated: [
            BoxShadow(
                color: _sunlitShadow, blurRadius: 24, offset: Offset(0, 8))
          ],
          dramatic: [
            BoxShadow(
                color: _sunlitShadow, blurRadius: 48, offset: Offset(0, 16))
          ],
        ),
        decorations: null,
      ),
      const SubjectAccentScheme(
        computer: SubjectAccent(
            bg: Color(0xFFE6F2FF),
            text: Color(0xFF0D3A6B),
            accent: Color(0xFF2B6CB0)),
        bio: SubjectAccent(
            bg: Color(0xFFE8F8EE),
            text: Color(0xFF1A4A2E),
            accent: Color(0xFF2D6A4F)),
        design: SubjectAccent(
            bg: Color(0xFFFFEBE3),
            text: Color(0xFF4A1E00),
            accent: Color(0xFF9A3412)),
        chemistry: SubjectAccent(
            bg: Color(0xFFF3E8FF),
            text: Color(0xFF3B1A6B),
            accent: Color(0xFF6B21A8)),
        physics: SubjectAccent(
            bg: Color(0xFFEEF2FF),
            text: Color(0xFF1E3A8A),
            accent: Color(0xFF3730A3)),
        math: SubjectAccent(
            bg: Color(0xFFFFF4CC),
            text: Color(0xFF4A3500),
            accent: Color(0xFF92651A)),
        economics: SubjectAccent(
            bg: Color(0xFFFFF0F3),
            text: Color(0xFF4A0020),
            accent: Color(0xFF9D174D)),
        engineering: SubjectAccent(
            bg: Color(0xFFFFF7ED),
            text: Color(0xFF431407),
            accent: Color(0xFFEA580C)),
        fallback: SubjectAccent(
            bg: _surfaceContainerLow, text: _onSurface, accent: _primary),
      ),
      const VariantBundleExtension(VariantSet()),
    ],
    textTheme: TextTheme(
      displayLarge: _typeScale.displayLarge,
      displayMedium: _typeScale.displayMedium,
      displaySmall: _typeScale.displaySmall,
      headlineLarge: _typeScale.headlineLarge,
      headlineMedium: _typeScale.headlineMedium,
      headlineSmall: _typeScale.headlineSmall,
      titleLarge: _typeScale.titleLarge,
      titleMedium: _typeScale.titleMedium,
      titleSmall: _typeScale.titleSmall,
      bodyLarge: _typeScale.bodyLarge,
      bodyMedium: _typeScale.bodyMedium,
      bodySmall: _typeScale.bodySmall,
      labelLarge: _typeScale.labelLarge,
      labelMedium: _typeScale.labelMedium,
      labelSmall: _typeScale.labelSmall,
    ),
    cardTheme: const CardThemeData(
      color: _surfaceContainerLowest,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32))),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _surfaceContainerHigh,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(color: Color(0x669F4E00), width: 2),
      ),
      hintStyle: const TextStyle(
          color: _onSurfaceVariant, fontWeight: FontWeight.w400),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    chipTheme: ChipThemeData(
      shape: const StadiumBorder(),
      side: BorderSide.none,
      backgroundColor: _surfaceContainerHigh,
      selectedColor: _primary.withValues(alpha: 0.12),
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
        color: _primary,
      ),
      iconTheme: IconThemeData(color: _primary),
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

const sunlitLightTheme = BetterTheme(
  id: 'sunlit_light',
  name: 'Sunlit · Light',
  authorName: 'better-skd',
  description: '默认主题。暖橙、纸感、圆润。',
  brightness: Brightness.light,
  buildThemeData: _build,
  variants: VariantSet(),
  homeStyle: HomeStyleId.sunlitV1,
  chromeStyle: ChromeStyleId.sunlitV1,
  preview: ThemePreview(
    swatch: [
      _primary,
      _primaryContainer,
      _surface,
      _surfaceContainerHigh,
      _onSurface,
    ],
  ),
);
