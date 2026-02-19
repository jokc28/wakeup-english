import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:flutter/foundation.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/services/streak_provider.dart';
import '../../../../core/services/subscription_provider.dart';
import '../../../../core/services/subscription_service.dart';
import '../../../alarm/presentation/providers/alarm_provider.dart';
import '../../domain/entities/quiz_question.dart';
import '../providers/quiz_provider.dart';
import '../widgets/animated_clock_widget.dart';
import '../widgets/multiple_choice_widget.dart';
import '../widgets/slide_to_start_widget.dart';
import '../widgets/speaking_challenge_widget.dart';
import '../widgets/text_input_widget.dart';
import '../widgets/word_scramble_widget.dart';

enum LockScreenPhase { alarm, quiz, completed }

/// Lock screen that appears when alarm fires
/// User must solve quiz to dismiss the alarm
class QuizLockScreen extends ConsumerStatefulWidget {
  final int alarmId;

  const QuizLockScreen({super.key, required this.alarmId});

  @override
  ConsumerState<QuizLockScreen> createState() => _QuizLockScreenState();
}

class _QuizLockScreenState extends ConsumerState<QuizLockScreen>
    with TickerProviderStateMixin {
  LockScreenPhase _phase = LockScreenPhase.alarm;
  late ConfettiController _confettiController;
  late AnimationController _bgShimmerController;
  late Animation<double> _bgShimmerAnimation;

  // Feedback overlay state
  bool _showCorrectOverlay = false;
  bool _showWrongShake = false;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _bgShimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _bgShimmerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bgShimmerController, curve: Curves.easeInOut),
    );
    _initializeScreen();
  }

  Future<void> _initializeScreen() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    await ref
        .read(quizSessionProvider(widget.alarmId).notifier)
        .initializeQuiz();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _bgShimmerController.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  void _onSlideComplete() {
    HapticFeedback.mediumImpact();
    setState(() => _phase = LockScreenPhase.quiz);
  }

  void _triggerCorrectFeedback() {
    HapticFeedback.mediumImpact();
    _confettiController.play();
    setState(() => _showCorrectOverlay = true);
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) setState(() => _showCorrectOverlay = false);
    });
  }

  void _triggerWrongFeedback() {
    HapticFeedback.heavyImpact();
    setState(() => _showWrongShake = true);
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) setState(() => _showWrongShake = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(quizSessionProvider(widget.alarmId));

    // Listen for answer results to trigger feedback
    ref.listen(quizSessionProvider(widget.alarmId), (prev, next) {
      if (prev != null &&
          next.showingResult &&
          !prev.showingResult &&
          _phase == LockScreenPhase.quiz) {
        final isCorrect = next.answers.isNotEmpty && next.answers.last;
        if (isCorrect) {
          _triggerCorrectFeedback();
        } else {
          _triggerWrongFeedback();
        }
      }
      if (next.isCompleted && _phase != LockScreenPhase.completed) {
        setState(() => _phase = LockScreenPhase.completed);
        _confettiController.play();
      }
    });

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            // Content
            _buildPhaseContent(session),
            // Correct answer green flash
            if (_showCorrectOverlay)
              AnimatedOpacity(
                opacity: _showCorrectOverlay ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: IgnorePointer(
                  child: Container(
                    color: AppColors.quizCorrect.withValues(alpha: 0.15),
                  ),
                ),
              ),
            // Confetti
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                numberOfParticles: 20,
                maxBlastForce: 20,
                minBlastForce: 5,
                gravity: 0.2,
                colors: const [
                  AppColors.action,
                  AppColors.primaryLight,
                  AppColors.primary,
                  AppColors.info,
                  Colors.white,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseContent(QuizSessionState session) {
    switch (_phase) {
      case LockScreenPhase.alarm:
        return _buildAlarmPhase();
      case LockScreenPhase.quiz:
        if (session.questions.isEmpty) return _buildLoading();
        return _buildQuizPhase(session);
      case LockScreenPhase.completed:
        return _buildCompletedPhase(session);
    }
  }

  // --- Alarm Phase ---
  Widget _buildAlarmPhase() {
    return AnimatedBuilder(
      animation: _bgShimmerAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(AppColors.gradientStart, AppColors.gradientEnd,
                        _bgShimmerAnimation.value * 0.3) ??
                    AppColors.gradientStart,
                Color.lerp(AppColors.gradientEnd, AppColors.gradientStart,
                        _bgShimmerAnimation.value * 0.3) ??
                    AppColors.gradientEnd,
              ],
            ),
          ),
          child: child,
        );
      },
      child: Builder(
        builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // Greeting
              Text(
                l10n.goodMorningGreeting,
                style: GoogleFonts.jua(
                  fontSize: 28,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              )
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 200.ms)
                  .slideY(begin: -0.2, end: 0),
              const SizedBox(height: 16),
              // Massive clock
              const AnimatedClockWidget(),
              const Spacer(flex: 3),
              // Slide to start
              SlideToStartWidget(onSlideComplete: _onSlideComplete),
              const SizedBox(height: 48),
            ],
          ),
        ),
        );
        },
      ),
    );
  }

  Widget _buildLoading() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      color: AppColors.backgroundLight,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: AppColors.primary),
            const SizedBox(height: 16),
            Text(l10n.loadingQuiz),
          ],
        ),
      ),
    );
  }

  // --- Quiz Phase ---
  Widget _buildQuizPhase(QuizSessionState session) {
    final question = session.currentQuestion;
    if (question == null) return const SizedBox();

    final theme = Theme.of(context);

    return Container(
      color: AppColors.backgroundLight,
      child: SafeArea(
        child: Column(
          children: [
            // Progress header
            _buildQuizHeader(session),
            // Question content in floating card
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: _buildQuizCard(question, session, theme),
              ),
            ),
            // Bottom action button
            if (session.showingResult) _buildNextButton(session),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizHeader(QuizSessionState session) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Column(
        children: [
          // Question counter
          Text(
            '${session.currentIndex + 1} / ${session.questions.length}',
            style: GoogleFonts.jua(
              fontSize: 18,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          // Thick progress bar
          LinearPercentIndicator(
            lineHeight: 12,
            percent: session.progress.clamp(0.0, 1.0),
            backgroundColor: AppColors.quizOption,
            progressColor: AppColors.action,
            barRadius: const Radius.circular(6),
            padding: EdgeInsets.zero,
            animation: true,
            animationDuration: 300,
            animateFromLastPercent: true,
          ),
        ],
      ),
    );
  }

  Widget _buildQuizCard(
      QuizQuestion question, QuizSessionState session, ThemeData theme) {
    final cardContent = Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Question text
          Text(
            question.question,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          // Korean translation
          if (question.questionKo.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              question.questionKo,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondaryLight,
              ),
            ),
          ],
          const SizedBox(height: 24),
          // Answer input
          _buildAnswerInput(question, session),
          // Explanation
          if (session.showingResult && question.explanation != null) ...[
            const SizedBox(height: 24),
            _buildExplanation(question),
          ],
        ],
      ),
    );

    // Wrap with shake animation for wrong answers
    if (_showWrongShake) {
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 300),
        builder: (context, value, child) {
          final shake =
              (value < 0.5 ? value * 2 : (1 - value) * 2) * 10;
          final dir = (value * 4).floor() % 2 == 0 ? 1 : -1;
          return Transform.translate(
            offset: Offset(shake * dir, 0),
            child: child,
          );
        },
        child: cardContent,
      );
    }

    return cardContent
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.05, end: 0);
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

      case QuizType.wordScramble:
        return WordScrambleWidget(
          question: question,
          showResult: session.showingResult,
          isCorrect: session.answers.isNotEmpty && session.answers.last,
          onSubmit: (answer) {
            ref
                .read(quizSessionProvider(widget.alarmId).notifier)
                .submitAnswer(answer);
          },
        );

      case QuizType.speakingChallenge:
        return SpeakingChallengeWidget(
          question: question,
          showResult: session.showingResult,
          isCorrect: session.answers.isNotEmpty && session.answers.last,
          onSubmit: (answer) {
            ref
                .read(quizSessionProvider(widget.alarmId).notifier)
                .submitAnswer(answer);
          },
        );
    }
  }

  Widget _buildExplanation(QuizQuestion question) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.quizOption,
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
                color: AppColors.textSecondaryLight,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.explanationLabel,
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
                color: AppColors.textSecondaryLight,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNextButton(QuizSessionState session) {
    final l10n = AppLocalizations.of(context)!;
    final isLastQuestion =
        session.currentIndex >= session.questions.length - 1;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: FilledButton(
          onPressed: () {
            ref
                .read(quizSessionProvider(widget.alarmId).notifier)
                .nextQuestion();
          },
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.action,
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            isLastQuestion ? l10n.quizCompleteButton : l10n.nextQuestionButton,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  // --- Completed Phase ---
  Widget _buildCompletedPhase(QuizSessionState session) {
    final l10n = AppLocalizations.of(context)!;
    final correctCount = session.correctCount;
    final totalCount = session.questions.length;

    return Container(
      color: AppColors.backgroundLight,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Green checkmark circle
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: AppColors.action,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 72,
                  color: Colors.white,
                ),
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.5, 0.5),
                    end: const Offset(1.0, 1.0),
                    duration: 500.ms,
                    curve: Curves.easeOutBack,
                  )
                  .fadeIn(),
              const SizedBox(height: 32),
              // Score display
              Text(
                l10n.scoreDisplay(correctCount, totalCount),
                style: GoogleFonts.jua(
                  fontSize: 36,
                  color: AppColors.textPrimaryLight,
                ),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 8),
              Text(
                l10n.quizCompletedMessage,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondaryLight,
                ),
              ).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: 24),
              // Streak badge
              Consumer(
                builder: (context, ref, _) {
                  final streak = ref.watch(streakProvider);
                  if (streak.currentStreak < 1) return const SizedBox();
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.quizStreak.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🔥', style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 8),
                        Text(
                          l10n.streakDays(streak.currentStreak),
                          style: GoogleFonts.jua(
                            fontSize: 18,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 600.ms).scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.0, 1.0),
                  );
                },
              ),
              const Spacer(),
              // Dismiss button
              FilledButton(
                onPressed: _dismissAlarm,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.action,
                  minimumSize: const Size.fromHeight(56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  l10n.dismissAlarmButton,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _dismissAlarm() async {
    final subState = ref.read(subscriptionProvider);
    if (!subState.isPremium) {
      final trialExpired = await SubscriptionService.isTrialExpired();
      if (trialExpired && mounted) {
        _showTrialExpiredPaywall();
        return;
      }
    }

    // Record streak completion
    await ref.read(streakProvider.notifier).recordCompletion();

    await ref.read(alarmOperationsProvider.notifier).stopAlarm(widget.alarmId);

    if (mounted) {
      AppRouter.navigateToAlarmList();
    }
  }

  void _showTrialExpiredPaywall() {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          l10n.trialExpiredTitle,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.workspace_premium,
                size: 36,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.trialExpiredMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
        actions: [
          if (kDebugMode)
            TextButton(
              onPressed: () async {
                final service = ref.read(subscriptionServiceProvider);
                final success = await service.restorePurchases();
                if (success && mounted) {
                  ref.read(subscriptionProvider.notifier).refresh();
                  Navigator.of(context).pop();
                  _dismissAlarm();
                }
              },
              child: Text(l10n.restorePurchasesDebug),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              AppRouter.navigateToPaywall();
            },
            child: Text(l10n.subscribeButton),
          ),
        ],
      ),
    );
  }
}
