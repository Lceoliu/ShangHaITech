import 'package:flutter/material.dart';
import '../better_theme.dart';
import '../context_extensions.dart';

class ThemedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ThemedAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle,
  });
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool? centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return switch (context.variants.appBar) {
      AppBarVariant.transparent => _transparent(context),
      AppBarVariant.terminalTitle => _terminalTitle(context),
      AppBarVariant.illustrated =>
        throw UnimplementedError('AppBarVariant.illustrated — implemented in Stage 5'),
    };
  }

  Widget _transparent(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
      leading: leading,
      centerTitle: centerTitle,
    );
  }

  Widget _terminalTitle(BuildContext context) {
    final cs = context.cs;
    final mono = context.tokens.fontFamilies.mono;
    final now = DateTime.now();
    final dateStr =
        '${now.year}.${now.month.toString().padLeft(2, '0')}.${now.day.toString().padLeft(2, '0')}';
    final titleBar = '< better-skd ~ $title $dateStr >';
    return AppBar(
      backgroundColor: cs.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Text(
        titleBar,
        style: TextStyle(
          fontFamily: mono,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: cs.onSurface,
          letterSpacing: 0.5,
        ),
      ),
      leading: leading,
      actions: actions,
      centerTitle: true,
    );
  }
}
