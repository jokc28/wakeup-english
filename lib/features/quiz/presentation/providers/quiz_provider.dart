import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/subscription_provider.dart';
import '../../../alarm/data/repositories/alarm_repository.dart';
import '../../data/repositories/quiz_repository.dart';
import '../../domain/entities/quiz_question.dart';

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

  const QuizSessionState({
    this.questions = const [],
    this.currentIndex = 0,
    this.answers = const [],
    this.isCompleted = false,
    this.startTime,
    this.selectedAnswer,
    this.showingResult = false,
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
  }) {
    return QuizSessionState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      answers: answers ?? this.answers,
      isCompleted: isCompleted ?? this.isCompleted,
      startTime: startTime ?? this.startTime,
      selectedAnswer: selectedAnswer,
      showingResult: showingResult ?? this.showingResult,
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

  /// Initialize quiz session for an alarm
  Future<void> initializeQuiz() async {
    final alarmRepo = ref.read(alarmRepositoryProvider);
    final quizRepo = ref.read(quizRepositoryProvider(ref.read(hasFullAccessProvider)));

    final alarm = await alarmRepo.getAlarmById(alarmId);
    if (alarm == null) return;

    var questions = await quizRepo.getRandomQuestions(
      count: alarm.quizCount,
      difficulty: alarm.quizDifficulty.name,
    );

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

    // Record the answer
    final responseTime = state.startTime != null
        ? DateTime.now().difference(state.startTime!).inMilliseconds
        : 0;

    final quizRepo = ref.read(quizRepositoryProvider(ref.read(hasFullAccessProvider)));
    await quizRepo.recordAnswer(
      questionId: question.id,
      correct: isCorrect,
      responseTimeMs: responseTime,
    );

    // Show result
    state = state.copyWith(
      selectedAnswer: answer,
      showingResult: true,
      answers: [...state.answers, isCorrect],
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

/// Provider for loading quiz questions
@riverpod
Future<List<QuizQuestion>> quizQuestions(
  Ref ref, {
  required int count,
  required String difficulty,
}) async {
  final repository = ref.watch(quizRepositoryProvider(ref.watch(hasFullAccessProvider)));
  return repository.getRandomQuestions(count: count, difficulty: difficulty);
}
