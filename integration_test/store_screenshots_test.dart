// Captures Play Store / App Store screenshots by navigating via the router
// and saving a PNG at each stop.  Two sample alarms are injected via Riverpod
// override so the home screen shows real content instead of the empty state.
//
// Run with:
//   ./scripts/capture-screenshots.sh <device-id>

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:wakeup_english/app.dart';
import 'package:wakeup_english/core/constants/app_strings.dart';
import 'package:wakeup_english/core/router/app_router.dart';
import 'package:wakeup_english/core/services/alarm_service.dart';
import 'package:wakeup_english/features/alarm/domain/entities/alarm.dart';
import 'package:wakeup_english/features/alarm/presentation/providers/alarm_provider.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final sampleAlarms = <AlarmEntity>[
    const AlarmEntity(
      id: 1,
      label: '평일 기상',
      time: TimeOfDay(hour: 7, minute: 0),
      repeatDays: [0, 1, 2, 3, 4],
      quizCount: 3,
    ),
    const AlarmEntity(
      id: 2,
      label: '주말 늦잠 방지',
      time: TimeOfDay(hour: 8, minute: 30),
      repeatDays: [5, 6],
      quizCount: 5,
      quizDifficulty: QuizDifficulty.hard,
    ),
  ];

  Future<void> shoot(WidgetTester tester, String name) async {
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pump(const Duration(milliseconds: 800));
    await binding.takeScreenshot(name);
  }

  Future<void> go(WidgetTester tester, String route) async {
    AppRouter.router.go(route);
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pump(const Duration(milliseconds: 800));
  }

  testWidgets('store screenshots', (tester) async {
    await AlarmService.initialize();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          firstLaunchCompleteProvider.overrideWith((ref) => true),
          alarmsProvider.overrideWith((ref) => Stream.value(sampleAlarms)),
        ],
        child: const OkMorningApp(),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // 1) Home with sample alarms — primary value showcase.
    await shoot(tester, '01_home');

    // 2) Add alarm screen — shows mission configuration.
    await go(tester, AppStrings.alarmAddRoute);
    await shoot(tester, '02_alarm_add');

    // 3) Settings — language, sounds, mission types.
    await go(tester, AppStrings.settingsRoute);
    await shoot(tester, '03_settings');

    // 4) Paywall — premium pitch with placeholder pricing.
    await go(tester, AppStrings.paywallRoute);
    await shoot(tester, '04_paywall');
  });
}
