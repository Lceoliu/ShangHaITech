import 'package:flutter/material.dart';

import 'home/home_slot_bundle.dart';
import 'chrome/chrome_bundle.dart';

class BetterTheme {
  const BetterTheme({
    required this.id,
    required this.name,
    required this.brightness,
    required this.buildThemeData,
    required this.variants,
    required this.homeStyle,
    required this.chromeStyle,
    this.preview,
    this.authorName,
    this.description,
  });

  final String id;
  final String name;
  final Brightness brightness;
  final ThemeData Function() buildThemeData;
  final VariantSet variants;
  final HomeStyleId homeStyle;
  final ChromeStyleId chromeStyle;
  final ThemePreview? preview;
  final String? authorName;
  final String? description;
}

class ThemePreview {
  const ThemePreview({this.thumbnailAsset, required this.swatch});
  final String? thumbnailAsset;
  final List<Color> swatch;
}

class VariantSet {
  const VariantSet({
    this.card = CardVariant.material,
    this.button = ButtonVariant.material,
    this.chip = ChipVariant.stadium,
    this.input = InputVariant.filled,
    this.divider = DividerVariant.hairline,
    this.appBar = AppBarVariant.transparent,
    this.nav = NavVariant.material,
    this.homeStyle = HomeStyleId.sunlitV1,
    this.chromeStyle = ChromeStyleId.sunlitV1,
  });
  final CardVariant card;
  final ButtonVariant button;
  final ChipVariant chip;
  final InputVariant input;
  final DividerVariant divider;
  final AppBarVariant appBar;
  final NavVariant nav;
  final HomeStyleId homeStyle;
  final ChromeStyleId chromeStyle;
}

enum CardVariant { material, outlinedSharp, glass, neumorphic }

enum ButtonVariant { material, boxedMonospace, ghost, neonOutline }

enum ChipVariant { stadium, bracketed, square }

enum InputVariant { filled, underline, monospaceFramed }

enum DividerVariant { hairline, asciiDashed, bracketed }

enum AppBarVariant { transparent, terminalTitle, illustrated }

enum NavVariant { material, capsLabel, dock }
