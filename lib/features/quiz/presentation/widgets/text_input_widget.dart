import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/quiz_question.dart';

/// Widget for text input quiz answers (fill in the blank, translation)
class TextInputWidget extends StatefulWidget {
  final QuizQuestion question;
  final bool showResult;
  final bool isCorrect;
  final ValueChanged<String> onSubmit;

  const TextInputWidget({
    super.key,
    required this.question,
    this.showResult = false,
    this.isCorrect = false,
    required this.onSubmit,
  });

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _hasSubmitted = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    // Auto-focus the input
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TextInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      _controller.clear();
      _hasSubmitted = false;
      _focusNode.requestFocus();
    }
  }

  void _submit() {
    if (_controller.text.trim().isEmpty || _hasSubmitted) return;

    setState(() => _hasSubmitted = true);
    widget.onSubmit(_controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Hint if available
        if (widget.question.hint != null && !widget.showResult) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.warning.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: AppColors.warning,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Hint: ${widget.question.hint}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Input field
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.showResult
                  ? (widget.isCorrect
                      ? AppColors.quizCorrect
                      : AppColors.quizIncorrect)
                  : theme.colorScheme.outline.withOpacity(0.3),
              width: widget.showResult ? 2 : 1,
            ),
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            enabled: !widget.showResult,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            style: theme.textTheme.titleMedium?.copyWith(
              color: widget.showResult
                  ? (widget.isCorrect
                      ? AppColors.quizCorrect
                      : AppColors.quizIncorrect)
                  : null,
            ),
            decoration: InputDecoration(
              hintText: 'Type your answer...',
              filled: true,
              fillColor: widget.showResult
                  ? (widget.isCorrect
                          ? AppColors.quizCorrect
                          : AppColors.quizIncorrect)
                      .withOpacity(0.1)
                  : theme.colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(20),
              suffixIcon: widget.showResult
                  ? Icon(
                      widget.isCorrect ? Icons.check_circle : Icons.cancel,
                      color: widget.isCorrect
                          ? AppColors.quizCorrect
                          : AppColors.quizIncorrect,
                    )
                  : null,
            ),
          ),
        ),

        // Show correct answer if wrong
        if (widget.showResult && !widget.isCorrect) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.quizCorrect.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: AppColors.quizCorrect,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: theme.textTheme.bodyMedium,
                      children: [
                        const TextSpan(text: 'Correct answer: '),
                        TextSpan(
                          text: widget.question.correctAnswer,
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

        // Submit button (only when not showing result)
        if (!widget.showResult) ...[
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
              'Submit',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ],
    );
  }
}
