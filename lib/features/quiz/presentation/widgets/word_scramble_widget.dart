import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../domain/entities/quiz_question.dart';

/// Widget for word scramble quiz type
/// Single-word answers: scramble letters
/// Multi-word answers: scramble words
/// Chunky 3D Duolingo-style tiles with animated transitions
class WordScrambleWidget extends StatefulWidget {
  final QuizQuestion question;
  final bool showResult;
  final bool isCorrect;
  final ValueChanged<String> onSubmit;

  const WordScrambleWidget({
    required this.question,
    required this.onSubmit,
    super.key,
    this.showResult = false,
    this.isCorrect = false,
  });

  @override
  State<WordScrambleWidget> createState() => _WordScrambleWidgetState();
}

class _WordScrambleWidgetState extends State<WordScrambleWidget> {
  late List<String> _scrambledPieces;
  late List<bool> _usedIndices;
  final List<_PlacedPiece> _placedPieces = [];
  bool _hasSubmitted = false;
  late bool _isWordMode;
  int _placedAnimKey = 0; // increments to trigger pop-in on new tiles

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
      _placedAnimKey = 0;
      _initScramble();
    }
  }

  void _initScramble() {
    final answer = widget.question.correctAnswer.trim();
    final words = answer.split(RegExp(r'\s+'));
    _isWordMode = words.length > 1;

    if (_isWordMode) {
      _scrambledPieces = List.from(words);
      _shuffleUntilDifferent(_scrambledPieces, answer, true);
    } else {
      final word = answer.toUpperCase();
      _scrambledPieces = word.split('');
      _shuffleUntilDifferent(_scrambledPieces, word, false);
    }
    _usedIndices = List.filled(_scrambledPieces.length, false);
  }

  /// Shuffle list until the joined result differs from the original.
  /// Tries up to 20 times, then forces a swap as a fallback.
  void _shuffleUntilDifferent(
      List<String> pieces, String original, bool useSpaces) {
    if (pieces.length <= 1) return;
    final rng = Random();
    final joiner = useSpaces ? ' ' : '';
    var attempts = 0;
    do {
      pieces.shuffle(rng);
      attempts++;
    } while (pieces.join(joiner) == original && attempts < 20);

    // Fallback: if still identical after 20 attempts (e.g. "aaa"), force swap
    if (pieces.join(joiner) == original && pieces.length >= 2) {
      final tmp = pieces[0];
      pieces[0] = pieces[pieces.length - 1];
      pieces[pieces.length - 1] = tmp;
    }
  }

  void _addPiece(int index) {
    if (_usedIndices[index] || widget.showResult) return;
    HapticFeedback.lightImpact();
    setState(() {
      _usedIndices[index] = true;
      _placedAnimKey++;
      _placedPieces.add(_PlacedPiece(
        piece: _scrambledPieces[index],
        sourceIndex: index,
        animKey: _placedAnimKey,
      ));
    });
  }

  void _removePiece(int placedIndex) {
    if (widget.showResult) return;
    HapticFeedback.lightImpact();
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
    HapticFeedback.mediumImpact();
    setState(() => _hasSubmitted = true);
    widget.onSubmit(answer);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final correctDisplay = _isWordMode
        ? widget.question.correctAnswer
        : widget.question.correctAnswer.toUpperCase();
    final totalSlots = _scrambledPieces.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Answer area — placed pieces + empty slots
        Container(
          constraints: const BoxConstraints(minHeight: 64),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: widget.showResult
                  ? (widget.isCorrect
                      ? AppColors.quizCorrect
                      : AppColors.quizIncorrect)
                  : AppColors.quizOptionBorder,
              width: widget.showResult ? 2.5 : 1.5,
            ),
            color: widget.showResult
                ? (widget.isCorrect
                        ? AppColors.quizCorrect
                        : AppColors.quizIncorrect)
                    .withValues(alpha: 0.08)
                : AppColors.quizOption.withValues(alpha: 0.5),
          ),
          child: Wrap(
            spacing: _isWordMode ? 8 : 6,
            runSpacing: 6,
            children: List.generate(totalSlots, (i) {
              if (i < _placedPieces.length) {
                // Filled slot — placed tile with pop-in animation
                final placed = _placedPieces[i];
                return GestureDetector(
                  onTap: () => _removePiece(i),
                  child: _ChunkyTile(
                    key: ValueKey('placed_${placed.animKey}'),
                    text: placed.piece,
                    isWordMode: _isWordMode,
                    isPlaced: true,
                    isCorrect: widget.showResult && widget.isCorrect,
                    isIncorrect: widget.showResult && !widget.isCorrect,
                  )
                      .animate()
                      .scale(
                        begin: Offset.zero,
                        end: const Offset(1, 1),
                        duration: 200.ms,
                        curve: Curves.easeOutBack,
                      )
                      .fadeIn(duration: 150.ms),
                );
              } else {
                // Empty slot placeholder
                return _EmptySlot(isWordMode: _isWordMode);
              }
            }),
          ),
        ),

        const SizedBox(height: 20),

        // Scrambled pieces pool with staggered bounce-in
        if (!widget.showResult)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: _scrambledPieces.asMap().entries.map((entry) {
              final isUsed = _usedIndices[entry.key];
              return GestureDetector(
                onTap: isUsed ? null : () => _addPiece(entry.key),
                child: AnimatedScale(
                  scale: isUsed ? 0.85 : 1.0,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeInOut,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 150),
                    opacity: isUsed ? 0.25 : 1.0,
                    child: _ChunkyTile(
                      text: entry.value,
                      isWordMode: _isWordMode,
                      isPlaced: false,
                      isDisabled: isUsed,
                    )
                        .animate()
                        .scale(
                          begin: const Offset(0.7, 0.7),
                          end: const Offset(1, 1),
                          delay: (50 * entry.key).ms,
                          duration: 300.ms,
                          curve: Curves.easeOutBack,
                        )
                        .fadeIn(delay: (50 * entry.key).ms, duration: 200.ms),
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
                        TextSpan(text: l10n.correctAnswerLabel),
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
              backgroundColor: AppColors.action,
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              l10n.submit,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
  final int animKey;

  const _PlacedPiece({
    required this.piece,
    required this.sourceIndex,
    required this.animKey,
  });
}

/// Empty placeholder slot shown in the answer area
class _EmptySlot extends StatelessWidget {
  final bool isWordMode;

  const _EmptySlot({required this.isWordMode});

  @override
  Widget build(BuildContext context) {
    if (isWordMode) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.quizOptionBorder.withValues(alpha: 0.4),
            width: 1.5,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          color: AppColors.quizOption.withValues(alpha: 0.15),
        ),
        child: Text(
          '___',
          style: GoogleFonts.jua(
            fontSize: 18,
            color: AppColors.textSecondaryLight.withValues(alpha: 0.3),
          ),
        ),
      );
    } else {
      return Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.quizOptionBorder.withValues(alpha: 0.4),
            width: 1.5,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          color: AppColors.quizOption.withValues(alpha: 0.15),
        ),
      );
    }
  }
}

/// Chunky 3D tile (Duolingo-style) with bottom border for depth
class _ChunkyTile extends StatelessWidget {
  final String text;
  final bool isWordMode;
  final bool isPlaced;
  final bool isCorrect;
  final bool isIncorrect;
  final bool isDisabled;

  const _ChunkyTile({
    required this.text,
    required this.isWordMode,
    super.key,
    this.isPlaced = false,
    this.isCorrect = false,
    this.isIncorrect = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Color borderBottomColor;

    if (isCorrect) {
      bgColor = AppColors.quizCorrectBg;
      textColor = AppColors.actionDark;
      borderBottomColor = AppColors.quizCorrect;
    } else if (isIncorrect) {
      bgColor = AppColors.quizIncorrectBg;
      textColor = AppColors.quizIncorrect;
      borderBottomColor = AppColors.quizIncorrect;
    } else if (isPlaced) {
      bgColor = AppColors.primarySurface;
      textColor = AppColors.primaryDark;
      borderBottomColor = AppColors.primary.withValues(alpha: 0.4);
    } else {
      bgColor = AppColors.quizOption;
      textColor = AppColors.textPrimaryLight;
      borderBottomColor = AppColors.quizOptionBorder;
    }

    if (isWordMode) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: borderBottomColor.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            // 3D chunky depth effect (bottom edge)
            BoxShadow(
              color: borderBottomColor.withValues(alpha: 0.6),
              offset: const Offset(0, 3),
              blurRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: GoogleFonts.jua(
            fontSize: 18,
            color: textColor,
          ),
        ),
      );
    } else {
      return Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: borderBottomColor.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            // 3D chunky depth effect (bottom edge)
            BoxShadow(
              color: borderBottomColor.withValues(alpha: 0.6),
              offset: const Offset(0, 3),
              blurRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.jua(
              fontSize: 22,
              color: textColor,
            ),
          ),
        ),
      );
    }
  }
}
