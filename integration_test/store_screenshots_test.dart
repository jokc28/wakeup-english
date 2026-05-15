// Captures Play Store / App Store screenshots by driving the app through its
// key screens and saving a PNG at each stop.
//
// Run with:
//   flutter test integration_test/store_screenshots_test.dart \
//     --device-id <emulator-id>
//
// Screenshots are saved by IntegrationTestWidgetsFlutterBinding under
// build/integration_response_data/ on Android, or as test artifacts in CI.
// Use the helper script scripts/capture-screenshots.sh for the full flow.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:wakeup_english/app.dart';
import 'package:wakeup_english/core/constants/app_strings.dart';
import 'package:wakeup_english/core/router/app_router.dart';
import 'package:wakeup_english/core/services/alarm_service.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> shoot(WidgetTester tester, String name) async {
    await tester.pumpAndSettle(const Duration(milliseconds: 500));
    await binding.takeScreenshot(name);
  }

  testWidgets('store screenshots', (tester) async {
    await AlarmService.initialize();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          firstLaunchCompleteProvider.overrideWith((ref) => true),
        ],
        child: const OkMorningApp(),
      ),
    );
    await tester.pumpAndSettle();

    // 1) Empty alarm list — the main entry screen.
    await shoot(tester, '01_home_empty');

    // 2) Alarm add/edit screen — shows the mission configuration.
    await tester.tap(find.text('알람 추가'));
    await tester.pumpAndSettle();
    await shoot(tester, '02_alarm_edit');

    // Back to home.
    AppRouter.router.go(AppStrings.alarmListRoute);
    await tester.pumpAndSettle();

    // 3) Settings — language, sounds, account links.
    AppRouter.router.go(AppStrings.settingsRoute);
    await tester.pumpAndSettle();
    await shoot(tester, '03_settings');

    // 4) Paywall — premium pitch.
    await AppRouter.router.push(AppStrings.paywallRoute);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await shoot(tester, '04_paywall');

    // Optional further screens (quiz lock, onboarding) can be added here
    // once driving them in test mode is stable.
  });
}
