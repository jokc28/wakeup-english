import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
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

    // Some source datasets do not contain every app difficulty bucket.
    // If the selected difficulty is sparse (notably hard), keep the alarm
    // mission usable by falling back to the user's accessible pool.
    if (items.length < count) {
      final anyDifficultyItems = await _db.getVocabularyItemsForQuiz(
        userLevel: userLevel,
        isFreeUser: isFreeUser,
        limit: count * 3,
        excludeIds: recentIds,
      );
      final existingIds = items.map((i) => i.questionId).toSet();
      for (final item in anyDifficultyItems) {
        if (!existingIds.contains(item.questionId)) {
          items.add(item);
          existingIds.add(item.questionId);
        }
        if (items.length >= count) break;
      }
    }

    // Prefer weak review items, then keep enough randomness for variety.
    items.sort(_compareForReviewPriority);
    final reviewSliceLength = min(items.length, count * 2);
    final reviewSlice = items.sublist(0, reviewSliceLength)..shuffle(_random);
    final rest = items.sublist(reviewSliceLength)..shuffle(_random);
    items = [...reviewSlice, ...rest];
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
    var options = <String>[];
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
      source: item.source,
      sourceUrl: item.sourceUrl,
      sourceLabel: item.sourceLabel,
    );
  }

  int _compareForReviewPriority(VocabularyItem a, VocabularyItem b) {
    final aScore = _reviewPriorityScore(a);
    final bScore = _reviewPriorityScore(b);
    final scoreCompare = bScore.compareTo(aScore);
    if (scoreCompare != 0) return scoreCompare;

    final aLast = a.lastPresentedAt;
    final bLast = b.lastPresentedAt;
    if (aLast == null && bLast != null) return -1;
    if (aLast != null && bLast == null) return 1;
    if (aLast != null && bLast != null) {
      return aLast.compareTo(bLast);
    }
    return a.questionId.compareTo(b.questionId);
  }

  int _reviewPriorityScore(VocabularyItem item) {
    var score = 0;
    if (!item.isMastered) score += 20;
    score += item.timesIncorrect * 8;

    if (item.timesPresented > 0) {
      final correctRate = item.timesCorrectFirstAttempt / item.timesPresented;
      if (correctRate < 0.6) score += 12;
      if (correctRate < 0.4) score += 12;
    }

    final lastPresentedAt = item.lastPresentedAt;
    if (lastPresentedAt == null) {
      score += 6;
    } else if (DateTime.now().difference(lastPresentedAt).inDays >= 7) {
      score += 6;
    }

    return score;
  }
}
