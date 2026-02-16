import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// A brief green flash overlay shown on correct answer
class CorrectAnswerOverlay extends StatefulWidget {
  final VoidCallback onComplete;

  const CorrectAnswerOverlay({super.key, required this.onComplete});

  @override
  State<CorrectAnswerOverlay> createState() => _CorrectAnswerOverlayState();
}

class _CorrectAnswerOverlayState extends State<CorrectAnswerOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 0.25), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 0.25, end: 0), weight: 60),
    ]).animate(_controller);

    _controller.forward().then((_) => widget.onComplete());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacity,
      builder: (context, child) {
        return IgnorePointer(
          child: Container(
            color: AppColors.quizCorrect.withValues(alpha: _opacity.value),
          ),
        );
      },
    );
  }
}
