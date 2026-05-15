// Captures Play Store / App Store screenshots by navigating via the router
// (no UI taps — avoids brittle widget finders) and saving a PNG at each stop.
//
// Run with:
//   ./scripts/capture-screenshots.sh <device-id>

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
    // Use pump() with a fixed duration instead of pumpAndSettle so the
    // continuous animations on the paywall do not block the test.
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
        ],
        child: const OkMorningApp(),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // 1) Home (alarm list) — initial route.
    await shoot(tester, '01_home');

    // 2) Add alarm screen.
    await go(tester, AppStrings.alarmAddRoute);
    await shoot(tester, '02_alarm_add');

    // 3) Settings.
    await go(tester, AppStrings.settingsRoute);
    await shoot(tester, '03_settings');

    // 4) Paywall.
    await go(tester, AppStrings.paywallRoute);
    await shoot(tester, '04_paywall');
  });
}
