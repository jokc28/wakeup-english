import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_router.dart';
import '../../../alarm/presentation/providers/alarm_provider.dart';
import '../../domain/entities/quiz_question.dart';
import '../providers/quiz_provider.dart';
import '../widgets/multiple_choice_widget.dart';
import '../widgets/text_input_widget.dart';

/// Lock screen that appears when alarm fires
/// User must solve quiz to dismiss the alarm
class QuizLockScreen extends ConsumerStatefulWidget {
  final int alarmId;

  const QuizLockScreen({super.key, required this.alarmId});

  @override
  ConsumerState<QuizLockScreen> createState() => _QuizLockScreenState();
}

class _QuizLockScreenState extends ConsumerState<QuizLockScreen> {
  @override
  void initState() {
    super.initState();
    _initializeScreen();
  }

  Future<void> _initializeScreen() async {
    // Configure system UI for lock screen
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );

    // Set screen to stay on
    // Note: This requires additional setup in native code

    // Initialize quiz
    await ref.read(quizSessionProvider(widget.alarmId).notifier).initializeQuiz();
  }

  @override
  void dispose() {
    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(quizSessionProvider(widget.alarmId));
    final theme = Theme.of(context);

    // Prevent back navigation
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: SafeArea(
          child: session.questions.isEmpty
              ? _buildLoading()
              : session.isCompleted
                  ? _buildCompleted(session)
                  : _buildQuiz(session),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading quiz...'),
        ],
      ),
    );
  }

  Widget _buildCompleted(QuizSessionState session) {
    final theme = Theme.of(context);
    final correctCount = session.correctCount;
    final totalCount = session.questions.length;
    final percentage = (correctCount / totalCount * 100).round();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Success icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              size: 80,
              color: AppColors.success,
            ),
          ),
          const SizedBox(height: 32),

          // Result text
          Text(
            'Quiz Completed!',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Score
          Text(
            '$correctCount / $totalCount correct ($percentage%)',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 48),

          // Dismiss button
          FilledButton(
            onPressed: _dismissAlarm,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Stop Alarm',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuiz(QuizSessionState session) {
    final question = session.currentQuestion;
    if (question == null) return const SizedBox();

    final theme = Theme.of(context);

    return Column(
      children: [
        // Header with progress
        _buildHeader(session),

        // Question content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Question number
                Text(
                  'Question ${session.currentIndex + 1} of ${session.questions.length}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),

                // Question text
                Text(
                  question.question,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // Korean translation if available
                if (question.questionKo.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    question.questionKo,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                const SizedBox(height: 24),

                // Answer input based on question type
                _buildAnswerInput(question, session),

                // Explanation after answering
                if (session.showingResult && question.explanation != null) ...[
                  const SizedBox(height: 24),
                  _buildExplanation(question),
                ],
              ],
            ),
          ),
        ),

        // Bottom action button
        if (session.showingResult) _buildNextButton(session),
      ],
    );
  }

  Widget _buildHeader(QuizSessionState session) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Column(
        children: [
          // Time display
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.alarm,
                color: AppColors.secondary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Wake Up!',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: session.progress,
              backgroundColor: AppColors.primary.withValues(alpha: 0.15),
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerInput(QuizQuestion question, QuizSessionState session) {
    switch (question.type) {
      case QuizType.multipleChoice:
        return MultipleChoiceWidget(
          question: question,
          selectedAnswer: session.selectedAnswer,
          showResult: session.showingResult,
          onSelect: (answer) {
            ref
                .read(quizSessionProvider(widget.alarmId).notifier)
                .selectAnswer(answer);
            // Auto-submit for multiple choice
            ref
                .read(quizSessionProvider(widget.alarmId).notifier)
                .submitAnswer(answer);
          },
        );

      case QuizType.fillInTheBlank:
      case QuizType.translation:
        return TextInputWidget(
          question: question,
          showResult: session.showingResult,
          isCorrect: session.answers.isNotEmpty && session.answers.last,
          onSubmit: (answer) {
            ref
                .read(quizSessionProvider(widget.alarmId).notifier)
                .submitAnswer(answer);
          },
        );

      case QuizType.listening:
        // TODO: Implement listening type
        return MultipleChoiceWidget(
          question: question,
          selectedAnswer: session.selectedAnswer,
          showResult: session.showingResult,
          onSelect: (answer) {
            ref
                .read(quizSessionProvider(widget.alarmId).notifier)
                .selectAnswer(answer);
            ref
                .read(quizSessionProvider(widget.alarmId).notifier)
                .submitAnswer(answer);
          },
        );
    }
  }

  Widget _buildExplanation(QuizQuestion question) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 20,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                'Explanation',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            question.explanation!,
            style: theme.textTheme.bodyMedium,
          ),
          if (question.explanationKo != null) ...[
            const SizedBox(height: 8),
            Text(
              question.explanationKo!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNextButton(QuizSessionState session) {
    final isLastQuestion =
        session.currentIndex >= session.questions.length - 1;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: FilledButton(
          onPressed: () {
            ref.read(quizSessionProvider(widget.alarmId).notifier).nextQuestion();
          },
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            isLastQuestion ? 'Finish Quiz' : 'Next Question',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Future<void> _dismissAlarm() async {
    // Stop the alarm
    await ref.read(alarmOperationsProvider.notifier).stopAlarm(widget.alarmId);

    // Navigate back to alarm list
    if (mounted) {
      AppRouter.navigateToAlarmList();
    }
  }
}
