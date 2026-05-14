import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/quiz_question.dart';

/// Widget for displaying multiple choice quiz options
/// With staggered fade-in and haptic feedback
class MultipleChoiceWidget extends StatelessWidget {
  final QuizQuestion question;
  final String? selectedAnswer;
  final bool showResult;
  final ValueChanged<String> onSelect;

  const MultipleChoiceWidget({
    required this.question,
    required this.onSelect,
    super.key,
    this.selectedAnswer,
    this.showResult = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: question.options.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;
        final isSelected = selectedAnswer == option;
        final isCorrect = option == question.correctAnswer;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _OptionButton(
            label: String.fromCharCode(65 + index),
            text: option,
            isSelected: isSelected,
            isCorrect: showResult && isCorrect,
            isIncorrect: showResult && isSelected && !isCorrect,
            showResult: showResult,
            onTap: showResult
                ? null
                : () {
                    HapticFeedback.lightImpact();
                    onSelect(option);
                  },
          )
              .animate()
              .fadeIn(
                delay: (80 * index).ms,
                duration: 300.ms,
              )
              .slideX(
                begin: 0.05,
                end: 0,
                delay: (80 * index).ms,
                duration: 300.ms,
              ),
        );
      }).toList(),
    );
  }
}

class _OptionButton extends StatelessWidget {
  final String label;
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool isIncorrect;
  final bool showResult;
  final VoidCallback? onTap;

  const _OptionButton({
    required this.label,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.isIncorrect,
    required this.showResult,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color backgroundColor;
    Color borderColor;
    Color textColor;

    if (showResult) {
      if (isCorrect) {
        backgroundColor = AppColors.quizCorrectBg;
        borderColor = AppColors.quizCorrect;
        textColor = AppColors.quizCorrect;
      } else if (isIncorrect) {
        backgroundColor = AppColors.quizIncorrectBg;
        borderColor = AppColors.quizIncorrect;
        textColor = AppColors.quizIncorrect;
      } else {
        backgroundColor = theme.colorScheme.surface;
        borderColor = AppColors.quizOptionBorder.withValues(alpha: 0.3);
        textColor = theme.colorScheme.onSurface.withValues(alpha: 0.5);
      }
    } else {
      if (isSelected) {
        backgroundColor = AppColors.quizOptionSelected;
        borderColor = AppColors.primary;
        textColor = AppColors.primary;
      } else {
        backgroundColor = AppColors.quizOption;
        borderColor = Colors.transparent;
        textColor = theme.colorScheme.onSurface;
      }
    }

    Widget content = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: borderColor,
              width: isSelected || showResult ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              // Label circle
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected || (showResult && isCorrect)
                      ? (isCorrect
                          ? AppColors.quizCorrect
                          : isIncorrect
                              ? AppColors.quizIncorrect
                              : AppColors.primary)
                      : theme.colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected || (showResult && isCorrect)
                        ? Colors.transparent
                        : AppColors.quizOptionBorder.withValues(alpha: 0.5),
                  ),
                ),
                child: Center(
                  child: showResult && (isCorrect || isIncorrect)
                      ? Icon(
                          isCorrect ? Icons.check : Icons.close,
                          size: 18,
                          color: Colors.white,
                        )
                      : Text(
                          label,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Colors.white
                                : theme.colorScheme.onSurface,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 16),
              // Option text
              Expanded(
                child: Text(
                  text,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: textColor,
                    fontWeight: isSelected || (showResult && isCorrect)
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Shake animation for incorrect answer
    if (isIncorrect && showResult) {
      content = TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 300),
        builder: (context, value, child) {
          final shake = (value < 0.5 ? value * 2 : (1 - value) * 2) * 8;
          final dir = (value * 4).floor().isEven ? 1 : -1;
          return Transform.translate(
            offset: Offset(shake * dir, 0),
            child: child,
          );
        },
        child: content,
      );
    }

    return content;
  }
}
