import 'package:flutter/material.dart';

class AnimatedCardEntry extends StatefulWidget {
  const AnimatedCardEntry({
    super.key,
    required this.index,
    required this.child,
    this.staggerMs = 50,
    this.maxStaggerCount = 8,
    this.duration = const Duration(milliseconds: 440),
    this.offsetY = 20.0,
  });

  final int index;
  final Widget child;
  final int staggerMs;
  final int maxStaggerCount;
  final Duration duration;
  final double offsetY;

  @override
  State<AnimatedCardEntry> createState() => _AnimatedCardEntryState();
}

class _AnimatedCardEntryState extends State<AnimatedCardEntry>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    final reduceMotion = WidgetsBinding
        .instance.platformDispatcher.accessibilityFeatures.disableAnimations;
    
    _ctrl = AnimationController(
      vsync: this,
      duration: reduceMotion ? Duration.zero : widget.duration,
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack);

    if (reduceMotion) {
      _ctrl.forward();
    } else {
      final stagger = (widget.index % widget.maxStaggerCount) * widget.staggerMs;
      Future.delayed(Duration(milliseconds: stagger), () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, child) {
        final t = _anim.value;
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1 - t) * widget.offsetY),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
