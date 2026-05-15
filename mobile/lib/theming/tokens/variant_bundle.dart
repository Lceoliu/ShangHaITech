import 'package:flutter/material.dart';
import '../better_theme.dart';

class VariantBundleExtension extends ThemeExtension<VariantBundleExtension> {
  const VariantBundleExtension(this.set);
  final VariantSet set;

  @override
  VariantBundleExtension copyWith({VariantSet? set}) =>
      VariantBundleExtension(set ?? this.set);

  @override
  VariantBundleExtension lerp(
      ThemeExtension<VariantBundleExtension>? other, double t) {
    if (other is! VariantBundleExtension) return this;
    return t < 0.5 ? this : other;
  }
}
