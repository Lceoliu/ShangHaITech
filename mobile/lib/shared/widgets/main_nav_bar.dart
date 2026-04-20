import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import '../../core/theme.dart';

// ── easeOutExpo curve ─────────────────────────────────────────────────────────
class _EaseOutExpo extends Curve {
  const _EaseOutExpo();
  @override
  double transformInternal(double t) =>
      t >= 1.0 ? 1.0 : 1.0 - math.pow(2.0, -10.0 * t).toDouble();
}

const _kCurve = _EaseOutExpo();

// ── Nav bar ───────────────────────────────────────────────────────────────────

class MainNavBar extends StatefulWidget {
  const MainNavBar({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  State<MainNavBar> createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar>
    with SingleTickerProviderStateMixin {
  static const _kItems = [
    (Icons.widgets_rounded, Icons.widgets_outlined, '更多'),
    (Icons.forum_rounded, Icons.forum_outlined, '论坛'),
    (Icons.home_rounded, Icons.home_outlined, '首页'),
    (Icons.auto_stories_rounded, Icons.auto_stories_outlined, '课程'),
    (Icons.person_rounded, Icons.person_outlined, '我的'),
  ];

  static const _kIndicatorSize = 40.0;
  static const _kHomeIndicatorSize = 44.0;
  static const _kItemCount = 5;

  late AnimationController _ctrl;
  late Tween<double> _tween;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 210),
    );
    _tween = Tween<double>(
      begin: widget.currentIndex.toDouble(),
      end: widget.currentIndex.toDouble(),
    );
  }

  @override
  void didUpdateWidget(MainNavBar old) {
    super.didUpdateWidget(old);
    if (old.currentIndex != widget.currentIndex) {
      // Capture the current animated value as the new starting point so
      // a mid-animation tap feels natural rather than snapping.
      final from = _tween.evaluate(
        CurvedAnimation(parent: _ctrl, curve: _kCurve),
      );
      _tween = Tween<double>(
        begin: from,
        end: widget.currentIndex.toDouble(),
      );
      _ctrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.surface.withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.10),
              blurRadius: 24,
              offset: Offset(0, 8),
              spreadRadius: -2,
            ),
            BoxShadow(
              color: context.adaptiveShadow,
              blurRadius: 14,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemW = constraints.maxWidth / _kItemCount;

            return AnimatedBuilder(
              animation: _ctrl,
              builder: (context, _) {
                final pos = _tween.evaluate(
                  CurvedAnimation(parent: _ctrl, curve: _kCurve),
                );

                // Proximity to the home tab (index 2): 0.0 → elsewhere, 1.0 → at home
                final homeProx = (1.0 - (pos - 2).abs()).clamp(0.0, 1.0);
                final indSize = lerpDouble(
                  _kIndicatorSize,
                  _kHomeIndicatorSize,
                  homeProx,
                )!;

                // Horizontal center of the indicator
                final indLeft = pos * itemW + (itemW - indSize) / 2;

                // Gradient: vivid at home, solid primary elsewhere
                final gradientEnd = Color.lerp(
                  colorScheme.primary,
                  colorScheme.primaryContainer,
                  homeProx,
                )!;

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // ── Sliding indicator ────────────────────────────────────
                    Positioned(
                      left: indLeft,
                      top: 4, // matches the SizedBox(4) spacer before the icon
                      child: Container(
                        width: indSize,
                        height: indSize,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [colorScheme.primary, gradientEnd],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(9999),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.primary.withValues(
                                alpha: 0.18 + homeProx * 0.14,
                              ),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                              spreadRadius: -2,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ── Tab items (sit above the indicator) ──────────────────
                    Row(
                      children: List.generate(_kItemCount, (i) {
                        final selected = i == widget.currentIndex;
                        final item = _kItems[i];
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => widget.onChanged(i),
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 4),
                                // Icon area — fixed height so all items align
                                SizedBox(
                                  height: _kHomeIndicatorSize,
                                  child: Center(
                                    child: AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 180,
                                      ),
                                      child: Icon(
                                        selected ? item.$1 : item.$2,
                                        key: ValueKey(selected),
                                        size: 22,
                                        color: selected
                                            ? colorScheme.onPrimary
                                            : colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 180),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: selected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: selected
                                        ? colorScheme.primary
                                        : colorScheme.onSurfaceVariant,
                                  ),
                                  child: Text(item.$3),
                                ),
                                const SizedBox(height: 2),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
