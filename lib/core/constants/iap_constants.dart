abstract class IapConstants {
  // RevenueCat API Keys (replace with real keys before release)
  static const String revenueCatApiKeyIOS = 'appl_YOUR_IOS_API_KEY_HERE';
  static const String revenueCatApiKeyAndroid = 'goog_YOUR_ANDROID_API_KEY_HERE';

  // Entitlement ID
  static const String premiumEntitlementId = 'premium';

  // Trial duration in days
  static const int trialDurationDays = 7;

  // SharedPreferences keys
  static const String prefTrialStartDate = 'trial_start_date';

  // Free tier quiz question IDs (30 questions)
  static const List<String> freeQuizQuestionIds = [
    // Existing questions (25)
    'vocab_easy_1',
    'vocab_easy_2',
    'vocab_easy_3',
    'grammar_easy_1',
    'grammar_easy_2',
    'grammar_easy_3',
    'vocab_medium_1',
    'vocab_medium_2',
    'vocab_medium_3',
    'grammar_medium_1',
    'grammar_medium_2',
    'grammar_medium_3',
    'idiom_medium_1',
    'idiom_medium_2',
    'vocab_hard_1',
    'vocab_hard_2',
    'vocab_hard_3',
    'grammar_hard_1',
    'idiom_hard_1',
    'idiom_hard_2',
    'phrase_easy_1',
    'phrase_easy_2',
    'phrase_medium_1',
    'phrase_hard_1',
    // New questions to reach 30 (spread across categories/difficulties)
    'vocab_easy_4',
    'grammar_easy_4',
    'phrase_easy_3',
    'fill_vocab_easy_1',
    'trans_grammar_easy_1',
    'fill_phrase_easy_1',
  ];

  // Free tier sound paths (3 sounds)
  static const List<String> freeSoundPaths = [
    'assets/sounds/default_alarm.mp3',
    'assets/sounds/gentle_morning.mp3',
    'assets/sounds/birds_chirping.mp3',
  ];
}
