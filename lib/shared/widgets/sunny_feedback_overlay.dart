import 'package:flutter/material.dart';

import '../../core/widgets/sunny.dart';

/// Drives a transient Sunny reaction overlay (wink/sad) for quiz feedback.
class SunnyFeedbackController extends ChangeNotifier {
  SunnyExpression? _active;
  SunnyExpression? get active => _active;

  void showCorrect() => _flash(SunnyExpression.wink);
  void showWrong() => _flash(SunnyExpression.sad);

  Future<void> _flash(SunnyExpression expression) async {
    _active = expression;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 800));
    _active = null;
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
            return Center(
              child: Sunny(expression: exp, size: 160),
            );
          },
        ),
      ],
    );
  }
}
