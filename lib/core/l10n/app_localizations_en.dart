// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'OK-Morning';

  @override
  String get alarms => 'Alarms';

  @override
  String get settings => 'Settings';

  @override
  String get addAlarm => 'Add Alarm';

  @override
  String get editAlarm => 'Edit Alarm';

  @override
  String get deleteAlarm => 'Delete Alarm';

  @override
  String get saveAlarm => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get alarmTime => 'Alarm Time';

  @override
  String get repeatDays => 'Repeat';

  @override
  String get alarmLabel => 'Label';

  @override
  String get quizDifficulty => 'Quiz Difficulty';

  @override
  String get difficultyEasy => 'Easy';

  @override
  String get difficultyMedium => 'Medium';

  @override
  String get difficultyHard => 'Hard';

  @override
  String get monday => 'Mon';

  @override
  String get tuesday => 'Tue';

  @override
  String get wednesday => 'Wed';

  @override
  String get thursday => 'Thu';

  @override
  String get friday => 'Fri';

  @override
  String get saturday => 'Sat';

  @override
  String get sunday => 'Sun';

  @override
  String get solveToStop => 'Solve the quiz to stop the alarm';

  @override
  String get correct => 'Correct!';

  @override
  String get incorrect => 'Incorrect, try again';

  @override
  String get submit => 'Submit';

  @override
  String questionsRemaining(int count) {
    return '$count questions remaining';
  }

  @override
  String get noAlarms => 'No alarms set';

  @override
  String get alarmEnabled => 'Alarm enabled';

  @override
  String get alarmDisabled => 'Alarm disabled';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get korean => '한국어';

  @override
  String get sound => 'Sound';

  @override
  String get vibration => 'Vibration';

  @override
  String get snooze => 'Snooze';

  @override
  String get snoozeDuration => 'Snooze Duration';

  @override
  String minutes(int count) {
    return '$count minutes';
  }

  @override
  String get quizCount => 'Number of Questions';

  @override
  String get errorRestartApp => 'Please restart the app';

  @override
  String get errorTemporaryIssue => 'A temporary error occurred.';

  @override
  String get errorLoadingAlarms => 'Error loading alarms';

  @override
  String alarmDeletedMessage(String label) {
    return '\"$label\" deleted';
  }

  @override
  String get alarmDeletedGeneric => 'Alarm deleted';

  @override
  String get undoAction => 'Undo';

  @override
  String get confirmDeleteAlarm => 'Delete this alarm?';

  @override
  String confirmDeleteAlarmWithLabel(String label) {
    return 'Delete \"$label\" alarm?';
  }

  @override
  String confirmDeleteAlarmWithTime(String time) {
    return 'Delete $time alarm?';
  }

  @override
  String get alarmUpdated => 'Alarm updated';

  @override
  String get alarmCreated => 'Alarm created';

  @override
  String get deleteButton => 'Delete';

  @override
  String get timePickerTapHint => 'Tap to change time';

  @override
  String get alarmNameLabel => 'Alarm Name';

  @override
  String get optionalLabel => 'Optional';

  @override
  String get wakeMissionLabel => 'Wake-up Mission';

  @override
  String get difficultyLabel => 'Difficulty';

  @override
  String get alarmSoundLabel => 'Alarm Sound';

  @override
  String get soundLabel => 'Sound';

  @override
  String get gradualVolumeLabel => 'Gradual Volume';

  @override
  String get volumeLabel => 'Volume';

  @override
  String get snoozeLabel => 'Snooze';

  @override
  String get snoozeIntervalLabel => 'Interval';

  @override
  String get maxSnoozesLabel => 'Max Count';

  @override
  String maxSnoozesFormat(int count) {
    return '$count times';
  }

  @override
  String get setAlarmTimeTitle => 'Set Alarm Time';

  @override
  String get doneButton => 'Done';

  @override
  String get repeatOnce => 'Once';

  @override
  String get repeatDaily => 'Daily';

  @override
  String get repeatWeekdays => 'Weekdays';

  @override
  String get repeatWeekends => 'Weekends';

  @override
  String get goodMorningGreeting => 'Good morning!';

  @override
  String get loadingQuiz => 'Loading quiz...';

  @override
  String get explanationLabel => 'Explanation';

  @override
  String get verifiedReelSource => 'Verified Reel expression';

  @override
  String get sourceLinkCopied => 'Source link copied';

  @override
  String get quizCompleteButton => 'Complete Quiz';

  @override
  String get nextQuestionButton => 'Next Question';

  @override
  String scoreDisplay(int correct, int total) {
    return '$correct/$total correct!';
  }

  @override
  String get quizCompletedMessage => 'Quiz complete!';

  @override
  String get dismissAlarmButton => 'Dismiss Alarm';

  @override
  String get trialExpiredTitle => 'Free Trial Ended';

  @override
  String get trialExpiredMessage =>
      'Your free trial (7 days) has expired.\nPlease subscribe to continue using the app.';

  @override
  String get restorePurchasesDebug => 'Restore Purchases (Debug)';

  @override
  String get subscribeButton => 'Subscribe';

  @override
  String get correctAnswerLabel => 'Answer: ';

  @override
  String hintLabel(String hint) {
    return 'Hint: $hint';
  }

  @override
  String get enterAnswerPlaceholder => 'Enter your answer...';

  @override
  String get startMissionSlide => 'Start Mission';

  @override
  String get speakInstructions => 'Speak the sentence below in English';

  @override
  String get recognizedTextLabel => 'Recognized text:';

  @override
  String similarityPercentage(String percent) {
    return 'Similarity: $percent%';
  }

  @override
  String get micNotAvailableMessage =>
      'Microphone is not available. Please type your answer instead.';

  @override
  String get enterEnglishPlaceholder => 'Type in English...';

  @override
  String get holdToSpeak => 'Hold to speak';

  @override
  String get typeInsteadButton => 'Type instead';

  @override
  String get listeningMessage => 'Listening...';

  @override
  String get wordScrambleInstruction => 'Unscramble the word';

  @override
  String get speakingChallengeInstruction =>
      'Speak the following sentence in English';

  @override
  String get noAlarmsSubtitle =>
      'Tap the button below to create an English quiz alarm';

  @override
  String get homeWelcome => 'Another fresh OK-Morning!';

  @override
  String quizInfoFormat(String difficulty, int count) {
    return '$difficulty $count questions';
  }

  @override
  String get alarmSoundTitle => 'Alarm Sound';

  @override
  String get soundPickerHint =>
      'Tap a sound to select it. Use the play icon to preview.';

  @override
  String get defaultAlarmSettings => 'Default Alarm Settings';

  @override
  String get defaultQuizCount => 'Default Quiz Count';

  @override
  String get defaultDifficulty => 'Default Difficulty';

  @override
  String get defaultSnoozeTime => 'Default Snooze Time';

  @override
  String get missionTypeHeader => 'Mission Type';

  @override
  String get wordScrambleMission => 'Word Scramble';

  @override
  String get wordScrambleDescription => 'Unscramble letters to complete words';

  @override
  String get speakingChallengeMission => 'Speaking Challenge';

  @override
  String get speakingChallengeDescription => 'Say English sentences aloud';

  @override
  String get soundVibrationHeader => 'Sound & Vibration';

  @override
  String get vibrationDescription => 'Vibrate when alarm rings';

  @override
  String get gradualVolumeDescription => 'Gradually increase alarm volume';

  @override
  String get subscriptionHeader => 'Subscription';

  @override
  String get upgradeToPremium => 'Upgrade to Premium';

  @override
  String get unlockAllContent =>
      'Unlock every verified expression and alarm sound';

  @override
  String get restorePurchasesLabel => 'Restore Purchases';

  @override
  String get restorePurchasesDescription => 'Restore previous purchases';

  @override
  String get debugPremiumMode => '[Debug] Premium Mode';

  @override
  String get debugPremiumEnabled => 'Enabled - tap to disable';

  @override
  String get debugPremiumDisabled => 'Disabled - tap to enable';

  @override
  String get aboutHeader => 'About';

  @override
  String get versionLabel => 'Version';

  @override
  String get licensesLabel => 'Open Source Licenses';

  @override
  String get licensesDescription => 'View open source licenses';

  @override
  String get dataHeader => 'Data';

  @override
  String get clearProgressLabel => 'Clear Quiz Progress';

  @override
  String get clearProgressDescription => 'Reset all learning progress';

  @override
  String get selectLanguageDialog => 'Select Language';

  @override
  String get selectQuizCountDialog => 'Default Quiz Count';

  @override
  String quizCountFormat(int count) {
    return '$count questions';
  }

  @override
  String get selectDifficultyDialog => 'Default Difficulty';

  @override
  String get easyDifficultyDesc => 'Basic vocabulary and grammar';

  @override
  String get mediumDifficultyDesc => 'Intermediate level';

  @override
  String get hardDifficultyDesc => 'Advanced vocabulary and idioms';

  @override
  String get selectSnoozeDialog => 'Default Snooze Time';

  @override
  String get clearProgressDialog => 'Clear Progress';

  @override
  String get clearProgressWarning =>
      'All quiz learning progress will be cleared. This action cannot be undone.';

  @override
  String get progressClearedSnackbar => 'Progress has been cleared';

  @override
  String get resetButton => 'Reset';

  @override
  String get purchasesRestoredSnackbar => 'Purchases restored!';

  @override
  String get noPurchasesToRestore => 'No purchases to restore';

  @override
  String get unlockPremium => 'Unlock Premium';

  @override
  String get premiumSubtitle =>
      'Keep your morning routine growing with verified real-life expressions';

  @override
  String get feature1Title => 'Full Verified Expression Library';

  @override
  String get feature1Desc =>
      'Learn Reel-based expressions with Korean situation notes';

  @override
  String get feature2Title => '10 Alarm Sounds';

  @override
  String get feature2Desc => 'Premium sounds: ocean waves, piano, jazz & more';

  @override
  String get feature3Title => 'Progress & Smart Review';

  @override
  String get feature3Desc =>
      'Save XP, levels, mastery, and repeat weak expressions';

  @override
  String get feature4Title => 'New Real-Life Updates';

  @override
  String get feature4Desc =>
      'Verified expressions and morning missions added regularly';

  @override
  String get subscribeNowButton => 'Subscribe Now';

  @override
  String get startTrialButton => 'Start Free Trial';

  @override
  String get subscriptionTerms =>
      'Subscription automatically renews unless canceled at least 24 hours before the end of the current period. You can manage your subscription in device settings.';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get premiumMonthlyPlan => 'Monthly';

  @override
  String premiumMonthlyPrice(String price) {
    return '$price/mo';
  }

  @override
  String get premiumAnnualPlan => 'Annual';

  @override
  String premiumAnnualPrice(String price) {
    return '$price/yr';
  }

  @override
  String get premiumAnnualBadge => 'Recommended';

  @override
  String get premiumNoOfferings =>
      'Subscription products are not configured yet. Prices will appear after monthly and annual products are connected in RevenueCat.';

  @override
  String get trialIncluded => 'Includes 7-day free trial';

  @override
  String get welcomeToPremium => 'Welcome to Premium!';

  @override
  String get purchasesRestored => 'Purchases restored!';

  @override
  String get morningStreak => 'Morning Streak';

  @override
  String streakDays(int count) {
    return '$count-Day Streak!';
  }

  @override
  String streakRecord(int count) {
    return 'Record: $count';
  }

  @override
  String get streakNewRecord => 'New Record!';

  @override
  String get streakStart => 'Start your streak!';

  @override
  String get completedToday => 'Completed today';

  @override
  String get premiumStatus => 'Premium';

  @override
  String get premiumAllContent => 'All content available';

  @override
  String get freeTrialStatus => 'Free Trial';

  @override
  String trialDaysRemaining(int count) {
    return '$count days remaining';
  }

  @override
  String get freePlanStatus => 'Free Plan';

  @override
  String get freePlanLimits => 'Limited expressions, 3 sounds';

  @override
  String get upgradeButton => 'Upgrade';

  @override
  String xpEarned(int xp) {
    return '+$xp XP';
  }

  @override
  String levelLabel(int level) {
    return 'Level $level';
  }

  @override
  String xpToNext(int xp) {
    return '$xp XP to next level';
  }

  @override
  String totalXpLabel(int xp) {
    return '$xp XP total';
  }

  @override
  String levelUpMessage(int level) {
    return 'Level Up! Lv.$level';
  }

  @override
  String masteredCount(int count) {
    return '$count mastered';
  }

  @override
  String get dailyGoalTitle => 'Daily Goal';

  @override
  String dailyGoalProgress(int current, int target) {
    return '$current/$target XP';
  }

  @override
  String get dailyGoalDone => 'Daily goal complete';

  @override
  String get dailyGoalSubtitle =>
      'Solve your morning quiz and keep your streak alive';

  @override
  String get devForceSeedDb => 'DEV: Force Seed DB';

  @override
  String get devForceSeedDbDesc => 'Re-seed vocabulary from bundled JSON';

  @override
  String devSeedComplete(int count) {
    return 'Seeded $count items into DB';
  }

  @override
  String get xpLockedTitle => 'Progress Locked';

  @override
  String get xpLockedMessage =>
      'Your trial has ended. XP and progress cannot be saved.';

  @override
  String get xpLockedSubscribe => 'Subscribe to Keep Growing';

  @override
  String get xpLockedFomo => 'Subscribe to OK-Morning Pro to keep leveling up.';

  @override
  String get dismissAlarmOnly => 'Just Dismiss Alarm';

  @override
  String get onboardingWelcomeTitle => 'A fresh morning,\nOK-Morning!';

  @override
  String get onboardingWelcomeSubtitle =>
      'Start each morning brighter with English';

  @override
  String get onboardingValueTitle =>
      'Your alarm won\'t stop\nuntil you solve English!';

  @override
  String get onboardingValueSubtitle =>
      'Level up every morning.\nGrow your English while waking up.';

  @override
  String get onboardingPermissionsTitle =>
      'Just two permissions\nfor a perfect morning';

  @override
  String get onboardingPermissionsSubtitle =>
      'We need these to ring your alarm and hear your voice.';

  @override
  String get onboardingNotificationBtn => 'Allow Notifications';

  @override
  String get onboardingMicrophoneBtn => 'Allow Microphone';

  @override
  String get onboardingPermissionGranted => 'Granted';

  @override
  String get onboardingCtaTitle => 'You\'re all set!';

  @override
  String get onboardingCtaSubtitle =>
      'Set your first alarm and start growing tomorrow morning.';

  @override
  String get onboardingCtaButton => 'Set My First Alarm';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingSkip => 'Skip';
}
