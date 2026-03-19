import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakeup_english/core/constants/iap_constants.dart';
import 'package:wakeup_english/core/services/subscription_service.dart';

void main() {
  late SubscriptionService service;

  setUp(() {
    service = SubscriptionService();
  });

  group('isTrialActive', () {
    test('no trial_start_date → returns false', () async {
      SharedPreferences.setMockInitialValues({});
      final result = await service.isTrialActive();
      expect(result, isFalse);
    });

    test('trial_start_date is today → returns true', () async {
      SharedPreferences.setMockInitialValues({
        IapConstants.prefTrialStartDate: DateTime.now().toIso8601String(),
      });
      final result = await service.isTrialActive();
      expect(result, isTrue);
    });

    test('trial_start_date is 6 days ago → returns true', () async {
      final sixDaysAgo = DateTime.now().subtract(const Duration(days: 6));
      SharedPreferences.setMockInitialValues({
        IapConstants.prefTrialStartDate: sixDaysAgo.toIso8601String(),
      });
      final result = await service.isTrialActive();
      expect(result, isTrue);
    });

    test('trial_start_date is 7 days ago → returns false (expired)', () async {
      final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
      SharedPreferences.setMockInitialValues({
        IapConstants.prefTrialStartDate: sevenDaysAgo.toIso8601String(),
      });
      final result = await service.isTrialActive();
      expect(result, isFalse);
    });

    test('trial_start_date is 8 days ago → returns false', () async {
      final eightDaysAgo = DateTime.now().subtract(const Duration(days: 8));
      SharedPreferences.setMockInitialValues({
        IapConstants.prefTrialStartDate: eightDaysAgo.toIso8601String(),
      });
      final result = await service.isTrialActive();
      expect(result, isFalse);
    });

    test('trial_start_date is in the future → returns true', () async {
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      SharedPreferences.setMockInitialValues({
        IapConstants.prefTrialStartDate: tomorrow.toIso8601String(),
      });
      final result = await service.isTrialActive();
      expect(result, isTrue);
    });

    test('malformed trial_start_date → returns false (handles gracefully)', () async {
      SharedPreferences.setMockInitialValues({
        IapConstants.prefTrialStartDate: 'not-a-date',
      });
      final result = await service.isTrialActive();
      expect(result, isFalse);
    });
  });

  group('trialDaysRemaining', () {
    test('no trial_start_date → returns 0', () async {
      SharedPreferences.setMockInitialValues({});
      final result = await service.trialDaysRemaining;
      expect(result, 0);
    });

    test('trial started today → returns ~7 days', () async {
      SharedPreferences.setMockInitialValues({
        IapConstants.prefTrialStartDate: DateTime.now().toIso8601String(),
      });
      final result = await service.trialDaysRemaining;
      // Could be 6 or 7 depending on time of day (inDays truncates)
      expect(result, inInclusiveRange(6, 7));
    });

    test('trial started 6 days ago → returns 1 or 0', () async {
      final sixDaysAgo = DateTime.now().subtract(const Duration(days: 6));
      SharedPreferences.setMockInitialValues({
        IapConstants.prefTrialStartDate: sixDaysAgo.toIso8601String(),
      });
      final result = await service.trialDaysRemaining;
      expect(result, inInclusiveRange(0, 1));
    });

    test('trial expired → returns 0', () async {
      final tenDaysAgo = DateTime.now().subtract(const Duration(days: 10));
      SharedPreferences.setMockInitialValues({
        IapConstants.prefTrialStartDate: tenDaysAgo.toIso8601String(),
      });
      final result = await service.trialDaysRemaining;
      expect(result, 0);
    });
  });

  group('recordTrialStart', () {
    test('records trial start date when none exists', () async {
      SharedPreferences.setMockInitialValues({});
      await SubscriptionService.recordTrialStart();
      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getString(IapConstants.prefTrialStartDate);
      expect(stored, isNotNull);
      // Should be parseable as a DateTime
      expect(() => DateTime.parse(stored!), returnsNormally);
    });

    test('does NOT overwrite existing trial start date', () async {
      final originalDate = DateTime(2026, 1, 1).toIso8601String();
      SharedPreferences.setMockInitialValues({
        IapConstants.prefTrialStartDate: originalDate,
      });
      await SubscriptionService.recordTrialStart();
      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getString(IapConstants.prefTrialStartDate);
      expect(stored, originalDate);
    });
  });
}
