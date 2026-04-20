import 'package:flutter/material.dart';

/// A floating action button that fades + scales into view once the user
/// scrolls past [threshold] pixels, and smoothly scrolls back to the top
/// when tapped.
///
/// Usage:
/// ```dart
/// Scaffold(
///   floatingActionButton: ScrollToTopFab(controller: _scrollController),
///   body: ListView(...),
/// )
/// ```
class ScrollToTopFab extends StatefulWidget {
  const ScrollToTopFab({
    super.key,
    required this.controller,
    this.threshold = 500.0,
  });

  final ScrollController controller;
  final double threshold;

  @override
  State<ScrollToTopFab> createState() => _ScrollToTopFabState();
}

class _ScrollToTopFabState extends State<ScrollToTopFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _anim, curve: Curves.easeOutBack),
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _anim, curve: Curves.easeOut),
    );
    widget.controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    _anim.dispose();
    super.dispose();
  }

  bool _visible = false;

  void _onScroll() {
    if (!widget.controller.hasClients) return;
    final shouldShow = widget.controller.offset > widget.threshold;
    if (shouldShow == _visible) return;
    _visible = shouldShow;
    if (shouldShow) {
      _anim.forward();
    } else {
      _anim.reverse();
    }
  }

  void _scrollToTop() {
    widget.controller.animateTo(
      0,
      duration: const Duration(milliseconds: 480),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        if (_anim.value == 0.0) return const SizedBox.shrink();
        return Opacity(
          opacity: _opacity.value,
          child: Transform.scale(
            scale: _scale.value,
            child: FloatingActionButton.small(
              heroTag: 'scroll_to_top_fab',
              onPressed: _scrollToTop,
              backgroundColor: cs.surface,
              foregroundColor: cs.primary,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.keyboard_arrow_up_rounded, size: 24),
            ),
          ),
        );
      },
    );
  }
}
