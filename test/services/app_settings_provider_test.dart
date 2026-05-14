import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakeup_english/core/constants/app_strings.dart';
import 'package:wakeup_english/core/services/app_settings_provider.dart';
import 'package:wakeup_english/features/alarm/domain/entities/alarm.dart';

void main() {
  test('loads saved default alarm settings', () async {
    SharedPreferences.setMockInitialValues({
      AppStrings.prefDefaultQuizCount: 7,
      AppStrings.prefDefaultDifficulty: 'hard',
      AppStrings.prefDefaultSnooze: 15,
      AppStrings.prefVibrationEnabled: false,
      AppStrings.prefGradualVolume: true,
    });

    final notifier = AppSettingsNotifier();
    await Future<void>.delayed(Duration.zero);

    expect(notifier.state.defaultQuizCount, 7);
    expect(notifier.state.defaultDifficulty, QuizDifficulty.hard);
    expect(notifier.state.defaultSnoozeMinutes, 15);
    expect(notifier.state.vibrationEnabled, false);
    expect(notifier.state.gradualVolumeEnabled, true);
  });

  test('persists updated default alarm settings', () async {
    SharedPreferences.setMockInitialValues({});
    final notifier = AppSettingsNotifier();
    await Future<void>.delayed(Duration.zero);

    await notifier.setDefaultQuizCount(5);
    await notifier.setDefaultDifficulty(QuizDifficulty.easy);
    await notifier.setDefaultSnoozeMinutes(10);
    await notifier.setVibrationEnabled(false);
    await notifier.setGradualVolumeEnabled(true);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getInt(AppStrings.prefDefaultQuizCount), 5);
    expect(prefs.getString(AppStrings.prefDefaultDifficulty), 'easy');
    expect(prefs.getInt(AppStrings.prefDefaultSnooze), 10);
    expect(prefs.getBool(AppStrings.prefVibrationEnabled), false);
    expect(prefs.getBool(AppStrings.prefGradualVolume), true);
  });
}
