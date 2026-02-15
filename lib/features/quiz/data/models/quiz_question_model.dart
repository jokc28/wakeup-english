import '../../domain/entities/quiz_question.dart';

/// Model for parsing quiz questions from JSON
class QuizQuestionModel {
  final String id;
  final String type;
  final String category;
  final String difficulty;
  final String question;
  final String questionKo;
  final List<String> options;
  final String correctAnswer;
  final String? hint;
  final String? explanation;
  final String? explanationKo;

  QuizQuestionModel({
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

  /// Create model from JSON
  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      id: json['id'] as String,
      type: json['type'] as String? ?? 'multiple_choice',
      category: json['category'] as String? ?? 'vocabulary',
      difficulty: json['difficulty'] as String? ?? 'medium',
      question: json['question'] as String,
      questionKo: json['question_ko'] as String? ?? '',
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      correctAnswer: json['correct_answer'] as String,
      hint: json['hint'] as String?,
      explanation: json['explanation'] as String?,
      explanationKo: json['explanation_ko'] as String?,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'category': category,
      'difficulty': difficulty,
      'question': question,
      'question_ko': questionKo,
      'options': options,
      'correct_answer': correctAnswer,
      'hint': hint,
      'explanation': explanation,
      'explanation_ko': explanationKo,
    };
  }

  /// Convert to domain entity
  QuizQuestion toEntity() {
    return QuizQuestion(
      id: id,
      type: QuizType.fromString(type),
      category: QuizCategory.fromString(category),
      difficulty: difficulty,
      question: question,
      questionKo: questionKo,
      options: options,
      correctAnswer: correctAnswer,
      hint: hint,
      explanation: explanation,
      explanationKo: explanationKo,
    );
  }
}

/// Extension to convert domain entity to model
extension QuizQuestionEntityMapper on QuizQuestion {
  QuizQuestionModel toModel() {
    return QuizQuestionModel(
      id: id,
      type: type.name,
      category: category.name,
      difficulty: difficulty,
      question: question,
      questionKo: questionKo,
      options: options,
      correctAnswer: correctAnswer,
      hint: hint,
      explanation: explanation,
      explanationKo: explanationKo,
    );
  }
}
