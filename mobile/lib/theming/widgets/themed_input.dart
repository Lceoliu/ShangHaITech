import 'package:flutter/material.dart';
import '../better_theme.dart';
import '../context_extensions.dart';

class ThemedInput extends StatelessWidget {
  const ThemedInput({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.obscureText = false,
    this.onChanged,
    this.maxLines = 1,
    this.minLines,
    this.decoration,
  });
  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final int? minLines;
  final InputDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return switch (context.variants.input) {
      InputVariant.filled => _filled(context),
      InputVariant.underline =>
        throw UnimplementedError('InputVariant.underline — implemented in Stage 5'),
      InputVariant.monospaceFramed => _monospaceFramed(context),
    };
  }

  Widget _filled(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      decoration: decoration ??
          InputDecoration(
            labelText: label,
            hintText: hintText,
          ),
    );
  }

  Widget _monospaceFramed(BuildContext context) {
    final cs = context.cs;
    final t = context.tokens;
    final mono = t.fontFamilies.mono;
    return TextField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      cursorWidth: t.borders.thin,
      style: TextStyle(
        fontFamily: mono,
        fontSize: 14,
        color: cs.onSurface,
      ),
      decoration: (decoration ??
              const InputDecoration())
          .copyWith(
            filled: false,
            fillColor: Colors.transparent,
            labelText: label,
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: mono,
              fontSize: 14,
              color: cs.onSurfaceVariant,
            ),
            labelStyle: TextStyle(
              fontFamily: mono,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(t.radii.none),
              borderSide: BorderSide(color: cs.outlineVariant, width: t.borders.thin),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(t.radii.none),
              borderSide: BorderSide(color: cs.outlineVariant, width: t.borders.thin),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(t.radii.none),
              borderSide: BorderSide(color: cs.onSurface, width: t.borders.regular),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: t.spacing.md,
              vertical: t.spacing.sm + 2,
            ),
          ),
    );
  }
}
