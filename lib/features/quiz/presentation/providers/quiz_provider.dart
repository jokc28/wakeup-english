import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/subscription_provider.dart';
import '../../../alarm/data/repositories/alarm_repository.dart';
import '../../data/repositories/quiz_repository.dart';
import '../../data/repositories/vocabulary_repository.dart';
import '../../domain/entities/quiz_question.dart';
import 'level_progress_provider.dart';

part 'quiz_provider.g.dart';

/// State for the quiz session
class QuizSessionState {
  final List<QuizQuestion> questions;
  final int currentIndex;
  final List<bool> answers; // true = correct, false = incorrect
  final bool isCompleted;
  final DateTime? startTime;
  final String? selectedAnswer;
  final bool showingResult;
  final int newMasteryCount; // Items newly mastered this session

  const QuizSessionState({
    this.questions = const [],
    this.currentIndex = 0,
    this.answers = const [],
    this.isCompleted = false,
    this.startTime,
    this.selectedAnswer,
    this.showingResult = false,
    this.newMasteryCount = 0,
  });

  QuizQuestion? get currentQuestion {
    if (currentIndex >= questions.length) return null;
    return questions[currentIndex];
  }

  int get questionsRemaining => questions.length - currentIndex;
  int get correctCount => answers.where((a) => a).length;
  int get incorrectCount => answers.where((a) => !a).length;
  double get progress => questions.isEmpty ? 0 : currentIndex / questions.length;

  QuizSessionState copyWith({
    List<QuizQuestion>? questions,
    int? currentIndex,
    List<bool>? answers,
    bool? isCompleted,
    DateTime? startTime,
    String? selectedAnswer,
    bool? showingResult,
    int? newMasteryCount,
  }) {
    return QuizSessionState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      answers: answers ?? this.answers,
      isCompleted: isCompleted ?? this.isCompleted,
      startTime: startTime ?? this.startTime,
      selectedAnswer: selectedAnswer,
      showingResult: showingResult ?? this.showingResult,
      newMasteryCount: newMasteryCount ?? this.newMasteryCount,
    );
  }
}

/// Provider for the quiz session
@riverpod
class QuizSession extends _$QuizSession {
  @override
  QuizSessionState build(int alarmId) {
    return const QuizSessionState();
  }

  /// Hardcoded emergency fallback questions when DB is empty
  static const _fallbackQuestions = [
    QuizQuestion(
      id: 'fallback_hello',
      type: QuizType.wordScramble,
      category: QuizCategory.vocabulary,
      difficulty: 'easy',
      question: 'HELLO',
      questionKo: '안녕, 인사말',
      correctAnswer: 'HELLO',
      hint: '안녕, 인사말 (비상용 퀴즈)',
    ),
    QuizQuestion(
      id: 'fallback_morning',
      type: QuizType.wordScramble,
      category: QuizCategory.vocabulary,
      difficulty: 'easy',
      question: 'MORNING',
      questionKo: '아침, 오전',
      correctAnswer: 'MORNING',
      hint: '아침, 오전 (비상용 퀴즈)',
    ),
    QuizQuestion(
      id: 'fallback_energy',
      type: QuizType.wordScramble,
      category: QuizCategory.vocabulary,
      difficulty: 'easy',
      question: 'ENERGY',
      questionKo: '에너지, 활력',
      correctAnswer: 'ENERGY',
      hint: '에너지, 활력 (비상용 퀴즈)',
    ),
  ];

  /// Initialize quiz session for an alarm
  Future<void> initializeQuiz() async {
    final alarmRepo = ref.read(alarmRepositoryProvider);
    final hasFullAccess = ref.read(hasFullAccessProvider);
    final vocabRepo = ref.read(vocabularyRepositoryProvider);
    final levelState = ref.read(levelProgressProvider);

    final alarm = await alarmRepo.getAlarmById(alarmId);
    final quizCount = alarm?.quizCount ?? 3;

    List<QuizQuestion> questions;
    try {
      questions = await vocabRepo
          .getRandomQuestions(
            count: quizCount,
            difficulty: alarm?.quizDifficulty.name ?? 'easy',
            userLevel: levelState.currentLevel,
            isFreeUser: !hasFullAccess,
          )
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      // DB error or timeout — use fallback
      questions = [];
    }

    // Filter out answers too short for word scramble (< 5 chars for single words)
    questions = questions.where((q) {
      final answer = q.correctAnswer.trim();
      final isSingleWord = !answer.contains(' ');
      return !isSingleWord || answer.length >= 5;
    }).toList();

    // If filtering removed too many, re-fetch without filter
    if (questions.length < quizCount) {
      try {
        final extra = await vocabRepo
            .getRandomQuestions(
              count: quizCount * 3,
              difficulty: alarm?.quizDifficulty.name ?? 'easy',
              userLevel: levelState.currentLevel,
              isFreeUser: !hasFullAccess,
            )
            .timeout(const Duration(seconds: 5));
        final filtered = extra.where((q) {
          final answer = q.correctAnswer.trim();
          final isSingleWord = !answer.contains(' ');
          return !isSingleWord || answer.length >= 5;
        }).toList();
        // Merge, deduplicate, take what we need
        final ids = questions.map((q) => q.id).toSet();
        for (final q in filtered) {
          if (!ids.contains(q.id)) {
            questions.add(q);
            ids.add(q.id);
          }
          if (questions.length >= quizCount) break;
        }
      } catch (_) {
        // Re-fetch also failed, continue with what we have
      }
    }

    // CRITICAL: If DB returned nothing, inject hardcoded fallback
    if (questions.isEmpty) {
      questions = List.of(_fallbackQuestions);
    }

    // Take only what we need
    if (questions.length > quizCount) {
      questions = questions.sublist(0, quizCount);
    }

    // Convert all questions to word scramble format
    questions = questions.map((q) => q.copyWith(
      type: QuizType.wordScramble,
      options: [],
    )).toList();

    state = state.copyWith(
      questions: questions,
      currentIndex: 0,
      answers: [],
      isCompleted: false,
      startTime: DateTime.now(),
      newMasteryCount: 0,
    );
  }

  /// Select an answer (for multiple choice)
  void selectAnswer(String answer) {
    if (state.showingResult) return;
    state = state.copyWith(selectedAnswer: answer);
  }

  /// Submit the current answer
  Future<bool> submitAnswer(String answer) async {
    final question = state.currentQuestion;
    if (question == null) return false;

    final isCorrect = question.checkAnswer(answer);

    // Record the answer in old QuizProgress table (backward compat)
    final responseTime = state.startTime != null
        ? DateTime.now().difference(state.startTime!).inMilliseconds
        : 0;

    final quizRepo = ref.read(quizRepositoryProvider(ref.read(hasFullAccessProvider)));
    await quizRepo.recordAnswer(
      questionId: question.id,
      correct: isCorrect,
      responseTimeMs: responseTime,
    );

    // Record in VocabularyItems with mastery tracking (only for users with full access)
    final hasFullAccess = ref.read(hasFullAccessProvider);
    bool newlyMastered = false;
    if (hasFullAccess) {
      final vocabRepo = ref.read(vocabularyRepositoryProvider);
      newlyMastered = await vocabRepo.recordAnswerWithMastery(
        questionId: question.id,
        correct: isCorrect,
      );
    }

    // Show result
    state = state.copyWith(
      selectedAnswer: answer,
      showingResult: true,
      answers: [...state.answers, isCorrect],
      newMasteryCount: state.newMasteryCount + (newlyMastered ? 1 : 0),
    );

    return isCorrect;
  }

  /// Move to next question
  void nextQuestion() {
    final nextIndex = state.currentIndex + 1;

    if (nextIndex >= state.questions.length) {
      // Quiz completed
      state = state.copyWith(
        isCompleted: true,
        showingResult: false,
      );
    } else {
      state = state.copyWith(
        currentIndex: nextIndex,
        showingResult: false,
        startTime: DateTime.now(),
      );
    }
  }

  /// Check if all required questions are answered correctly
  bool canDismissAlarm() {
    // Require all questions answered (whether correct or not)
    return state.isCompleted;
  }
}

/// Provider to check if quiz is solved (for alarm dismissal)
@riverpod
bool isQuizSolved(Ref ref, int alarmId) {
  final session = ref.watch(quizSessionProvider(alarmId));
  return session.isCompleted;
}
