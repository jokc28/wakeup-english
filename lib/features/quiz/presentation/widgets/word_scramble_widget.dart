import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/quiz_question.dart';

/// Widget for word scramble quiz type
/// Shows Korean definition, scrambled letter tiles, user forms correct English word
class WordScrambleWidget extends StatefulWidget {
  final QuizQuestion question;
  final bool showResult;
  final bool isCorrect;
  final ValueChanged<String> onSubmit;

  const WordScrambleWidget({
    super.key,
    required this.question,
    this.showResult = false,
    this.isCorrect = false,
    required this.onSubmit,
  });

  @override
  State<WordScrambleWidget> createState() => _WordScrambleWidgetState();
}

class _WordScrambleWidgetState extends State<WordScrambleWidget> {
  late List<String> _scrambledLetters;
  late List<bool> _usedIndices;
  final List<_PlacedLetter> _placedLetters = [];
  bool _hasSubmitted = false;

  @override
  void initState() {
    super.initState();
    _initScramble();
  }

  @override
  void didUpdateWidget(WordScrambleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      _placedLetters.clear();
      _hasSubmitted = false;
      _initScramble();
    }
  }

  void _initScramble() {
    final word = widget.question.correctAnswer.toUpperCase();
    _scrambledLetters = word.split('');
    final rng = Random();
    // Shuffle until different from original (for words > 1 char)
    do {
      _scrambledLetters.shuffle(rng);
    } while (_scrambledLetters.join() == word && word.length > 1);
    _usedIndices = List.filled(_scrambledLetters.length, false);
  }

  void _addLetter(int index) {
    if (_usedIndices[index] || widget.showResult) return;
    setState(() {
      _usedIndices[index] = true;
      _placedLetters.add(_PlacedLetter(
        letter: _scrambledLetters[index],
        sourceIndex: index,
      ));
    });
  }

  void _removeLetter(int placedIndex) {
    if (widget.showResult) return;
    setState(() {
      final removed = _placedLetters.removeAt(placedIndex);
      _usedIndices[removed.sourceIndex] = false;
    });
  }

  void _submit() {
    if (_hasSubmitted) return;
    final answer = _placedLetters.map((p) => p.letter).join();
    if (answer.isEmpty) return;
    setState(() => _hasSubmitted = true);
    widget.onSubmit(answer);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final correctWord = widget.question.correctAnswer.toUpperCase();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Korean definition hint
        if (widget.question.questionKo.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.translate, color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.question.questionKo,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],

        // Answer area - placed letters
        Container(
          constraints: const BoxConstraints(minHeight: 56),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.showResult
                  ? (widget.isCorrect
                      ? AppColors.quizCorrect
                      : AppColors.quizIncorrect)
                  : theme.colorScheme.outline.withValues(alpha: 0.3),
              width: widget.showResult ? 2 : 1,
            ),
            color: widget.showResult
                ? (widget.isCorrect
                        ? AppColors.quizCorrect
                        : AppColors.quizIncorrect)
                    .withValues(alpha: 0.08)
                : null,
          ),
          child: Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              ..._placedLetters.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _removeLetter(entry.key),
                  child: _LetterTile(
                    letter: entry.value.letter,
                    isPlaced: true,
                    isCorrect: widget.showResult && widget.isCorrect,
                    isIncorrect: widget.showResult && !widget.isCorrect,
                  ),
                );
              }),
              if (_placedLetters.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    '아래 글자를 탭하여 단어를 만드세요',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                    ),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Scrambled letter tiles
        if (!widget.showResult)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: _scrambledLetters.asMap().entries.map((entry) {
              final isUsed = _usedIndices[entry.key];
              return GestureDetector(
                onTap: isUsed ? null : () => _addLetter(entry.key),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: isUsed ? 0.3 : 1.0,
                  child: _LetterTile(
                    letter: entry.value,
                    isPlaced: false,
                    isDisabled: isUsed,
                  ),
                ),
              );
            }).toList(),
          ),

        // Show correct answer if wrong
        if (widget.showResult && !widget.isCorrect) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.quizCorrect.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle_outline, color: AppColors.quizCorrect, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: theme.textTheme.bodyMedium,
                      children: [
                        const TextSpan(text: '정답: '),
                        TextSpan(
                          text: correctWord,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.quizCorrect,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

        // Submit button
        if (!widget.showResult &&
            _placedLetters.length == _scrambledLetters.length) ...[
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _submit,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              '제출',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ],
    );
  }
}

class _PlacedLetter {
  final String letter;
  final int sourceIndex;

  const _PlacedLetter({required this.letter, required this.sourceIndex});
}

class _LetterTile extends StatelessWidget {
  final String letter;
  final bool isPlaced;
  final bool isCorrect;
  final bool isIncorrect;
  final bool isDisabled;

  const _LetterTile({
    required this.letter,
    this.isPlaced = false,
    this.isCorrect = false,
    this.isIncorrect = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color bgColor;
    Color textColor;

    if (isCorrect) {
      bgColor = AppColors.quizCorrect.withValues(alpha: 0.15);
      textColor = AppColors.quizCorrect;
    } else if (isIncorrect) {
      bgColor = AppColors.quizIncorrect.withValues(alpha: 0.15);
      textColor = AppColors.quizIncorrect;
    } else if (isPlaced) {
      bgColor = AppColors.primary.withValues(alpha: 0.12);
      textColor = AppColors.primary;
    } else {
      bgColor = theme.colorScheme.surfaceContainerHighest;
      textColor = theme.colorScheme.onSurface;
    }

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isPlaced ? AppColors.primary.withValues(alpha: 0.3) : Colors.transparent,
        ),
      ),
      child: Center(
        child: Text(
          letter,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
