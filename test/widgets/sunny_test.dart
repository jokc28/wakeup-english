import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wakeup_english/core/widgets/sunny.dart';

void main() {
  testWidgets('Sunny renders an SVG matching its expression', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Sunny(expression: SunnyExpression.smile, size: 80),
        ),
      ),
    );
    expect(find.byKey(const Key('sunny-smile')), findsOneWidget);
  });

  testWidgets('Sunny switches asset when expression changes', (tester) async {
    final state = ValueNotifier<SunnyExpression>(SunnyExpression.smile);
    addTearDown(state.dispose);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ValueListenableBuilder<SunnyExpression>(
          valueListenable: state,
          builder: (_, value, __) => Sunny(expression: value, size: 80),
        ),
      ),
    ));
    expect(find.byKey(const Key('sunny-smile')), findsOneWidget);

    state.value = SunnyExpression.sad;
    await tester.pump();
    expect(find.byKey(const Key('sunny-sad')), findsOneWidget);
    expect(find.byKey(const Key('sunny-smile')), findsNothing);
  });
}
