abstract class IapConstants {
  // RevenueCat API Keys (replace with real keys before release)
  static const String revenueCatApiKeyIOS = 'appl_YOUR_IOS_API_KEY_HERE';
  static const String revenueCatApiKeyAndroid =
      'goog_YOUR_ANDROID_API_KEY_HERE';

  // Entitlement ID
  static const String premiumEntitlementId = 'premium';

  // Legal policy URLs. Replace these before App Store / Play Store release.
  static const String termsOfServiceUrl = 'https://okmorning.app/terms';
  static const String privacyPolicyUrl = 'https://okmorning.app/privacy';

  // Trial duration in days
  static const int trialDurationDays = 7;

  // SharedPreferences keys
  static const String prefTrialStartDate = 'trial_start_date';

  // Free tier sound paths (3 sounds)
  static const List<String> freeSoundPaths = [
    'assets/sounds/default_alarm.mp3',
    'assets/sounds/gentle_morning.mp3',
    'assets/sounds/birds_chirping.mp3',
  ];
}
