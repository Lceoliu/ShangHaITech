// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject_accents.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$SubjectAccentSchemeTailorMixin on ThemeExtension<SubjectAccentScheme> {
  SubjectAccent get computer;
  SubjectAccent get bio;
  SubjectAccent get design;
  SubjectAccent get chemistry;
  SubjectAccent get physics;
  SubjectAccent get math;
  SubjectAccent get economics;
  SubjectAccent get engineering;
  SubjectAccent get fallback;

  @override
  SubjectAccentScheme copyWith({
    SubjectAccent? computer,
    SubjectAccent? bio,
    SubjectAccent? design,
    SubjectAccent? chemistry,
    SubjectAccent? physics,
    SubjectAccent? math,
    SubjectAccent? economics,
    SubjectAccent? engineering,
    SubjectAccent? fallback,
  }) {
    return SubjectAccentScheme(
      computer: computer ?? this.computer,
      bio: bio ?? this.bio,
      design: design ?? this.design,
      chemistry: chemistry ?? this.chemistry,
      physics: physics ?? this.physics,
      math: math ?? this.math,
      economics: economics ?? this.economics,
      engineering: engineering ?? this.engineering,
      fallback: fallback ?? this.fallback,
    );
  }

  @override
  SubjectAccentScheme lerp(
      covariant ThemeExtension<SubjectAccentScheme>? other, double t) {
    if (other is! SubjectAccentScheme) return this as SubjectAccentScheme;
    return SubjectAccentScheme(
      computer: t < 0.5 ? computer : other.computer,
      bio: t < 0.5 ? bio : other.bio,
      design: t < 0.5 ? design : other.design,
      chemistry: t < 0.5 ? chemistry : other.chemistry,
      physics: t < 0.5 ? physics : other.physics,
      math: t < 0.5 ? math : other.math,
      economics: t < 0.5 ? economics : other.economics,
      engineering: t < 0.5 ? engineering : other.engineering,
      fallback: t < 0.5 ? fallback : other.fallback,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SubjectAccentScheme &&
            const DeepCollectionEquality().equals(computer, other.computer) &&
            const DeepCollectionEquality().equals(bio, other.bio) &&
            const DeepCollectionEquality().equals(design, other.design) &&
            const DeepCollectionEquality().equals(chemistry, other.chemistry) &&
            const DeepCollectionEquality().equals(physics, other.physics) &&
            const DeepCollectionEquality().equals(math, other.math) &&
            const DeepCollectionEquality().equals(economics, other.economics) &&
            const DeepCollectionEquality()
                .equals(engineering, other.engineering) &&
            const DeepCollectionEquality().equals(fallback, other.fallback));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(computer),
      const DeepCollectionEquality().hash(bio),
      const DeepCollectionEquality().hash(design),
      const DeepCollectionEquality().hash(chemistry),
      const DeepCollectionEquality().hash(physics),
      const DeepCollectionEquality().hash(math),
      const DeepCollectionEquality().hash(economics),
      const DeepCollectionEquality().hash(engineering),
      const DeepCollectionEquality().hash(fallback),
    );
  }
}
