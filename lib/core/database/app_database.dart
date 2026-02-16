import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/alarms_table.dart';
import 'tables/quiz_progress_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Alarms, QuizProgress, AlarmHistory])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Constructor for testing with custom executor
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle future migrations here
      },
      beforeOpen: (details) async {
        // Enable foreign keys
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'wakeup_english.db'));
    return NativeDatabase.createInBackground(file);
  });
}
