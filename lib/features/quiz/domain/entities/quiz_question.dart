/// Type of quiz question
enum QuizType {
  multipleChoice,
  fillInTheBlank,
  translation,
  listening;

  String get displayName {
    switch (this) {
      case QuizType.multipleChoice:
        return 'Multiple Choice';
      case QuizType.fillInTheBlank:
        return 'Fill in the Blank';
      case QuizType.translation:
        return 'Translation';
      case QuizType.listening:
        return 'Listening';
    }
  }

  static QuizType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'multiple_choice':
      case 'multiplechoice':
        return QuizType.multipleChoice;
      case 'fill_in_the_blank':
      case 'fillintheblank':
        return QuizType.fillInTheBlank;
      case 'translation':
        return QuizType.translation;
      case 'listening':
        return QuizType.listening;
      default:
        return QuizType.multipleChoice;
    }
  }
}

/// Category of quiz question
enum QuizCategory {
  vocabulary,
  grammar,
  idioms,
  phrases,
  pronunciation;

  String get displayName {
    switch (this) {
      case QuizCategory.vocabulary:
        return 'Vocabulary';
      case QuizCategory.grammar:
        return 'Grammar';
      case QuizCategory.idioms:
        return 'Idioms';
      case QuizCategory.phrases:
        return 'Phrases';
      case QuizCategory.pronunciation:
        return 'Pronunciation';
    }
  }

  static QuizCategory fromString(String value) {
    switch (value.toLowerCase()) {
      case 'vocabulary':
        return QuizCategory.vocabulary;
      case 'grammar':
        return QuizCategory.grammar;
      case 'idioms':
        return QuizCategory.idioms;
      case 'phrases':
        return QuizCategory.phrases;
      case 'pronunciation':
        return QuizCategory.pronunciation;
      default:
        return QuizCategory.vocabulary;
    }
  }
}

/// Domain entity representing a quiz question
class QuizQuestion {
  final String id;
  final QuizType type;
  final QuizCategory category;
  final String difficulty; // 'easy', 'medium', 'hard'
  final String question;
  final String questionKo; // Korean translation of question
  final List<String> options; // For multiple choice
  final String correctAnswer;
  final String? hint;
  final String? explanation;
  final String? explanationKo;

  const QuizQuestion({
    required this.id,
    required this.type,
    required this.category,
    required this.difficulty,
    required this.question,
    this.questionKo = '',
    this.options = const [],
    required this.correctAnswer,
    this.hint,
    this.explanation,
    this.explanationKo,
  });

  /// Check if the given answer is correct
  bool checkAnswer(String answer) {
    // Normalize both strings for comparison
    final normalizedAnswer = answer.trim().toLowerCase();
    final normalizedCorrect = correctAnswer.trim().toLowerCase();

    return normalizedAnswer == normalizedCorrect;
  }

  /// Check if the answer is close (for typo tolerance)
  bool isCloseAnswer(String answer) {
    final normalizedAnswer = answer.trim().toLowerCase();
    final normalizedCorrect = correctAnswer.trim().toLowerCase();

    // Allow small typos using Levenshtein distance
    final distance = _levenshteinDistance(normalizedAnswer, normalizedCorrect);
    final maxAllowed = (normalizedCorrect.length * 0.2).ceil();

    return distance <= maxAllowed && distance > 0;
  }

  /// Calculate Levenshtein distance between two strings
  static int _levenshteinDistance(String s1, String s2) {
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;

    List<List<int>> dp = List.generate(
      s1.length + 1,
      (_) => List.generate(s2.length + 1, (_) => 0),
    );

    for (int i = 0; i <= s1.length; i++) dp[i][0] = i;
    for (int j = 0; j <= s2.length; j++) dp[0][j] = j;

    for (int i = 1; i <= s1.length; i++) {
      for (int j = 1; j <= s2.length; j++) {
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

  QuizQuestion copyWith({
    String? id,
    QuizType? type,
    QuizCategory? category,
    String? difficulty,
    String? question,
    String? questionKo,
    List<String>? options,
    String? correctAnswer,
    String? hint,
    String? explanation,
    String? explanationKo,
  }) {
    return QuizQuestion(
      id: id ?? this.id,
      type: type ?? this.type,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      question: question ?? this.question,
      questionKo: questionKo ?? this.questionKo,
      options: options ?? this.options,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      hint: hint ?? this.hint,
      explanation: explanation ?? this.explanation,
      explanationKo: explanationKo ?? this.explanationKo,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizQuestion &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
