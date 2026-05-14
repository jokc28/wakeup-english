import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/mission_type_provider.dart';
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
  double get progress =>
      questions.isEmpty ? 0 : currentIndex / questions.length;

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
      id: 'fallback_reel_put_yourself_out_there',
      type: QuizType.multipleChoice,
      category: QuizCategory.phrases,
      difficulty: 'medium',
      question: '다음 상황에서 가장 자연스러운 영어 표현은?',
      questionKo: '적극적으로 나서다 · 용기를 내서 사람 만날 때',
      options: [
        'Put yourself out there',
        'squeeze in',
        'corny',
        'back out',
      ],
      correctAnswer: 'Put yourself out there',
      hint: '출처: @ok.english.kr Instagram Reel',
    ),
    QuizQuestion(
      id: 'fallback_reel_squeeze_in',
      type: QuizType.multipleChoice,
      category: QuizCategory.phrases,
      difficulty: 'medium',
      question: '다음 상황에서 가장 자연스러운 영어 표현은?',
      questionKo: '시간을 끼워 넣다 · 바쁜 와중에 시간을 낼 때',
      options: [
        'squeeze in',
        'Put yourself out there',
        'make it count',
        'stay in',
      ],
      correctAnswer: 'squeeze in',
      hint: '출처: @ok.english.kr Instagram Reel',
    ),
    QuizQuestion(
      id: 'fallback_reel_corny',
      type: QuizType.multipleChoice,
      category: QuizCategory.vocabulary,
      difficulty: 'easy',
      question: '다음 상황에서 가장 자연스러운 영어 표현은?',
      questionKo: '뻔한 · 재미없는 상황을 표현할 때',
      options: [
        'corny',
        'back out',
        'Sounds fair enough',
        'I feel sluggish',
      ],
      correctAnswer: 'corny',
      hint: '출처: @ok.english.kr Instagram Reel',
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

    // If the DB is empty, use only verified Reel-derived fallback items.
    if (questions.isEmpty) {
      questions = List.of(_fallbackQuestions);
    }

    // Take only what we need
    if (questions.length > quizCount) {
      questions = questions.sublist(0, quizCount);
    }

    questions = applyMissionTypes(
      questions,
      ref.read(missionTypeProvider),
    );

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

    final quizRepo =
        ref.read(quizRepositoryProvider(ref.read(hasFullAccessProvider)));
    await quizRepo.recordAnswer(
      questionId: question.id,
      correct: isCorrect,
      responseTimeMs: responseTime,
    );

    // Record in VocabularyItems with mastery tracking (only for users with full access)
    final hasFullAccess = ref.read(hasFullAccessProvider);
    var newlyMastered = false;
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
      final missedQuestions = <QuizQuestion>[];
      for (var i = 0; i < state.questions.length; i++) {
        if (i >= state.answers.length || !state.answers[i]) {
          missedQuestions.add(state.questions[i]);
        }
      }

      if (missedQuestions.isNotEmpty) {
        state = state.copyWith(
          questions: missedQuestions,
          currentIndex: 0,
          answers: [],
          showingResult: false,
          startTime: DateTime.now(),
        );
        return;
      }

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
    return state.isCompleted && state.incorrectCount == 0;
  }
}

/// Provider to check if quiz is solved (for alarm dismissal)
@riverpod
bool isQuizSolved(Ref ref, int alarmId) {
  final session = ref.watch(quizSessionProvider(alarmId));
  return session.isCompleted;
}
