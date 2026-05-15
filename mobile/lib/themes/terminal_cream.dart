import 'package:flutter/material.dart';

import '../theming/better_theme.dart';
import '../theming/chrome/chrome_bundle.dart';
import '../theming/home/home_slot_bundle.dart';
import '../theming/tokens/better_tokens.dart';
import '../theming/tokens/subject_accents.dart';
import '../theming/tokens/variant_bundle.dart';

const _ink = Color(0xFF1B1B16);
const _paper = Color(0xFFF4ECD8);
const _bracketRed = Color(0xFFB22222);
const _paperSurfaceHigh = Color(0xFFE8E0C8);
const _paperSurfaceContainer = Color(0xFFECE4CC);
const _paperSurfaceContainerHigh = Color(0xFFE0D8BC);
const _paperOutlineVariant = Color(0xFF8A8570);

const _terminalTypeScale = TypeScale(
  displayLarge: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w800,
      letterSpacing: 2,
      fontFamily: 'monospace'),
  displayMedium: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.5,
      fontFamily: 'monospace'),
  displaySmall: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: 1,
      fontFamily: 'monospace'),
  headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: 1,
      fontFamily: 'monospace'),
  headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      letterSpacing: 1,
      fontFamily: 'monospace'),
  headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.8,
      fontFamily: 'monospace'),
  titleLarge: TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'monospace'),
  titleMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      fontFamily: 'monospace'),
  titleSmall: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      fontFamily: 'monospace'),
  bodyLarge: TextStyle(fontSize: 14, height: 1.6, fontFamily: 'monospace'),
  bodyMedium: TextStyle(fontSize: 13, height: 1.5, fontFamily: 'monospace'),
  bodySmall: TextStyle(fontSize: 11, height: 1.4, fontFamily: 'monospace'),
  labelLarge: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      letterSpacing: 1,
      fontFamily: 'monospace'),
  labelMedium: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 1,
      fontFamily: 'monospace'),
  labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      letterSpacing: 1,
      fontFamily: 'monospace'),
);

const _terminalAccent = SubjectAccent(
  bg: _paper,
  text: _ink,
  accent: _bracketRed,
);

ThemeData _build() {
  const colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: _ink,
    onPrimary: _paper,
    primaryContainer: _ink,
    onPrimaryContainer: _paper,
    secondary: _ink,
    onSecondary: _paper,
    secondaryContainer: _paperSurfaceContainer,
    onSecondaryContainer: _ink,
    tertiary: _ink,
    onTertiary: _paper,
    tertiaryContainer: Color(0xFFF0E8CC),
    onTertiaryContainer: _ink,
    error: _bracketRed,
    onError: _paper,
    errorContainer: Color(0x1AB22222),
    onErrorContainer: _bracketRed,
    surface: _paper,
    onSurface: _ink,
    surfaceContainerLowest: _paper,
    surfaceContainerLow: _paperSurfaceContainer,
    surfaceContainer: _paperSurfaceContainer,
    surfaceContainerHigh: _paperSurfaceContainerHigh,
    surfaceContainerHighest: Color(0xFFD8D0B0),
    onSurfaceVariant: Color(0xFF5A5540),
    outline: _paperOutlineVariant,
    outlineVariant: _paperOutlineVariant,
    inverseSurface: _ink,
    onInverseSurface: _paper,
    inversePrimary: _paper,
    shadow: _ink,
    scrim: _ink,
    surfaceTint: Colors.transparent,
  );

  return ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: _paper,
    useMaterial3: true,
    extensions: const [
      BetterTokens(
        fontFamilies: FontFamilyTokens(sans: 'monospace', mono: 'monospace'),
        typeScale: _terminalTypeScale,
        radii: BorderRadiusTokens(none: 0, xs: 0, sm: 0, md: 0, lg: 0, pill: 0),
        borders: BorderWidthTokens(hairline: 1, thin: 1, regular: 2),
        spacing: SpacingTokens(),
        motion: MotionTokens(),
        shadows: ShadowTokens.empty,
        decorations: DecorationTokens(
          cornerOrnament: '+',
          dividerSymbol: '─',
        ),
      ),
      SubjectAccentScheme(
        computer: _terminalAccent,
        bio: _terminalAccent,
        design: _terminalAccent,
        chemistry: _terminalAccent,
        physics: _terminalAccent,
        math: _terminalAccent,
        economics: _terminalAccent,
        engineering: _terminalAccent,
        fallback: _terminalAccent,
      ),
      VariantBundleExtension(VariantSet(
        card: CardVariant.outlinedSharp,
        button: ButtonVariant.boxedMonospace,
        chip: ChipVariant.bracketed,
        input: InputVariant.monospaceFramed,
        divider: DividerVariant.asciiDashed,
        appBar: AppBarVariant.terminalTitle,
        nav: NavVariant.capsLabel,
        homeStyle: HomeStyleId.terminalV1,
        chromeStyle: ChromeStyleId.terminalV1,
      )),
    ],
    textTheme: TextTheme(
      displayLarge: _terminalTypeScale.displayLarge,
      displayMedium: _terminalTypeScale.displayMedium,
      displaySmall: _terminalTypeScale.displaySmall,
      headlineLarge: _terminalTypeScale.headlineLarge,
      headlineMedium: _terminalTypeScale.headlineMedium,
      headlineSmall: _terminalTypeScale.headlineSmall,
      titleLarge: _terminalTypeScale.titleLarge,
      titleMedium: _terminalTypeScale.titleMedium,
      titleSmall: _terminalTypeScale.titleSmall,
      bodyLarge: _terminalTypeScale.bodyLarge,
      bodyMedium: _terminalTypeScale.bodyMedium,
      bodySmall: _terminalTypeScale.bodySmall,
      labelLarge: _terminalTypeScale.labelLarge,
      labelMedium: _terminalTypeScale.labelMedium,
      labelSmall: _terminalTypeScale.labelSmall,
    ),
    cardTheme: CardThemeData(
      color: _paper,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      fillColor: Colors.transparent,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: _paperOutlineVariant, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: _ink, width: 2),
      ),
      hintStyle: TextStyle(
        color: _paperOutlineVariant,
        fontWeight: FontWeight.w400,
        fontFamily: 'monospace',
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    chipTheme: ChipThemeData(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      side: BorderSide.none,
      backgroundColor: Colors.transparent,
      selectedColor: const Color(0x1AB22222),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _paper,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        fontFamily: 'monospace',
        color: _ink,
      ),
      iconTheme: const IconThemeData(color: _ink),
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

const terminalCreamTheme = BetterTheme(
  id: 'terminal_cream',
  name: 'Terminal · Cream CRT',
  authorName: 'better-skd',
  description: '暖黄 CRT 终端风格。等宽字体、硬边描边、无圆角。',
  brightness: Brightness.light,
  buildThemeData: _build,
  variants: VariantSet(
    card: CardVariant.outlinedSharp,
    button: ButtonVariant.boxedMonospace,
    chip: ChipVariant.bracketed,
    input: InputVariant.monospaceFramed,
    divider: DividerVariant.asciiDashed,
    appBar: AppBarVariant.terminalTitle,
    nav: NavVariant.capsLabel,
    homeStyle: HomeStyleId.terminalV1,
    chromeStyle: ChromeStyleId.terminalV1,
  ),
  homeStyle: HomeStyleId.terminalV1,
  chromeStyle: ChromeStyleId.terminalV1,
  preview: ThemePreview(
    swatch: [
      _ink,
      _paper,
      _bracketRed,
      _paperSurfaceHigh,
      _paperOutlineVariant,
    ],
  ),
);
