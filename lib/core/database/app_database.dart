import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/alarms_table.dart';
import 'tables/quiz_progress_table.dart';
import 'tables/vocabulary_items_table.dart';
import 'tables/user_level_progress_table.dart';
import 'tables/xp_transactions_table.dart';
import 'utils/db_seeder.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Alarms,
  QuizProgress,
  AlarmHistory,
  VocabularyItems,
  UserLevelProgress,
  XpTransactions,
])
class AppDatabase extends _$AppDatabase {
  static AppDatabase? _instance;

  /// Returns the singleton database instance.
  static AppDatabase get instance {
    _instance ??= AppDatabase._();
    return _instance!;
  }

  AppDatabase._() : super(_openConnection());

  /// Constructor for testing with custom executor
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _seedVocabularyItems();
        await _initializeUserLevelProgress();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(vocabularyItems);
          await m.createTable(userLevelProgress);
          await m.createTable(xpTransactions);
          await _seedVocabularyItems();
          await _initializeUserLevelProgress();
          await _migrateQuizProgressData();
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  // ============ Migration Helpers ============

  Future<void> _seedVocabularyItems() async {
    try {
      await DbSeeder.seedFromAsset(this);
    } catch (e) {
      // Seeding failure is non-fatal; the app can still operate from JSON
    }
  }

  Future<void> _initializeUserLevelProgress() async {
    await into(userLevelProgress).insert(
      UserLevelProgressCompanion.insert(),
    );
  }

  Future<void> _migrateQuizProgressData() async {
    final progressRows = await select(quizProgress).get();
    for (final row in progressRows) {
      final vocabRow = await (select(vocabularyItems)
            ..where((v) => v.questionId.equals(row.questionId)))
          .getSingleOrNull();

      if (vocabRow != null) {
        await (update(vocabularyItems)
              ..where((v) => v.questionId.equals(row.questionId)))
            .write(VocabularyItemsCompanion(
          timesPresented: Value(row.timesShown),
          timesIncorrect: Value(row.timesIncorrect),
          lastPresentedAt: Value(row.lastShownAt),
          // Do NOT auto-grant mastery or set timesCorrectFirstAttempt
          // from old data since it didn't track first-attempt specifically
        ));
      }
    }
  }

  // ============ Alarm Operations ============

  /// Get all alarms ordered by time
  Future<List<Alarm>> getAllAlarms() {
    return (select(alarms)
          ..orderBy([
            (a) => OrderingTerm(expression: a.hour),
            (a) => OrderingTerm(expression: a.minute),
          ]))
        .get();
  }

  /// Get enabled alarms only
  Future<List<Alarm>> getEnabledAlarms() {
    return (select(alarms)..where((a) => a.isEnabled.equals(true))).get();
  }

  /// Get a single alarm by ID
  Future<Alarm?> getAlarmById(int id) {
    return (select(alarms)..where((a) => a.id.equals(id))).getSingleOrNull();
  }

  /// Watch all alarms (reactive stream)
  Stream<List<Alarm>> watchAllAlarms() {
    return (select(alarms)
          ..orderBy([
            (a) => OrderingTerm(expression: a.hour),
            (a) => OrderingTerm(expression: a.minute),
          ]))
        .watch();
  }

  /// Watch enabled alarms only
  Stream<List<Alarm>> watchEnabledAlarms() {
    return (select(alarms)..where((a) => a.isEnabled.equals(true))).watch();
  }

  /// Insert a new alarm
  Future<int> insertAlarm(AlarmsCompanion alarm) {
    return into(alarms).insert(alarm);
  }

  /// Update an existing alarm
  Future<bool> updateAlarm(Alarm alarm) {
    return update(alarms).replace(alarm);
  }

  /// Update alarm fields using companion
  Future<int> updateAlarmFields(int id, AlarmsCompanion companion) {
    return (update(alarms)..where((a) => a.id.equals(id))).write(companion);
  }

  /// Toggle alarm enabled state
  Future<int> toggleAlarmEnabled(int id, bool enabled) {
    return (update(alarms)..where((a) => a.id.equals(id))).write(
      AlarmsCompanion(
        isEnabled: Value(enabled),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Update next fire time for an alarm
  Future<int> updateNextFireTime(int id, DateTime? nextFireTime) {
    return (update(alarms)..where((a) => a.id.equals(id))).write(
      AlarmsCompanion(
        nextFireTime: Value(nextFireTime),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Delete an alarm
  Future<int> deleteAlarm(int id) {
    return (delete(alarms)..where((a) => a.id.equals(id))).go();
  }

  // ============ Quiz Progress Operations ============

  /// Get quiz progress for a question
  Future<QuizProgressData?> getQuizProgress(String questionId) {
    return (select(quizProgress)
          ..where((q) => q.questionId.equals(questionId)))
        .getSingleOrNull();
  }

  /// Update or insert quiz progress
  Future<void> upsertQuizProgress(QuizProgressCompanion progress) async {
    await into(quizProgress).insertOnConflictUpdate(progress);
  }

  /// Get questions sorted by performance (worst performing first)
  Future<List<QuizProgressData>> getWeakQuestions({int limit = 10}) {
    return (select(quizProgress)
          ..orderBy([(q) => OrderingTerm(expression: q.performanceRating)])
          ..limit(limit))
        .get();
  }

  /// Get question IDs shown within the cooldown period
  Future<Set<String>> getRecentlyShownQuestionIds({int cooldownDays = 3}) async {
    final cutoff = DateTime.now().subtract(Duration(days: cooldownDays));
    final rows = await (select(quizProgress)
          ..where((q) => q.lastShownAt.isBiggerOrEqualValue(cutoff)))
        .get();
    return rows.map((r) => r.questionId).toSet();
  }

  // ============ Alarm History Operations ============

  /// Record alarm trigger
  Future<int> recordAlarmTrigger(int alarmId) {
    return into(alarmHistory).insert(
      AlarmHistoryCompanion(
        alarmId: Value(alarmId),
        triggeredAt: Value(DateTime.now()),
      ),
    );
  }

  /// Update alarm history on dismiss
  Future<int> recordAlarmDismiss({
    required int historyId,
    required int questionsAttempted,
    required int questionsCorrect,
    required int snoozeCount,
    required String dismissMethod,
  }) {
    return (update(alarmHistory)..where((h) => h.id.equals(historyId))).write(
      AlarmHistoryCompanion(
        dismissedAt: Value(DateTime.now()),
        questionsAttempted: Value(questionsAttempted),
        questionsCorrect: Value(questionsCorrect),
        snoozeCount: Value(snoozeCount),
        dismissMethod: Value(dismissMethod),
      ),
    );
  }

  /// Get alarm history for a specific alarm
  Future<List<AlarmHistoryData>> getAlarmHistory(int alarmId, {int limit = 30}) {
    return (select(alarmHistory)
          ..where((h) => h.alarmId.equals(alarmId))
          ..orderBy([(h) => OrderingTerm.desc(h.triggeredAt)])
          ..limit(limit))
        .get();
  }

  // ============ Vocabulary Item Operations ============

  /// Get a vocabulary item by question ID
  Future<VocabularyItem?> getVocabularyItemByQuestionId(String questionId) {
    return (select(vocabularyItems)
          ..where((v) => v.questionId.equals(questionId)))
        .getSingleOrNull();
  }

  /// Get vocabulary items for a quiz session with filtering
  Future<List<VocabularyItem>> getVocabularyItemsForQuiz({
    String? difficulty,
    required int userLevel,
    required bool isFreeUser,
    int limit = 10,
    Set<String> excludeIds = const {},
  }) async {
    final query = select(vocabularyItems);

    if (isFreeUser) {
      query.where((v) => v.isFree.equals(true));
    } else {
      query.where((v) => v.unlockLevel.isSmallerOrEqualValue(userLevel));
    }

    if (difficulty != null) {
      query.where((v) => v.difficulty.equals(difficulty));
    }

    final rows = await query.get();

    // Filter out excluded IDs in Dart (for cooldown)
    var filtered = rows.where((r) => !excludeIds.contains(r.questionId)).toList();
    filtered.shuffle();

    if (filtered.length > limit) {
      filtered = filtered.sublist(0, limit);
    }

    return filtered;
  }

  /// Update vocabulary item progress after answering
  Future<void> updateVocabularyItemProgress({
    required String questionId,
    required bool correctFirstAttempt,
  }) async {
    final item = await getVocabularyItemByQuestionId(questionId);
    if (item == null) return;

    final newTimesPresented = item.timesPresented + 1;
    final newTimesCorrectFirstAttempt =
        item.timesCorrectFirstAttempt + (correctFirstAttempt ? 1 : 0);
    final newTimesIncorrect =
        item.timesIncorrect + (correctFirstAttempt ? 0 : 1);

    // Check mastery: seen 3+ times and 80%+ first-attempt success
    final shouldBeMastered = newTimesPresented >= 3 &&
        (newTimesCorrectFirstAttempt / newTimesPresented) >= 0.8;
    final newlyMastered = shouldBeMastered && !item.isMastered;

    await (update(vocabularyItems)
          ..where((v) => v.questionId.equals(questionId)))
        .write(VocabularyItemsCompanion(
      timesPresented: Value(newTimesPresented),
      timesCorrectFirstAttempt: Value(newTimesCorrectFirstAttempt),
      timesIncorrect: Value(newTimesIncorrect),
      lastPresentedAt: Value(DateTime.now()),
      isMastered: Value(shouldBeMastered),
      masteredAt: newlyMastered ? Value(DateTime.now()) : const Value.absent(),
    ));
  }

  /// Check if an item was newly mastered (call before updateVocabularyItemProgress)
  Future<bool> wouldBecomeNewlyMastered({
    required String questionId,
    required bool correctFirstAttempt,
  }) async {
    final item = await getVocabularyItemByQuestionId(questionId);
    if (item == null || item.isMastered) return false;

    final newTimesPresented = item.timesPresented + 1;
    final newTimesCorrectFirstAttempt =
        item.timesCorrectFirstAttempt + (correctFirstAttempt ? 1 : 0);

    return newTimesPresented >= 3 &&
        (newTimesCorrectFirstAttempt / newTimesPresented) >= 0.8;
  }

  /// Get recently presented question IDs from vocabulary items
  Future<Set<String>> getRecentlyPresentedIds({int cooldownDays = 3}) async {
    final cutoff = DateTime.now().subtract(Duration(days: cooldownDays));
    final rows = await (select(vocabularyItems)
          ..where((v) => v.lastPresentedAt.isBiggerOrEqualValue(cutoff)))
        .get();
    return rows.map((r) => r.questionId).toSet();
  }

  /// Get count of mastered items
  Future<int> getMasteredCount() async {
    final rows = await (select(vocabularyItems)
          ..where((v) => v.isMastered.equals(true)))
        .get();
    return rows.length;
  }

  // ============ User Level Progress Operations ============

  /// Get the singleton user level progress row
  Future<UserLevelProgressData> getUserLevelProgress() async {
    final row = await (select(userLevelProgress)
          ..where((u) => u.id.equals(1)))
        .getSingleOrNull();

    if (row != null) return row;

    // Create if missing
    await _initializeUserLevelProgress();
    return (select(userLevelProgress)
          ..where((u) => u.id.equals(1)))
        .getSingle();
  }

  /// Update user level progress
  Future<void> updateUserLevelProgress({
    int? currentLevel,
    int? totalXp,
    int? dailyXp,
    DateTime? lastXpDate,
    int? totalQuizzesCompleted,
    int? totalCorrectAnswers,
    int? totalItemsMastered,
  }) async {
    final companion = UserLevelProgressCompanion(
      currentLevel: currentLevel != null ? Value(currentLevel) : const Value.absent(),
      totalXp: totalXp != null ? Value(totalXp) : const Value.absent(),
      dailyXp: dailyXp != null ? Value(dailyXp) : const Value.absent(),
      lastXpDate: lastXpDate != null ? Value(lastXpDate) : const Value.absent(),
      totalQuizzesCompleted: totalQuizzesCompleted != null
          ? Value(totalQuizzesCompleted)
          : const Value.absent(),
      totalCorrectAnswers: totalCorrectAnswers != null
          ? Value(totalCorrectAnswers)
          : const Value.absent(),
      totalItemsMastered: totalItemsMastered != null
          ? Value(totalItemsMastered)
          : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    );

    await (update(userLevelProgress)..where((u) => u.id.equals(1)))
        .write(companion);
  }

  // ============ XP Transaction Operations ============

  /// Insert an XP transaction
  Future<int> insertXpTransaction({
    required int amount,
    required String source,
    String? referenceId,
    required int levelAtTime,
  }) {
    return into(xpTransactions).insert(
      XpTransactionsCompanion.insert(
        amount: amount,
        source: source,
        referenceId: Value(referenceId),
        levelAtTime: levelAtTime,
      ),
    );
  }
}

/// Global provider for the singleton AppDatabase instance.
final databaseProvider = Provider<AppDatabase>((ref) => AppDatabase.instance);

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'wakeup_english.db'));
    return NativeDatabase.createInBackground(file);
  });
}
