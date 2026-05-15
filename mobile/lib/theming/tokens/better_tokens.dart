import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'better_tokens.tailor.dart';

@TailorMixinComponent()
class BetterTokens extends ThemeExtension<BetterTokens>
    with _$BetterTokensTailorMixin {
  const BetterTokens({
    required this.fontFamilies,
    required this.typeScale,
    required this.radii,
    required this.borders,
    required this.spacing,
    required this.motion,
    required this.shadows,
    this.decorations,
  });

  @override
  final FontFamilyTokens fontFamilies;
  @override
  final TypeScale typeScale;
  @override
  final BorderRadiusTokens radii;
  @override
  final BorderWidthTokens borders;
  @override
  final SpacingTokens spacing;
  @override
  final MotionTokens motion;
  @override
  final ShadowTokens shadows;
  @override
  final DecorationTokens? decorations;
}

class FontFamilyTokens {
  const FontFamilyTokens({
    required this.sans,
    this.serif,
    required this.mono,
    this.display,
  });
  final String sans;
  final String? serif;
  final String mono;
  final String? display;
}

class TypeScale {
  const TypeScale({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });
  final TextStyle displayLarge, displayMedium, displaySmall;
  final TextStyle headlineLarge, headlineMedium, headlineSmall;
  final TextStyle titleLarge, titleMedium, titleSmall;
  final TextStyle bodyLarge, bodyMedium, bodySmall;
  final TextStyle labelLarge, labelMedium, labelSmall;
}

class BorderRadiusTokens {
  const BorderRadiusTokens({
    required this.none,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.pill,
  });
  final double none, xs, sm, md, lg, pill;
}

class BorderWidthTokens {
  const BorderWidthTokens({
    required this.hairline,
    required this.thin,
    required this.regular,
  });
  final double hairline, thin, regular;
}

class SpacingTokens {
  const SpacingTokens({
    this.xxs = 4,
    this.xs = 8,
    this.sm = 12,
    this.md = 16,
    this.lg = 20,
    this.xl = 24,
    this.xxl = 32,
  });
  final double xxs, xs, sm, md, lg, xl, xxl;
}

class MotionTokens {
  const MotionTokens({
    this.short = const Duration(milliseconds: 120),
    this.medium = const Duration(milliseconds: 240),
    this.long = const Duration(milliseconds: 360),
    this.curveStandard = Curves.easeOutCubic,
    this.curveEmphasized = Curves.easeOutQuint,
  });
  final Duration short, medium, long;
  final Curve curveStandard, curveEmphasized;
}

class ShadowTokens {
  const ShadowTokens({
    required this.none,
    required this.subtle,
    required this.elevated,
    required this.dramatic,
  });
  final List<BoxShadow> none, subtle, elevated, dramatic;

  static const empty = ShadowTokens(
    none: [],
    subtle: [BoxShadow(color: Colors.transparent)],
    elevated: [BoxShadow(color: Colors.transparent)],
    dramatic: [BoxShadow(color: Colors.transparent)],
  );
}

class DecorationTokens {
  const DecorationTokens({
    this.cornerOrnament,
    this.dividerSymbol,
    this.backgroundLayer,
  });
  final String? cornerOrnament;
  final String? dividerSymbol;
  final WidgetBuilder? backgroundLayer;
}
