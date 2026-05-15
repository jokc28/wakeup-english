import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wakeup_english/shared/widgets/sunny_feedback_overlay.dart';

void main() {
  testWidgets('SunnyFeedbackOverlay shows wink on correct', (tester) async {
    final controller = SunnyFeedbackController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SunnyFeedbackOverlay(
          controller: controller,
          child: const SizedBox.expand(),
        ),
      ),
    ));

    controller.showCorrect();
    await tester.pump();
    expect(find.byKey(const Key('sunny-wink')), findsOneWidget);

    // Drain the 800ms hide timer so the test tear-down doesn't complain.
    await tester.pump(const Duration(milliseconds: 900));
  });

  testWidgets('SunnyFeedbackOverlay shows sad on wrong', (tester) async {
    final controller = SunnyFeedbackController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SunnyFeedbackOverlay(
          controller: controller,
          child: const SizedBox.expand(),
        ),
      ),
    ));

    controller.showWrong();
    await tester.pump();
    expect(find.byKey(const Key('sunny-sad')), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 900));
  });
}
