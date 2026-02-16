import 'package:flutter/material.dart';

/// Wraps a child widget and shakes it horizontally on trigger
class WrongAnswerShake extends StatefulWidget {
  final Widget child;
  final bool shake;

  const WrongAnswerShake({
    super.key,
    required this.child,
    this.shake = false,
  });

  @override
  State<WrongAnswerShake> createState() => _WrongAnswerShakeState();
}

class _WrongAnswerShakeState extends State<WrongAnswerShake>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -10), weight: 20),
      TweenSequenceItem(tween: Tween(begin: -10, end: 10), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 10, end: -8), weight: 20),
      TweenSequenceItem(tween: Tween(begin: -8, end: 6), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 6, end: 0), weight: 20),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(WrongAnswerShake oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shake && !oldWidget.shake) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
