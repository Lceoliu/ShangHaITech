import 'package:flutter/material.dart';
import '../better_theme.dart';
import '../context_extensions.dart';

class ThemedCard extends StatelessWidget {
  const ThemedCard({super.key, required this.child, this.padding, this.onTap});
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return switch (context.variants.card) {
      CardVariant.material => _material(context),
      CardVariant.outlinedSharp => _outlinedSharp(context),
      CardVariant.glass =>
        throw UnimplementedError('CardVariant.glass — implemented in Stage 5'),
      CardVariant.neumorphic =>
        throw UnimplementedError('CardVariant.neumorphic — implemented in Stage 5'),
    };
  }

  Widget _material(BuildContext context) {
    final card = Card(
      child: Padding(
        padding: padding ?? EdgeInsets.all(context.tokens.spacing.md),
        child: child,
      ),
    );
    if (onTap == null) return card;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.tokens.radii.lg),
      child: card,
    );
  }

  Widget _outlinedSharp(BuildContext context) {
    final t = context.tokens;
    final cs = context.cs;
    final ornament = t.decorations?.cornerOrnament;
    final inner = Container(
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant, width: t.borders.thin),
        borderRadius: BorderRadius.circular(t.radii.none),
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(t.spacing.md),
        child: child,
      ),
    );
    final box = ornament != null
        ? Stack(
            children: [
              inner,
              Positioned(
                top: 2,
                left: 6,
                child: Text(
                  ornament,
                  style: TextStyle(
                    fontFamily: t.fontFamilies.mono,
                    fontSize: 11,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          )
        : inner;
    if (onTap == null) return box;
    return InkWell(onTap: onTap, child: box);
  }
}
