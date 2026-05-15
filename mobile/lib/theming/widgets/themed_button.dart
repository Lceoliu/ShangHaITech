import 'package:flutter/material.dart';
import '../better_theme.dart';
import '../context_extensions.dart';

enum ThemedButtonStyle { primary, secondary, ghost }

class ThemedButton extends StatelessWidget {
  const ThemedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.style = ThemedButtonStyle.primary,
    this.icon,
  });
  final String label;
  final VoidCallback? onPressed;
  final ThemedButtonStyle style;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return switch (context.variants.button) {
      ButtonVariant.material => _material(context),
      ButtonVariant.boxedMonospace => _boxedMonospace(context),
      ButtonVariant.ghost =>
        throw UnimplementedError('ButtonVariant.ghost — implemented in Stage 5'),
      ButtonVariant.neonOutline =>
        throw UnimplementedError('ButtonVariant.neonOutline — implemented in Stage 5'),
    };
  }

  Widget _material(BuildContext context) {
    final child = icon == null
        ? Text(label)
        : Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 18),
            SizedBox(width: context.tokens.spacing.xs),
            Text(label),
          ]);
    return switch (style) {
      ThemedButtonStyle.primary => FilledButton(onPressed: onPressed, child: child),
      ThemedButtonStyle.secondary => OutlinedButton(onPressed: onPressed, child: child),
      ThemedButtonStyle.ghost => TextButton(onPressed: onPressed, child: child),
    };
  }

  Widget _boxedMonospace(BuildContext context) {
    final t = context.tokens;
    final cs = context.cs;
    final labelStyle = TextStyle(
      fontFamily: t.fontFamilies.mono,
      fontSize: 13,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.2,
    );
    final content = Row(mainAxisSize: MainAxisSize.min, children: [
      if (icon != null) ...[Icon(icon, size: 16), SizedBox(width: t.spacing.xs)],
      Text(label.toUpperCase(), style: labelStyle),
    ]);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: cs.onSurface,
        backgroundColor: cs.surface,
        side: BorderSide(color: cs.outlineVariant, width: t.borders.thin),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(t.radii.none),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: t.spacing.lg,
          vertical: t.spacing.sm,
        ),
      ),
      child: content,
    );
  }
}
