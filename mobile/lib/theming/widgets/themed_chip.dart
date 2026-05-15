import 'package:flutter/material.dart';
import '../better_theme.dart';
import '../context_extensions.dart';

class ThemedChip extends StatelessWidget {
  const ThemedChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.icon,
  });
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return switch (context.variants.chip) {
      ChipVariant.stadium => _stadium(context),
      ChipVariant.bracketed => _bracketed(context),
      ChipVariant.square =>
        throw UnimplementedError('ChipVariant.square — implemented in Stage 5'),
    };
  }

  Widget _stadium(BuildContext context) {
    return InputChip(
      label: Text(label),
      avatar: icon == null ? null : Icon(icon, size: 16),
      selected: selected,
      onPressed: onTap,
    );
  }

  Widget _bracketed(BuildContext context) {
    final cs = context.cs;
    final mono = context.tokens.fontFamilies.mono;
    final display = selected ? '[ $label ]' : '< $label >';
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.tokens.spacing.xs,
          vertical: context.tokens.spacing.xxs,
        ),
        child: Text(
          display,
          style: TextStyle(
            fontFamily: mono,
            fontSize: 13,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? cs.error : cs.onSurface,
          ),
        ),
      ),
    );
  }
}
