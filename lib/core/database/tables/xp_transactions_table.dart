import 'package:drift/drift.dart';

/// Append-only ledger of XP awards
class XpTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// XP awarded
  IntColumn get amount => integer()();

  /// 'quiz_complete', 'perfect_quiz', 'mastery_bonus', 'streak_bonus'
  TextColumn get source => text()();

  /// Optional quiz/question reference
  TextColumn get referenceId => text().nullable()();

  /// User level when earned
  IntColumn get levelAtTime => integer()();

  /// Timestamp
  DateTimeColumn get earnedAt => dateTime().withDefault(currentDateAndTime)();
}
