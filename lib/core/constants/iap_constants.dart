abstract class IapConstants {
  // RevenueCat API Keys.
  // Pass real values at build time:
  // --dart-define=REVENUECAT_IOS_API_KEY=appl_xxx
  // --dart-define=REVENUECAT_ANDROID_API_KEY=goog_xxx
  static const String revenueCatApiKeyIOS = String.fromEnvironment(
    'REVENUECAT_IOS_API_KEY',
    defaultValue: 'appl_YOUR_IOS_API_KEY_HERE',
  );
  static const String revenueCatApiKeyAndroid = String.fromEnvironment(
    'REVENUECAT_ANDROID_API_KEY',
    defaultValue: 'goog_YOUR_ANDROID_API_KEY_HERE',
  );

  // Entitlement ID
  static const String premiumEntitlementId = 'premium';

  // RevenueCat offering/package identifiers.
  static const String defaultOfferingId = 'default';
  static const String monthlyProductId = 'okmorning_premium_monthly';
  static const String annualProductId = 'okmorning_premium_annual';
  static const String familyProductId = 'okmorning_premium_family_annual';

  // First pricing experiment candidates. Storefront prices must be configured
  // in App Store Connect / Play Console and then attached in RevenueCat.
  static const int targetMonthlyPriceKrw = 5900;
  static const int targetAnnualPriceKrw = 49000;
  static const int targetFamilyAnnualPriceKrw = 79000;

  // Legal policy URLs served by GitHub Pages — see site/ directory.
  static const String termsOfServiceUrl =
      'https://jokc28.github.io/wakeup-english/terms/';
  static const String privacyPolicyUrl =
      'https://jokc28.github.io/wakeup-english/privacy/';

  // Trial duration in days
  static const int trialDurationDays = 7;

  // Product tuning
  static const int dailyGoalXp = 150;

  // SharedPreferences keys
  static const String prefTrialStartDate = 'trial_start_date';

  // Free tier sound paths (3 sounds)
  static const List<String> freeSoundPaths = [
    'assets/sounds/default_alarm.mp3',
    'assets/sounds/gentle_morning.mp3',
    'assets/sounds/birds_chirping.mp3',
  ];
}
