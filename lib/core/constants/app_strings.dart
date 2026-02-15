abstract class AppStrings {
  // Route names
  static const String homeRoute = '/';
  static const String alarmListRoute = '/alarms';
  static const String alarmEditRoute = '/alarms/edit';
  static const String alarmAddRoute = '/alarms/add';
  static const String quizLockRoute = '/quiz-lock';
  static const String settingsRoute = '/settings';

  // Database
  static const String databaseName = 'wakeup_english.db';

  // Asset paths
  static const String defaultAlarmSound = 'assets/sounds/default_alarm.mp3';
  static const String quizQuestionsPath = 'assets/data/quiz_questions.json';

  // Shared preferences keys
  static const String prefLanguage = 'pref_language';
  static const String prefDefaultSnooze = 'pref_default_snooze';
  static const String prefDefaultQuizCount = 'pref_default_quiz_count';
  static const String prefVibrationEnabled = 'pref_vibration_enabled';

  // Notification channels
  static const String alarmChannelId = 'alarm_channel';
  static const String alarmChannelName = 'Alarm Notifications';
  static const String alarmChannelDescription = 'Notifications for scheduled alarms';
}
