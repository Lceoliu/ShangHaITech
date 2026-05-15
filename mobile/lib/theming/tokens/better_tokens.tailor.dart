// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'better_tokens.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$BetterTokensTailorMixin on ThemeExtension<BetterTokens> {
  FontFamilyTokens get fontFamilies;
  TypeScale get typeScale;
  BorderRadiusTokens get radii;
  BorderWidthTokens get borders;
  SpacingTokens get spacing;
  MotionTokens get motion;
  ShadowTokens get shadows;
  DecorationTokens? get decorations;

  @override
  BetterTokens copyWith({
    FontFamilyTokens? fontFamilies,
    TypeScale? typeScale,
    BorderRadiusTokens? radii,
    BorderWidthTokens? borders,
    SpacingTokens? spacing,
    MotionTokens? motion,
    ShadowTokens? shadows,
    DecorationTokens? decorations,
  }) {
    return BetterTokens(
      fontFamilies: fontFamilies ?? this.fontFamilies,
      typeScale: typeScale ?? this.typeScale,
      radii: radii ?? this.radii,
      borders: borders ?? this.borders,
      spacing: spacing ?? this.spacing,
      motion: motion ?? this.motion,
      shadows: shadows ?? this.shadows,
      decorations: decorations ?? this.decorations,
    );
  }

  @override
  BetterTokens lerp(covariant ThemeExtension<BetterTokens>? other, double t) {
    if (other is! BetterTokens) return this as BetterTokens;
    return BetterTokens(
      fontFamilies: t < 0.5 ? fontFamilies : other.fontFamilies,
      typeScale: t < 0.5 ? typeScale : other.typeScale,
      radii: t < 0.5 ? radii : other.radii,
      borders: t < 0.5 ? borders : other.borders,
      spacing: t < 0.5 ? spacing : other.spacing,
      motion: t < 0.5 ? motion : other.motion,
      shadows: t < 0.5 ? shadows : other.shadows,
      decorations: t < 0.5 ? decorations : other.decorations,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BetterTokens &&
            const DeepCollectionEquality()
                .equals(fontFamilies, other.fontFamilies) &&
            const DeepCollectionEquality().equals(typeScale, other.typeScale) &&
            const DeepCollectionEquality().equals(radii, other.radii) &&
            const DeepCollectionEquality().equals(borders, other.borders) &&
            const DeepCollectionEquality().equals(spacing, other.spacing) &&
            const DeepCollectionEquality().equals(motion, other.motion) &&
            const DeepCollectionEquality().equals(shadows, other.shadows) &&
            const DeepCollectionEquality()
                .equals(decorations, other.decorations));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(fontFamilies),
      const DeepCollectionEquality().hash(typeScale),
      const DeepCollectionEquality().hash(radii),
      const DeepCollectionEquality().hash(borders),
      const DeepCollectionEquality().hash(spacing),
      const DeepCollectionEquality().hash(motion),
      const DeepCollectionEquality().hash(shadows),
      const DeepCollectionEquality().hash(decorations),
    );
  }
}
