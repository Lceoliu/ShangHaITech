import 'package:flutter/material.dart';

import '../../theming/context_extensions.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.terminalId,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  // Terminal mode label, e.g. 'more', 'mail'. Falls back to title if null.
  final String? terminalId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    if (context.isTerminalTheme) {
      final label = terminalId ?? title.toLowerCase();
      return Row(
        children: [
          Expanded(
            child: Text(
              '< better-skd ~ $label >',
              style: TextStyle(
                fontFamily: context.tokens.fontFamilies.mono,
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: cs.onSurface,
                letterSpacing: 0.5,
              ),
            ),
          ),
          trailing ?? const SizedBox.shrink(),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: cs.onSurface,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
        trailing ?? const SizedBox.shrink(),
      ],
    );
  }
}
