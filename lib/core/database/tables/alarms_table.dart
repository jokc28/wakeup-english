import 'package:drift/drift.dart';

/// Table definition for alarms
class Alarms extends Table {
  /// Unique identifier for the alarm
  IntColumn get id => integer().autoIncrement()();

  /// Display label for the alarm
  TextColumn get label => text().withDefault(const Constant(''))();

  /// Hour of the alarm (0-23)
  IntColumn get hour => integer()();

  /// Minute of the alarm (0-59)
  IntColumn get minute => integer()();

  /// Whether the alarm is enabled
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  /// Days of week to repeat (stored as JSON array, e.g., [0,1,2,3,4] for Mon-Fri)
  /// Empty array means one-time alarm
  TextColumn get repeatDays => text().withDefault(const Constant('[]'))();

  /// Quiz difficulty level: 'easy', 'medium', 'hard'
  TextColumn get quizDifficulty =>
      text().withDefault(const Constant('medium'))();

  /// Number of quiz questions to solve
  IntColumn get quizCount => integer().withDefault(const Constant(3))();

  /// Sound file path or asset name
  TextColumn get soundPath => text().withDefault(
        const Constant('assets/sounds/default_alarm.mp3'),
      )();

  /// Whether vibration is enabled
  BoolColumn get vibrationEnabled =>
      boolean().withDefault(const Constant(true))();

  /// Snooze duration in minutes (0 = snooze disabled)
  IntColumn get snoozeDuration => integer().withDefault(const Constant(5))();

  /// Maximum number of snoozes allowed
  IntColumn get maxSnoozes => integer().withDefault(const Constant(3))();

  /// Volume level (0.0 - 1.0, stored as int 0-100)
  IntColumn get volume => integer().withDefault(const Constant(100))();

  /// Whether to gradually increase volume
  BoolColumn get gradualVolume =>
      boolean().withDefault(const Constant(false))();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Last modified timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  /// Next scheduled fire time (null if not scheduled)
  DateTimeColumn get nextFireTime => dateTime().nullable()();
}
