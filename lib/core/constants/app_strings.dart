abstract class AppStrings {
  // Route names
  static const String homeRoute = '/';
  static const String alarmListRoute = '/alarms';
  static const String alarmEditRoute = '/alarms/edit';
  static const String alarmAddRoute = '/alarms/add';
  static const String quizLockRoute = '/quiz-lock';
  static const String settingsRoute = '/settings';
  static const String paywallRoute = '/paywall';
  static const String onboardingRoute = '/onboarding';

  // Database
  static const String databaseName = 'wakeup_english.db';

  // Asset paths
  static const String defaultAlarmSound = 'assets/sounds/default_alarm.mp3';

  // Shared preferences keys
  static const String prefLanguage = 'pref_language';
  static const String prefDefaultSnooze = 'pref_default_snooze';
  static const String prefDefaultQuizCount = 'pref_default_quiz_count';
  static const String prefDefaultDifficulty = 'pref_default_difficulty';
  static const String prefVibrationEnabled = 'pref_vibration_enabled';
  static const String prefGradualVolume = 'pref_gradual_volume';
  static const String prefTrialStartDate = 'trial_start_date';
  static const String prefEnabledMissionTypes = 'pref_enabled_mission_types';
  static const String prefStreakCurrent = 'pref_streak_current';
  static const String prefStreakLastDate = 'pref_streak_last_date';
  static const String prefStreakMax = 'pref_streak_max';
  static const String prefFirstLaunchComplete = 'pref_first_launch_complete';

  // Notification channels
  static const String alarmChannelId = 'alarm_channel';
  static const String alarmChannelName = 'Alarm Notifications';
  static const String alarmChannelDescription =
      'Notifications for scheduled alarms';
}
