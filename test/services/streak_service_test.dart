import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakeup_english/core/constants/app_strings.dart';
import 'package:wakeup_english/core/services/streak_service.dart';

void main() {
  group('StreakService.getStreak', () {
    test('returns zeros when no data exists', () async {
      SharedPreferences.setMockInitialValues({});
      final streak = await StreakService.getStreak();
      expect(streak.currentStreak, 0);
      expect(streak.maxStreak, 0);
      expect(streak.lastCompletedDate, isNull);
    });

    test('returns stored values', () async {
      SharedPreferences.setMockInitialValues({
        AppStrings.prefStreakCurrent: 5,
        AppStrings.prefStreakMax: 10,
        AppStrings.prefStreakLastDate: '2026-03-01T00:00:00.000',
      });
      final streak = await StreakService.getStreak();
      expect(streak.currentStreak, 5);
      expect(streak.maxStreak, 10);
      expect(streak.lastCompletedDate, isNotNull);
    });
  });

  group('StreakService.recordCompletion', () {
    test('first ever completion → streak = 1', () async {
      SharedPreferences.setMockInitialValues({});
      final result = await StreakService.recordCompletion();
      expect(result.currentStreak, 1);
      expect(result.maxStreak, 1);
    });

    test('same day completion → streak unchanged', () async {
      final today = DateTime.now();
      final todayStr = DateTime(today.year, today.month, today.day).toIso8601String();
      SharedPreferences.setMockInitialValues({
        AppStrings.prefStreakCurrent: 5,
        AppStrings.prefStreakMax: 5,
        AppStrings.prefStreakLastDate: todayStr,
      });
      final result = await StreakService.recordCompletion();
      expect(result.currentStreak, 5);
    });

    test('consecutive day → streak increments', () async {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final yesterdayStr =
          DateTime(yesterday.year, yesterday.month, yesterday.day).toIso8601String();
      SharedPreferences.setMockInitialValues({
        AppStrings.prefStreakCurrent: 5,
        AppStrings.prefStreakMax: 10,
        AppStrings.prefStreakLastDate: yesterdayStr,
      });
      final result = await StreakService.recordCompletion();
      expect(result.currentStreak, 6);
    });

    test('2+ day gap → streak resets to 1', () async {
      final twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));
      final twoDaysAgoStr =
          DateTime(twoDaysAgo.year, twoDaysAgo.month, twoDaysAgo.day).toIso8601String();
      SharedPreferences.setMockInitialValues({
        AppStrings.prefStreakCurrent: 15,
        AppStrings.prefStreakMax: 20,
        AppStrings.prefStreakLastDate: twoDaysAgoStr,
      });
      final result = await StreakService.recordCompletion();
      expect(result.currentStreak, 1);
      // maxStreak should be preserved
      expect(result.maxStreak, 20);
    });

    test('new max streak is recorded', () async {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final yesterdayStr =
          DateTime(yesterday.year, yesterday.month, yesterday.day).toIso8601String();
      SharedPreferences.setMockInitialValues({
        AppStrings.prefStreakCurrent: 9,
        AppStrings.prefStreakMax: 9,
        AppStrings.prefStreakLastDate: yesterdayStr,
      });
      final result = await StreakService.recordCompletion();
      expect(result.currentStreak, 10);
      expect(result.maxStreak, 10);
    });

    test('incrementing streak does not exceed existing max', () async {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final yesterdayStr =
          DateTime(yesterday.year, yesterday.month, yesterday.day).toIso8601String();
      SharedPreferences.setMockInitialValues({
        AppStrings.prefStreakCurrent: 3,
        AppStrings.prefStreakMax: 20,
        AppStrings.prefStreakLastDate: yesterdayStr,
      });
      final result = await StreakService.recordCompletion();
      expect(result.currentStreak, 4);
      expect(result.maxStreak, 20);
    });
  });
}
