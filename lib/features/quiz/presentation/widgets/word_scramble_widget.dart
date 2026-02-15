import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/quiz_question.dart';

/// Widget for word scramble quiz type
/// Single-word answers: scramble letters
/// Multi-word answers: scramble words
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
  late List<String> _scrambledPieces;
  late List<bool> _usedIndices;
  final List<_PlacedPiece> _placedPieces = [];
  bool _hasSubmitted = false;
  late bool _isWordMode; // true = scramble words, false = scramble letters

  @override
  void initState() {
    super.initState();
    _initScramble();
  }

  @override
  void didUpdateWidget(WordScrambleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      _placedPieces.clear();
      _hasSubmitted = false;
      _initScramble();
    }
  }

  void _initScramble() {
    final answer = widget.question.correctAnswer.trim();
    final words = answer.split(RegExp(r'\s+'));
    _isWordMode = words.length > 1;

    if (_isWordMode) {
      // Multi-word: scramble word order
      _scrambledPieces = List.from(words);
      final rng = Random();
      do {
        _scrambledPieces.shuffle(rng);
      } while (_scrambledPieces.join(' ') == answer && words.length > 1);
    } else {
      // Single-word: scramble letters
      final word = answer.toUpperCase();
      _scrambledPieces = word.split('');
      final rng = Random();
      do {
        _scrambledPieces.shuffle(rng);
      } while (_scrambledPieces.join() == word && word.length > 1);
    }
    _usedIndices = List.filled(_scrambledPieces.length, false);
  }

  void _addPiece(int index) {
    if (_usedIndices[index] || widget.showResult) return;
    setState(() {
      _usedIndices[index] = true;
      _placedPieces.add(_PlacedPiece(
        piece: _scrambledPieces[index],
        sourceIndex: index,
      ));
    });
  }

  void _removePiece(int placedIndex) {
    if (widget.showResult) return;
    setState(() {
      final removed = _placedPieces.removeAt(placedIndex);
      _usedIndices[removed.sourceIndex] = false;
    });
  }

  void _submit() {
    if (_hasSubmitted) return;
    final answer = _isWordMode
        ? _placedPieces.map((p) => p.piece).join(' ')
        : _placedPieces.map((p) => p.piece).join();
    if (answer.isEmpty) return;
    setState(() => _hasSubmitted = true);
    widget.onSubmit(answer);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final correctDisplay = _isWordMode
        ? widget.question.correctAnswer
        : widget.question.correctAnswer.toUpperCase();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Answer area - placed pieces
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
            spacing: _isWordMode ? 8 : 4,
            runSpacing: 4,
            children: [
              ..._placedPieces.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _removePiece(entry.key),
                  child: _PieceTile(
                    text: entry.value.piece,
                    isWordMode: _isWordMode,
                    isPlaced: true,
                    isCorrect: widget.showResult && widget.isCorrect,
                    isIncorrect: widget.showResult && !widget.isCorrect,
                  ),
                );
              }),
              if (_placedPieces.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    _isWordMode ? '아래 단어를 탭하여 문장을 완성하세요' : '아래 글자를 탭하여 단어를 만드세요',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant
                          .withValues(alpha: 0.5),
                    ),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Scrambled pieces
        if (!widget.showResult)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: _scrambledPieces.asMap().entries.map((entry) {
              final isUsed = _usedIndices[entry.key];
              return GestureDetector(
                onTap: isUsed ? null : () => _addPiece(entry.key),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: isUsed ? 0.3 : 1.0,
                  child: _PieceTile(
                    text: entry.value,
                    isWordMode: _isWordMode,
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
                const Icon(Icons.check_circle_outline,
                    color: AppColors.quizCorrect, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: theme.textTheme.bodyMedium,
                      children: [
                        const TextSpan(text: '정답: '),
                        TextSpan(
                          text: correctDisplay,
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
            _placedPieces.length == _scrambledPieces.length) ...[
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

class _PlacedPiece {
  final String piece;
  final int sourceIndex;

  const _PlacedPiece({required this.piece, required this.sourceIndex});
}

class _PieceTile extends StatelessWidget {
  final String text;
  final bool isWordMode;
  final bool isPlaced;
  final bool isCorrect;
  final bool isIncorrect;
  final bool isDisabled;

  const _PieceTile({
    required this.text,
    required this.isWordMode,
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

    if (isWordMode) {
      // Word tiles: variable width
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isPlaced
                ? AppColors.primary.withValues(alpha: 0.3)
                : Colors.transparent,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      );
    } else {
      // Letter tiles: fixed width
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isPlaced
                ? AppColors.primary.withValues(alpha: 0.3)
                : Colors.transparent,
          ),
        ),
        child: Center(
          child: Text(
            text,
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
}
