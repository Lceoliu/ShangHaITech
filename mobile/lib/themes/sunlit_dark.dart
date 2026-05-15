import 'package:flutter/material.dart';

import '../theming/better_theme.dart';
import '../theming/chrome/chrome_bundle.dart';
import '../theming/home/home_slot_bundle.dart';
import '../theming/tokens/better_tokens.dart';
import '../theming/tokens/subject_accents.dart';
import '../theming/tokens/variant_bundle.dart';

const _darkPrimary = Color(0xFFFFB45C);
const _darkSurface = Color(0xFF16140F);
const _darkOnSurface = Color(0xFFE9E2D5);
const _darkSurfaceContainerLowest = Color(0xFF100F0B);
const _darkSurfaceContainerLow = Color(0xFF1E1B14);
const _darkSurfaceContainer = Color(0xFF242118);
const _darkSurfaceContainerHigh = Color(0xFF2F2B20);
const _darkSurfaceContainerHighest = Color(0xFF3B3629);
const _darkOnSurfaceVariant = Color(0xFFCFC6B6);
const _darkOutlineVariant = Color(0xFF5A5348);

const _darkTypeScale = TypeScale(
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
    brightness: Brightness.dark,
    primary: _darkPrimary,
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
    surface: _darkSurface,
    onSurface: _darkOnSurface,
    surfaceContainerLowest: _darkSurfaceContainerLowest,
    surfaceContainerLow: _darkSurfaceContainerLow,
    surfaceContainer: _darkSurfaceContainer,
    surfaceContainerHigh: _darkSurfaceContainerHigh,
    surfaceContainerHighest: _darkSurfaceContainerHighest,
    onSurfaceVariant: _darkOnSurfaceVariant,
    outline: Color(0xFF9A907E),
    outlineVariant: _darkOutlineVariant,
    inverseSurface: Color(0xFFFEFCF4),
    onInverseSurface: Color(0xFF383833),
    inversePrimary: Color(0xFF9F4E00),
    shadow: _darkPrimary,
    scrim: Color(0xFF000000),
    surfaceTint: Colors.transparent,
  );

  return ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    useMaterial3: true,
    extensions: [
      const BetterTokens(
        fontFamilies: FontFamilyTokens(sans: 'system', mono: 'monospace'),
        typeScale: _darkTypeScale,
        radii: BorderRadiusTokens(
            none: 0, xs: 8, sm: 16, md: 24, lg: 32, pill: 999),
        borders: BorderWidthTokens(hairline: 0.5, thin: 1, regular: 2),
        spacing: SpacingTokens(),
        motion: MotionTokens(),
        shadows: ShadowTokens(
          none: [],
          subtle: [
            BoxShadow(
                color: Color(0x18FFB45C), blurRadius: 12, offset: Offset(0, 4))
          ],
          elevated: [
            BoxShadow(
                color: Color(0x18FFB45C), blurRadius: 24, offset: Offset(0, 8))
          ],
          dramatic: [
            BoxShadow(
                color: Color(0x18FFB45C), blurRadius: 48, offset: Offset(0, 16))
          ],
        ),
        decorations: null,
      ),
      const SubjectAccentScheme(
        computer: SubjectAccent(
            bg: Color(0xFF0D2030),
            text: Color(0xFFAAD4F0),
            accent: Color(0xFF4BA8D8)),
        bio: SubjectAccent(
            bg: Color(0xFF0B2016),
            text: Color(0xFF9FCDB0),
            accent: Color(0xFF3FA060)),
        design: SubjectAccent(
            bg: Color(0xFF2C1008),
            text: Color(0xFFE0B090),
            accent: Color(0xFFCC6830)),
        chemistry: SubjectAccent(
            bg: Color(0xFF22122C),
            text: Color(0xFFD0A8E8),
            accent: Color(0xFF9860C0)),
        physics: SubjectAccent(
            bg: Color(0xFF101828),
            text: Color(0xFFB0C4E8),
            accent: Color(0xFF5070C0)),
        math: SubjectAccent(
            bg: Color(0xFF1E1A08),
            text: Color(0xFFE0D098),
            accent: Color(0xFFB89840)),
        economics: SubjectAccent(
            bg: Color(0xFF280E18),
            text: Color(0xFFE0A8C0),
            accent: Color(0xFFC06080)),
        engineering: SubjectAccent(
            bg: Color(0xFF221408),
            text: Color(0xFFE0C098),
            accent: Color(0xFFD07830)),
        fallback: SubjectAccent(
            bg: _darkSurfaceContainerLow,
            text: _darkOnSurface,
            accent: _darkPrimary),
      ),
      const VariantBundleExtension(VariantSet()),
    ],
    textTheme: TextTheme(
      displayLarge: _darkTypeScale.displayLarge,
      displayMedium: _darkTypeScale.displayMedium,
      displaySmall: _darkTypeScale.displaySmall,
      headlineLarge: _darkTypeScale.headlineLarge,
      headlineMedium: _darkTypeScale.headlineMedium,
      headlineSmall: _darkTypeScale.headlineSmall,
      titleLarge: _darkTypeScale.titleLarge,
      titleMedium: _darkTypeScale.titleMedium,
      titleSmall: _darkTypeScale.titleSmall,
      bodyLarge: _darkTypeScale.bodyLarge,
      bodyMedium: _darkTypeScale.bodyMedium,
      bodySmall: _darkTypeScale.bodySmall,
      labelLarge: _darkTypeScale.labelLarge,
      labelMedium: _darkTypeScale.labelMedium,
      labelSmall: _darkTypeScale.labelSmall,
    ),
    cardTheme: CardThemeData(
      color: colorScheme.surfaceContainerLow,
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24))),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerHigh,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
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

const sunlitDarkTheme = BetterTheme(
  id: 'sunlit_dark',
  name: 'Sunlit · Dark',
  authorName: 'better-skd',
  description: '暖橙的暗色版本，傍晚使用更舒适。',
  brightness: Brightness.dark,
  buildThemeData: _build,
  variants: VariantSet(),
  homeStyle: HomeStyleId.sunlitV1,
  chromeStyle: ChromeStyleId.sunlitV1,
  preview: ThemePreview(
    swatch: [
      _darkPrimary,
      Color(0xFF7A3D00),
      _darkSurface,
      _darkSurfaceContainerHigh,
      _darkOnSurface,
    ],
  ),
);
