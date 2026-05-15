import 'package:flutter/material.dart';
import '../better_theme.dart';
import '../context_extensions.dart';

class ThemedDivider extends StatelessWidget {
  const ThemedDivider({super.key, this.indent = 0, this.endIndent = 0});
  final double indent;
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    return switch (context.variants.divider) {
      DividerVariant.hairline => _hairline(context),
      DividerVariant.asciiDashed => _asciiDashed(context),
      DividerVariant.bracketed =>
        throw UnimplementedError('DividerVariant.bracketed — implemented in Stage 5'),
    };
  }

  Widget _hairline(BuildContext context) {
    return Divider(
      height: context.tokens.spacing.md,
      thickness: context.tokens.borders.hairline,
      indent: indent,
      endIndent: endIndent,
      color: context.cs.outlineVariant,
    );
  }

  Widget _asciiDashed(BuildContext context) {
    final symbol = context.tokens.decorations?.dividerSymbol ?? '-';
    final cs = context.cs;
    final mono = context.tokens.fontFamilies.mono;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.tokens.spacing.xs),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final charWidth = 8.0;
          final count = constraints.maxWidth > 0
              ? (constraints.maxWidth / charWidth).floor()
              : 20;
          return Text(
            symbol * count,
            style: TextStyle(
              fontFamily: mono,
              fontSize: 11,
              color: cs.outlineVariant,
              letterSpacing: 2,
            ),
            overflow: TextOverflow.clip,
            maxLines: 1,
          );
        },
      ),
    );
  }
}
