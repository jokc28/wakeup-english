import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/services/alarm_service.dart';
import '../../../../core/constants/iap_constants.dart';
import '../../domain/entities/quiz_question.dart';
import '../models/quiz_question_model.dart';

/// Provider for QuizRepository
final quizRepositoryProvider = Provider.family<QuizRepository, bool>(
  (ref, hasFullAccess) {
    final db = ref.watch(databaseProvider);
    return QuizRepository(db, hasFullAccess: hasFullAccess);
  },
);

/// Repository for quiz questions and progress
class QuizRepository {
  final AppDatabase _db;
  final bool hasFullAccess;
  List<QuizQuestion>? _cachedQuestions;
  final _random = Random();

  QuizRepository(this._db, {this.hasFullAccess = false});

  /// Load all quiz questions from JSON asset
  /// If user doesn't have full access, only returns free tier questions
  Future<List<QuizQuestion>> loadAllQuestions() async {
    if (_cachedQuestions != null) {
      return _cachedQuestions!;
    }

    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/quiz_questions.json',
      );
      final jsonList = jsonDecode(jsonString) as List<dynamic>;

      var questions = jsonList
          .map((json) => QuizQuestionModel.fromJson(json as Map<String, dynamic>).toEntity())
          .toList();

      // Filter to free questions if no full access
      if (!hasFullAccess) {
        questions = questions
            .where((q) => IapConstants.freeQuizQuestionIds.contains(q.id))
            .toList();
      }

      _cachedQuestions = questions;
      return _cachedQuestions!;
    } catch (e) {
      // Return default questions if loading fails
      return _getDefaultQuestions();
    }
  }

  /// Get questions filtered by difficulty
  Future<List<QuizQuestion>> getQuestionsByDifficulty(String difficulty) async {
    final allQuestions = await loadAllQuestions();
    return allQuestions.where((q) => q.difficulty == difficulty).toList();
  }

  /// Get questions filtered by category
  Future<List<QuizQuestion>> getQuestionsByCategory(
    QuizCategory category,
  ) async {
    final allQuestions = await loadAllQuestions();
    return allQuestions.where((q) => q.category == category).toList();
  }

  /// Get random questions for an alarm quiz
  /// Filters out questions shown within the last 3 days (no-repeat cooldown).
  /// Falls back to oldest-shown questions if all are in cooldown.
  Future<List<QuizQuestion>> getRandomQuestions({
    required int count,
    required String difficulty,
  }) async {
    final questions = await getQuestionsByDifficulty(difficulty);

    if (questions.isEmpty) {
      final allQuestions = await loadAllQuestions();
      return _selectRandom(allQuestions, count);
    }

    // Apply 3-day no-repeat cooldown
    final recentIds = await _db.getRecentlyShownQuestionIds(cooldownDays: 3);
    final fresh = questions.where((q) => !recentIds.contains(q.id)).toList();

    if (fresh.length >= count) {
      return _selectRandom(fresh, count);
    }

    // Not enough fresh questions — use fresh ones first, fill rest from cooldown pool
    // sorted by oldest lastShownAt (so least-recently-seen come first)
    final cooldownPool = questions.where((q) => recentIds.contains(q.id)).toList();
    final result = List<QuizQuestion>.from(fresh);
    result.addAll(_selectRandom(cooldownPool, count - result.length));
    result.shuffle(_random);
    return result;
  }

  /// Get questions prioritizing ones the user struggles with
  Future<List<QuizQuestion>> getAdaptiveQuestions({
    required int count,
    required String difficulty,
  }) async {
    final questions = await getQuestionsByDifficulty(difficulty);
    final weakQuestions = await _db.getWeakQuestions(limit: count);

    // Prioritize weak questions
    final weakIds = weakQuestions.map((q) => q.questionId).toSet();
    final prioritized = <QuizQuestion>[];
    final others = <QuizQuestion>[];

    for (final q in questions) {
      if (weakIds.contains(q.id)) {
        prioritized.add(q);
      } else {
        others.add(q);
      }
    }

    // Mix prioritized with some random ones
    final result = <QuizQuestion>[];
    final prioritizedCount = (count * 0.6).ceil();

    result.addAll(_selectRandom(prioritized, prioritizedCount));
    result.addAll(_selectRandom(others, count - result.length));

    return result;
  }

  /// Record a quiz answer
  Future<void> recordAnswer({
    required String questionId,
    required bool correct,
    required int responseTimeMs,
  }) async {
    final existing = await _db.getQuizProgress(questionId);

    if (existing != null) {
      // Update existing progress
      final newTimesShown = existing.timesShown + 1;
      final newTimesCorrect =
          existing.timesCorrect + (correct ? 1 : 0);
      final newTimesIncorrect =
          existing.timesIncorrect + (correct ? 0 : 1);

      // Calculate new average response time
      final newAvgTime = ((existing.avgResponseTimeMs * existing.timesShown) +
              responseTimeMs) ~/
          newTimesShown;

      // Calculate performance rating (0-100)
      final performance =
          ((newTimesCorrect / newTimesShown) * 100).round();

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
      // Create new progress entry
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

  List<QuizQuestion> _selectRandom(List<QuizQuestion> questions, int count) {
    if (questions.length <= count) {
      return List.from(questions)..shuffle(_random);
    }

    final shuffled = List<QuizQuestion>.from(questions)..shuffle(_random);
    return shuffled.take(count).toList();
  }

  /// Default questions when JSON fails to load
  List<QuizQuestion> _getDefaultQuestions() {
    return [
      const QuizQuestion(
        id: 'default_1',
        type: QuizType.multipleChoice,
        category: QuizCategory.vocabulary,
        difficulty: 'easy',
        question: 'What is the opposite of "happy"?',
        questionKo: '"행복한"의 반대말은 무엇인가요?',
        options: ['Sad', 'Angry', 'Excited', 'Tired'],
        correctAnswer: 'Sad',
        explanation: '"Sad" means feeling unhappy or sorrowful.',
        explanationKo: '"Sad"는 불행하거나 슬픈 감정을 의미합니다.',
      ),
      const QuizQuestion(
        id: 'default_2',
        type: QuizType.multipleChoice,
        category: QuizCategory.vocabulary,
        difficulty: 'easy',
        question: 'Choose the correct word: "I ___ to school every day."',
        questionKo: '올바른 단어를 선택하세요: "나는 매일 학교에 ___."',
        options: ['go', 'goes', 'going', 'went'],
        correctAnswer: 'go',
        explanation: 'With "I", we use the base form of the verb.',
        explanationKo: '"I"와 함께 동사의 기본형을 사용합니다.',
      ),
      const QuizQuestion(
        id: 'default_3',
        type: QuizType.multipleChoice,
        category: QuizCategory.vocabulary,
        difficulty: 'medium',
        question: 'What does "perseverance" mean?',
        questionKo: '"perseverance"는 무엇을 의미하나요?',
        options: [
          'Giving up easily',
          'Continued effort despite difficulties',
          'Being lazy',
          'Moving quickly',
        ],
        correctAnswer: 'Continued effort despite difficulties',
        explanation:
            'Perseverance means persistence in doing something despite difficulty.',
        explanationKo: 'Perseverance는 어려움에도 불구하고 무언가를 지속하는 것을 의미합니다.',
      ),
      const QuizQuestion(
        id: 'default_4',
        type: QuizType.multipleChoice,
        category: QuizCategory.grammar,
        difficulty: 'medium',
        question:
            'Which sentence is correct?',
        questionKo: '어떤 문장이 맞나요?',
        options: [
          'She don\'t like coffee',
          'She doesn\'t like coffee',
          'She not like coffee',
          'She no like coffee',
        ],
        correctAnswer: 'She doesn\'t like coffee',
        explanation:
            'With third person singular (she/he/it), we use "doesn\'t" for negation.',
        explanationKo: '3인칭 단수(she/he/it)에는 부정문에서 "doesn\'t"를 사용합니다.',
      ),
      const QuizQuestion(
        id: 'default_5',
        type: QuizType.multipleChoice,
        category: QuizCategory.idioms,
        difficulty: 'hard',
        question: 'What does "break a leg" mean?',
        questionKo: '"break a leg"은 무엇을 의미하나요?',
        options: [
          'Get injured',
          'Good luck',
          'Run fast',
          'Be careful',
        ],
        correctAnswer: 'Good luck',
        explanation:
            '"Break a leg" is an idiom meaning "good luck", often used in theater.',
        explanationKo: '"Break a leg"은 "행운을 빕니다"를 의미하는 관용구로, 주로 연극계에서 사용됩니다.',
      ),
    ];
  }
}
