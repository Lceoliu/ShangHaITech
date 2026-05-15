import 'package:flutter/material.dart';

import '../context_extensions.dart';
import 'chrome_bundle.dart';

ChromeBundle terminalV1ChromeBundle() => ChromeBundle(
      bottomNav: (context, currentIndex, items, onTap) =>
          _TerminalNavBar(currentIndex: currentIndex, items: items, onTap: onTap),
    );

class _TerminalNavBar extends StatelessWidget {
  const _TerminalNavBar({
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });
  final int currentIndex;
  final List<NavTabItem> items;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final mono = context.tokens.fontFamilies.mono;
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: cs.surface,
          border: Border(
            top: BorderSide(color: cs.outlineVariant, width: 1),
          ),
        ),
        child: Row(
          children: List.generate(items.length, (i) {
            final selected = i == currentIndex;
            final item = items[i];
            return Expanded(
              child: GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: i < items.length - 1
                        ? Border(
                            right: BorderSide(
                              color: cs.outlineVariant.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        selected ? item.activeIcon : item.icon,
                        size: 18,
                        color: selected ? cs.error : cs.onSurfaceVariant,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label.toUpperCase(),
                        style: TextStyle(
                          fontFamily: mono,
                          fontSize: 10,
                          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                          color: selected ? cs.error : cs.onSurfaceVariant,
                          letterSpacing: 1,
                        ),
                      ),
                      if (item.badgeCount != null && item.badgeCount! > 0) ...[
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: cs.error, width: 1),
                            color: cs.error.withValues(alpha: 0.1),
                          ),
                          child: Text(
                            '${item.badgeCount}',
                            style: TextStyle(
                              fontFamily: mono,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: cs.error,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
