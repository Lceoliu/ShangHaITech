import 'package:flutter/material.dart';

import 'better_theme.dart';
import 'chrome/chrome_bundle.dart';
import 'home/home_slot_bundle.dart';
import 'tokens/better_tokens.dart';
import 'tokens/subject_accents.dart';
import 'tokens/variant_bundle.dart';

extension BetterContextX on BuildContext {
  ColorScheme get cs => Theme.of(this).colorScheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  BetterTokens get tokens => Theme.of(this).extension<BetterTokens>()!;
  SubjectAccentScheme get subjects =>
      Theme.of(this).extension<SubjectAccentScheme>()!;
  VariantSet get variants =>
      Theme.of(this).extension<VariantBundleExtension>()!.set;
  HomeStyleId get homeStyle => variants.homeStyle;
  ChromeStyleId get chromeStyle => variants.chromeStyle;
  bool get isTerminalTheme =>
      homeStyle == HomeStyleId.terminalV1 ||
      chromeStyle == ChromeStyleId.terminalV1;
}
