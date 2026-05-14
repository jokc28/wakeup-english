import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';

/// Provider for QuizRepository
final quizRepositoryProvider = Provider.family<QuizRepository, bool>(
  (ref, hasFullAccess) {
    final db = ref.watch(databaseProvider);
    return QuizRepository(db);
  },
);

/// Repository for recording quiz answer progress (legacy QuizProgress table).
///
/// Quiz question fetching is handled by [VocabularyRepository].
class QuizRepository {
  final AppDatabase _db;

  QuizRepository(this._db);

  /// Record a quiz answer
  Future<void> recordAnswer({
    required String questionId,
    required bool correct,
    required int responseTimeMs,
  }) async {
    final existing = await _db.getQuizProgress(questionId);

    if (existing != null) {
      final newTimesShown = existing.timesShown + 1;
      final newTimesCorrect = existing.timesCorrect + (correct ? 1 : 0);
      final newTimesIncorrect = existing.timesIncorrect + (correct ? 0 : 1);
      final newAvgTime = ((existing.avgResponseTimeMs * existing.timesShown) +
              responseTimeMs) ~/
          newTimesShown;
      final performance = ((newTimesCorrect / newTimesShown) * 100).round();

      await _db.upsertQuizProgress(
        QuizProgressCompanion(
          id: Value(existing.id),
          questionId: Value(questionId),
          timesShown: Value(newTimesShown),
          timesCorrect: Value(newTimesCorrect),
          timesIncorrect: Value(newTimesIncorrect),
          lastShownAt: Value(DateTime.now()),
          avgResponseTimeMs: Value(newAvgTime),
          performanceRating: Value(performance),
        ),
      );
    } else {
      await _db.upsertQuizProgress(
        QuizProgressCompanion(
          questionId: Value(questionId),
          timesShown: const Value(1),
          timesCorrect: Value(correct ? 1 : 0),
          timesIncorrect: Value(correct ? 0 : 1),
          lastShownAt: Value(DateTime.now()),
          avgResponseTimeMs: Value(responseTimeMs),
          performanceRating: Value(correct ? 100 : 0),
        ),
      );
    }
  }
}
