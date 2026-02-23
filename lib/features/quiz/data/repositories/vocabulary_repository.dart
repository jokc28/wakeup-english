import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/services/alarm_service.dart';
import '../../domain/entities/quiz_question.dart';

/// Provider for VocabularyRepository
final vocabularyRepositoryProvider = Provider<VocabularyRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return VocabularyRepository(db);
});

/// Repository that reads quiz questions from the VocabularyItems DB table
/// instead of the static JSON file.
class VocabularyRepository {
  final AppDatabase _db;
  final _random = Random();

  VocabularyRepository(this._db);

  /// Get random questions for a quiz session, filtered by level and tier
  Future<List<QuizQuestion>> getRandomQuestions({
    required int count,
    required String difficulty,
    required int userLevel,
    required bool isFreeUser,
  }) async {
    // Get recently presented IDs for cooldown
    final recentIds = await _db.getRecentlyPresentedIds(cooldownDays: 3);

    // Query DB with level/tier filtering, excluding cooldown items
    var items = await _db.getVocabularyItemsForQuiz(
      difficulty: difficulty,
      userLevel: userLevel,
      isFreeUser: isFreeUser,
      limit: count * 3, // Fetch extra for filtering
      excludeIds: recentIds,
    );

    // If not enough fresh items, include some from cooldown pool
    if (items.length < count) {
      final moreItems = await _db.getVocabularyItemsForQuiz(
        difficulty: difficulty,
        userLevel: userLevel,
        isFreeUser: isFreeUser,
        limit: count * 3,
      );
      final existingIds = items.map((i) => i.questionId).toSet();
      for (final item in moreItems) {
        if (!existingIds.contains(item.questionId)) {
          items.add(item);
          existingIds.add(item.questionId);
        }
        if (items.length >= count) break;
      }
    }

    // Shuffle and take what we need
    items.shuffle(_random);
    if (items.length > count) {
      items = items.sublist(0, count);
    }

    return items.map(_toQuizQuestion).toList();
  }

  /// Record an answer and update mastery tracking
  /// Returns true if the item was newly mastered this session
  Future<bool> recordAnswerWithMastery({
    required String questionId,
    required bool correct,
  }) async {
    // Check if this answer would cause new mastery BEFORE updating
    final wouldMaster = await _db.wouldBecomeNewlyMastered(
      questionId: questionId,
      correctFirstAttempt: correct,
    );

    // Update the vocabulary item progress
    await _db.updateVocabularyItemProgress(
      questionId: questionId,
      correctFirstAttempt: correct,
    );

    return wouldMaster;
  }

  /// Convert a VocabularyItem DB row to a QuizQuestion domain entity
  QuizQuestion _toQuizQuestion(VocabularyItem item) {
    List<String> options = [];
    try {
      final decoded = jsonDecode(item.options);
      if (decoded is List) {
        options = decoded.cast<String>();
      }
    } catch (_) {}

    return QuizQuestion(
      id: item.questionId,
      type: QuizType.fromString(item.type),
      category: QuizCategory.fromString(item.category),
      difficulty: item.difficulty,
      question: item.question,
      questionKo: item.questionKo,
      options: options,
      correctAnswer: item.correctAnswer,
      hint: item.hint,
      explanation: item.explanation,
      explanationKo: item.explanationKo,
    );
  }
}
