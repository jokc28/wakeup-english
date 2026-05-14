import 'package:drift/drift.dart';

/// Single-row table for user's overall level progression
class UserLevelProgress extends Table {
  /// Singleton (always row 1)
  IntColumn get id => integer().withDefault(const Constant(1))();

  /// Current level 1-50
  IntColumn get currentLevel => integer().withDefault(const Constant(1))();

  /// Lifetime accumulated XP
  IntColumn get totalXp => integer().withDefault(const Constant(0))();

  /// XP earned today (resets daily)
  IntColumn get dailyXp => integer().withDefault(const Constant(0))();

  /// For daily reset detection
  DateTimeColumn get lastXpDate => dateTime().nullable()();

  /// Lifetime quiz count
  IntColumn get totalQuizzesCompleted =>
      integer().withDefault(const Constant(0))();

  /// Lifetime correct count
  IntColumn get totalCorrectAnswers =>
      integer().withDefault(const Constant(0))();

  /// Total mastered items
  IntColumn get totalItemsMastered =>
      integer().withDefault(const Constant(0))();

  /// Last update timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
