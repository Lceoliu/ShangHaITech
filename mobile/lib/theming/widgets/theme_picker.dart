import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../better_theme.dart';
import '../context_extensions.dart';
import '../controller/theme_controller.dart';
import '../registry.dart';

class ThemePickerCard extends ConsumerWidget {
  const ThemePickerCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeId = ref.watch(activeThemeIdProvider);
    final themes = ThemeRegistry.all;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: themes.map((theme) {
        final isActive = theme.id == activeId;
        return _ThemeTile(
          theme: theme,
          isActive: isActive,
          onTap: () =>
              ref.read(activeThemeIdProvider.notifier).setTheme(theme.id),
        );
      }).toList(),
    );
  }
}

class _ThemeTile extends StatelessWidget {
  const _ThemeTile({
    required this.theme,
    required this.isActive,
    required this.onTap,
  });
  final BetterTheme theme;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final t = context.tokens;
    final swatch = theme.preview?.swatch ?? [cs.primary, cs.surface];
    final brightnessLabel =
        theme.brightness == Brightness.dark ? '暗色' : '亮色';

    return Padding(
      padding: EdgeInsets.only(bottom: t.spacing.xs),
      child: Material(
        color: isActive ? cs.primaryContainer.withValues(alpha: 0.18) : cs.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(t.radii.sm),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(t.radii.sm),
          child: Padding(
            padding: EdgeInsets.all(t.spacing.sm + 2),
            child: Row(
              children: [
                _SwatchStrip(colors: swatch),
                SizedBox(width: t.spacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              theme.name,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: cs.onSurface,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: cs.surfaceContainerHigh,
                              borderRadius:
                                  BorderRadius.circular(t.radii.pill),
                            ),
                            child: Text(
                              brightnessLabel,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: t.spacing.xxs),
                      Text(
                        theme.authorName ?? 'better-skd',
                        style: TextStyle(
                          fontSize: 12,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                      if (theme.description != null) ...[
                        SizedBox(height: t.spacing.xxs),
                        Text(
                          theme.description!,
                          style: TextStyle(
                            fontSize: 11,
                            color: cs.onSurfaceVariant.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: t.spacing.xs),
                Icon(
                  isActive ? Icons.check_circle_rounded : Icons.circle_outlined,
                  size: 20,
                  color: isActive ? cs.primary : cs.outlineVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SwatchStrip extends StatelessWidget {
  const _SwatchStrip({required this.colors});
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(t.radii.xs),
        border: Border.all(
          color: context.cs.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(t.radii.xs - 1),
        child: Row(
          children: colors
              .take(5)
              .map((c) => Expanded(child: Container(color: c)))
              .toList(),
        ),
      ),
    );
  }
}
