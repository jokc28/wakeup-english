// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'WakeUp English';

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
}
