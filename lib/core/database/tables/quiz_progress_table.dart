import 'package:drift/drift.dart';

/// Table to track quiz progress and statistics
class QuizProgress extends Table {
  /// Unique identifier
  IntColumn get id => integer().autoIncrement()();

  /// Question identifier from the seeded quiz content
  TextColumn get questionId => text()();

  /// Number of times this question was shown
  IntColumn get timesShown => integer().withDefault(const Constant(0))();

  /// Number of times answered correctly
  IntColumn get timesCorrect => integer().withDefault(const Constant(0))();

  /// Number of times answered incorrectly
  IntColumn get timesIncorrect => integer().withDefault(const Constant(0))();

  /// Last time this question was shown
  DateTimeColumn get lastShownAt => dateTime().nullable()();

  /// Average response time in milliseconds
  IntColumn get avgResponseTimeMs => integer().withDefault(const Constant(0))();

  /// Difficulty rating based on user performance (0.0-1.0, stored as 0-100)
  IntColumn get performanceRating =>
      integer().withDefault(const Constant(50))();
}

/// Table to track alarm dismissal history
class AlarmHistory extends Table {
  /// Unique identifier
  IntColumn get id => integer().autoIncrement()();

  /// Reference to the alarm that was triggered
  IntColumn get alarmId => integer()();

  /// When the alarm was triggered
  DateTimeColumn get triggeredAt => dateTime()();

  /// When the alarm was dismissed (null if still active)
  DateTimeColumn get dismissedAt => dateTime().nullable()();

  /// Number of quiz questions attempted
  IntColumn get questionsAttempted =>
      integer().withDefault(const Constant(0))();

  /// Number of quiz questions answered correctly
  IntColumn get questionsCorrect => integer().withDefault(const Constant(0))();

  /// Number of times snoozed
  IntColumn get snoozeCount => integer().withDefault(const Constant(0))();

  /// How the alarm was dismissed: 'quiz', 'snooze_limit', 'force_stop'
  TextColumn get dismissMethod => text().nullable()();
}
