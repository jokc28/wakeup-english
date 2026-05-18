import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_shape.dart';
import '../../core/widgets/sunny.dart';

/// Drives a transient Sunny reaction overlay (wink/sad) for quiz feedback.
/// Optionally carries a short message to show inside a speech bubble.
class SunnyFeedbackController extends ChangeNotifier {
  SunnyExpression? _active;
  String? _message;

  SunnyExpression? get active => _active;
  String? get message => _message;

  void showCorrect({String? message}) =>
      _flash(SunnyExpression.wink, message);
  void showWrong({String? message}) =>
      _flash(SunnyExpression.sad, message);

  Future<void> _flash(SunnyExpression expression, String? message) async {
    _active = expression;
    _message = message;
    notifyListeners();
    // Longer dwell when a message is present so the user has time to read it.
    final duration =
        message == null ? 800 : 1200;
    await Future<void>.delayed(Duration(milliseconds: duration));
    _active = null;
    _message = null;
    notifyListeners();
  }
}

/// Stacks a centered Sunny reaction on top of [child]. Reaction is driven by
/// [controller] which can be invoked from anywhere with access to the same
/// instance.
class SunnyFeedbackOverlay extends StatelessWidget {
  const SunnyFeedbackOverlay({
    required this.controller,
    required this.child,
    super.key,
  });

  final SunnyFeedbackController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            final exp = controller.active;
            if (exp == null) return const SizedBox.shrink();
            final msg = controller.message;
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Sunny(expression: exp, size: 160),
                  if (msg != null) ...[
                    const SizedBox(height: 12),
                    _SpeechBubble(text: msg),
                  ],
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SpeechBubble extends StatelessWidget {
  const _SpeechBubble({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppShape.radiusL),
        boxShadow: AppElevation.cardSoft,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.25),
          width: 1.5,
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimaryLight,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
