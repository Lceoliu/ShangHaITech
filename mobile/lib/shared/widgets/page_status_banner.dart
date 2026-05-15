import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theming/context_extensions.dart';

enum PageStatusTone { neutral, info, success, warning, error }

({IconData icon, Color background, Color foreground}) _paletteForTone(
  ColorScheme cs,
  PageStatusTone tone,
) {
  return switch (tone) {
    PageStatusTone.success => (
        icon: Icons.check_circle_rounded,
        background: cs.primaryContainer,
        foreground: cs.onPrimaryContainer,
      ),
    PageStatusTone.warning => (
        icon: Icons.warning_amber_rounded,
        background: cs.tertiaryContainer,
        foreground: cs.onTertiaryContainer,
      ),
    PageStatusTone.error => (
        icon: Icons.error_rounded,
        background: cs.errorContainer,
        foreground: cs.onErrorContainer,
      ),
    PageStatusTone.info => (
        icon: Icons.sync_rounded,
        background: cs.secondaryContainer,
        foreground: cs.onSecondaryContainer,
      ),
    PageStatusTone.neutral => (
        icon: Icons.schedule_rounded,
        background: cs.surfaceContainerHigh,
        foreground: cs.onSurfaceVariant,
      ),
  };
}

class PageStatusBanner extends StatelessWidget {
  const PageStatusBanner({
    super.key,
    required this.label,
    required this.tone,
    this.updatedAt,
    this.loading = false,
  });

  final String label;
  final PageStatusTone tone;
  final DateTime? updatedAt;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final palette = _paletteForTone(cs, tone);
    final subtitle = updatedAt == null
        ? null
        : "上次更新 ${DateFormat('HH:mm').format(updatedAt!.toLocal())}";
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: palette.background,
        borderRadius: BorderRadius.circular(context.tokens.radii.sm),
      ),
      child: Row(
        children: [
          if (loading)
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: palette.foreground,
              ),
            )
          else
            Icon(palette.icon, size: 18, color: palette.foreground),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: palette.foreground,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: palette.foreground.withValues(alpha: 0.78),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingPageStatusNotice extends StatelessWidget {
  const FloatingPageStatusNotice({
    super.key,
    required this.label,
    required this.tone,
  });

  final String label;
  final PageStatusTone tone;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final palette = _paletteForTone(cs, tone);
    return IgnorePointer(
      child: SafeArea(
        bottom: false,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 68, 20, 0),
            child: Material(
              color: Colors.transparent,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: palette.background,
                  borderRadius: BorderRadius.circular(context.tokens.radii.sm),
                  boxShadow: [
                    BoxShadow(
                      color: cs.shadow.withValues(alpha: 0.12),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        palette.icon,
                        size: 18,
                        color: palette.foreground,
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: palette.foreground,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
