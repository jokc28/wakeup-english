import 'package:drift/drift.dart';

/// Table storing all quiz content (seeded from JSON) plus per-item mastery tracking
class VocabularyItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Original ID from JSON (e.g., "vocab_easy_1")
  TextColumn get questionId => text().unique()();

  /// 'multiple_choice', 'fill_in_blank', 'translation', 'word_scramble'
  TextColumn get type => text()();

  /// 'vocabulary', 'grammar', 'reading', 'idioms', 'daily_expression', 'phrases', 'pronunciation'
  TextColumn get category => text()();

  /// 'easy', 'medium', 'hard'
  TextColumn get difficulty => text()();

  /// English question text
  TextColumn get question => text()();

  /// Korean question text
  TextColumn get questionKo => text()();

  /// JSON-encoded array of options
  TextColumn get options => text()();

  /// Correct answer string
  TextColumn get correctAnswer => text()();

  /// Optional hint
  TextColumn get hint => text().nullable()();

  /// English explanation
  TextColumn get explanation => text().nullable()();

  /// Korean explanation
  TextColumn get explanationKo => text().nullable()();

  /// Total presentations
  IntColumn get timesPresented => integer().withDefault(const Constant(0))();

  /// Correct on first attempt count
  IntColumn get timesCorrectFirstAttempt =>
      integer().withDefault(const Constant(0))();

  /// Incorrect count
  IntColumn get timesIncorrect => integer().withDefault(const Constant(0))();

  /// Mastery achieved flag
  BoolColumn get isMastered =>
      boolean().withDefault(const Constant(false))();

  /// Last shown timestamp
  DateTimeColumn get lastPresentedAt => dateTime().nullable()();

  /// When mastery was achieved
  DateTimeColumn get masteredAt => dateTime().nullable()();

  /// Available in free tier
  BoolColumn get isFree =>
      boolean().withDefault(const Constant(false))();

  /// Minimum level to access
  IntColumn get unlockLevel => integer().withDefault(const Constant(1))();

  /// Row creation timestamp
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}
