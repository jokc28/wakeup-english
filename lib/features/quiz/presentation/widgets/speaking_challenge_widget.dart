import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/quiz_question.dart';

/// Widget for speaking challenge quiz type
/// Shows English sentence, user speaks it, 80% fuzzy match to pass
/// Falls back to typing if mic permission denied
class SpeakingChallengeWidget extends StatefulWidget {
  final QuizQuestion question;
  final bool showResult;
  final bool isCorrect;
  final ValueChanged<String> onSubmit;

  const SpeakingChallengeWidget({
    super.key,
    required this.question,
    this.showResult = false,
    this.isCorrect = false,
    required this.onSubmit,
  });

  @override
  State<SpeakingChallengeWidget> createState() =>
      _SpeakingChallengeWidgetState();
}

class _SpeakingChallengeWidgetState extends State<SpeakingChallengeWidget> {
  final SpeechToText _speech = SpeechToText();
  bool _speechAvailable = false;
  bool _isListening = false;
  String _recognizedText = '';
  bool _hasSubmitted = false;
  bool _showTypingFallback = false;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _initSpeech();
  }

  @override
  void dispose() {
    _textController.dispose();
    if (_isListening) {
      _speech.stop();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(SpeakingChallengeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      _recognizedText = '';
      _hasSubmitted = false;
      _showTypingFallback = false;
      _textController.clear();
    }
  }

  Future<void> _initSpeech() async {
    try {
      _speechAvailable = await _speech.initialize(
        onError: (error) {
          if (error.errorMsg == 'error_permission' ||
              error.errorMsg == 'error_no_match') {
            if (mounted) {
              setState(() {
                _isListening = false;
                if (error.errorMsg == 'error_permission') {
                  _showTypingFallback = true;
                }
              });
            }
          }
        },
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            if (mounted) {
              setState(() => _isListening = false);
            }
          }
        },
      );
    } catch (_) {
      _speechAvailable = false;
    }

    if (mounted && !_speechAvailable) {
      setState(() => _showTypingFallback = true);
    }
  }

  void _startListening() async {
    if (!_speechAvailable || widget.showResult || _hasSubmitted) return;

    setState(() {
      _isListening = true;
      _recognizedText = '';
    });

    await _speech.listen(
      onResult: _onSpeechResult,
      localeId: 'en_US',
      listenOptions: stt.SpeechListenOptions(
        listenMode: ListenMode.confirmation,
        cancelOnError: true,
      ),
    );
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() => _isListening = false);

    // Auto-submit if we have recognized text
    if (_recognizedText.isNotEmpty && !_hasSubmitted) {
      _submit(_recognizedText);
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _recognizedText = result.recognizedWords;
    });

    if (result.finalResult && _recognizedText.isNotEmpty && !_hasSubmitted) {
      _submit(_recognizedText);
    }
  }

  void _submit(String answer) {
    if (_hasSubmitted || answer.trim().isEmpty) return;
    setState(() => _hasSubmitted = true);
    widget.onSubmit(answer.trim());
  }

  /// Calculate similarity percentage between two strings
  double _calculateSimilarity(String a, String b) {
    final s1 = a.toLowerCase().trim();
    final s2 = b.toLowerCase().trim();
    if (s1 == s2) return 1;
    if (s1.isEmpty || s2.isEmpty) return 0;

    final distance = _levenshteinDistance(s1, s2);
    final maxLen = s1.length > s2.length ? s1.length : s2.length;
    return 1 - (distance / maxLen);
  }

  static int _levenshteinDistance(String s1, String s2) {
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;

    final dp = List.generate(
      s1.length + 1,
      (_) => List.generate(s2.length + 1, (_) => 0),
    );

    for (var i = 0; i <= s1.length; i++) {
      dp[i][0] = i;
    }
    for (var j = 0; j <= s2.length; j++) {
      dp[0][j] = j;
    }

    for (var i = 1; i <= s1.length; i++) {
      for (var j = 1; j <= s2.length; j++) {
        final cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
        dp[i][j] = [
          dp[i - 1][j] + 1,
          dp[i][j - 1] + 1,
          dp[i - 1][j - 1] + cost,
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    return dp[s1.length][s2.length];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Target sentence display
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            children: [
              const Icon(Icons.record_voice_over, color: AppColors.primary, size: 32),
              const SizedBox(height: 8),
              Text(
                '아래 문장을 영어로 말해 보세요',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.question.correctAnswer,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              if (widget.question.questionKo.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  widget.question.questionKo,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Recognized text display
        if (_recognizedText.isNotEmpty && !_showTypingFallback) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.showResult
                  ? (widget.isCorrect
                          ? AppColors.quizCorrect
                          : AppColors.quizIncorrect)
                      .withValues(alpha: 0.1)
                  : theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: widget.showResult
                  ? Border.all(
                      color: widget.isCorrect
                          ? AppColors.quizCorrect
                          : AppColors.quizIncorrect,
                      width: 2,
                    )
                  : null,
            ),
            child: Column(
              children: [
                Text(
                  '인식된 텍스트:',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _recognizedText,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: widget.showResult
                        ? (widget.isCorrect
                            ? AppColors.quizCorrect
                            : AppColors.quizIncorrect)
                        : null,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (widget.showResult) ...[
                  const SizedBox(height: 4),
                  Text(
                    '일치도: ${(_calculateSimilarity(_recognizedText, widget.question.correctAnswer) * 100).round()}%',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: widget.isCorrect
                          ? AppColors.quizCorrect
                          : AppColors.quizIncorrect,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Mic button or typing fallback
        if (!widget.showResult) ...[
          if (_showTypingFallback) ...[
            // Typing fallback
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '마이크를 사용할 수 없습니다. 답을 직접 입력해 주세요.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.warning,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _textController,
              enabled: !_hasSubmitted,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(_textController.text),
              decoration: InputDecoration(
                hintText: '영어로 입력하세요...',
                filled: true,
                fillColor: theme.colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(20),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _hasSubmitted
                  ? null
                  : () => _submit(_textController.text),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('제출', style: TextStyle(fontSize: 16)),
            ),
          ] else ...[
            // Mic button
            Center(
              child: GestureDetector(
                onTapDown: (_) => _startListening(),
                onTapUp: (_) => _stopListening(),
                onTapCancel: () => _stopListening(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: _isListening ? 100 : 80,
                  height: _isListening ? 100 : 80,
                  decoration: BoxDecoration(
                    color: _isListening
                        ? AppColors.secondary
                        : AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: _isListening
                        ? [
                            BoxShadow(
                              color: AppColors.secondary.withValues(alpha: 0.4),
                              blurRadius: 20,
                              spreadRadius: 4,
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    size: _isListening ? 48 : 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _isListening ? '듣고 있습니다...' : '길게 눌러 말하기',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: _isListening
                    ? AppColors.secondary
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: _isListening ? FontWeight.w600 : null,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Show typing fallback option
            TextButton(
              onPressed: () => setState(() => _showTypingFallback = true),
              child: Text(
                '직접 입력하기',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ],

        // Result feedback
        if (widget.showResult && !widget.isCorrect) ...[
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
      ],
    );
  }
}
