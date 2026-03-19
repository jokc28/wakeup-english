import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../app_database.dart';

/// Standalone utility for seeding the VocabularyItems table.
class DbSeeder {
  /// Seed from the bundled level_vocabulary.json asset.
  /// Returns number of items inserted.
  static Future<int> seedFromAsset(AppDatabase db) async {
    final jsonString = await rootBundle.loadString(
      'assets/data/level_vocabulary.json',
    );
    return seedFromJsonString(db, jsonString);
  }

  /// Seed from an external JSON string.
  ///
  /// Expected format: JSON array of objects with keys:
  ///   `word` (String), `hint` (String), `type` (String), `difficulty_level` (int)
  ///
  /// Returns number of items inserted (duplicates are silently ignored).
  static Future<int> seedFromJsonString(
    AppDatabase db,
    String jsonString,
  ) async {
    final jsonList = jsonDecode(jsonString) as List<dynamic>;
    var insertedCount = 0;

    await db.batch((batch) {
      for (var i = 0; i < jsonList.length; i++) {
        final json = jsonList[i] as Map<String, dynamic>;
        final word = json['word'] as String;
        final hint = json['hint'] as String;
        final type = json['type'] as String? ?? 'definition';
        final difficultyLevel = json['difficulty_level'] as int? ?? 1;

        // Map difficulty_level ranges to difficulty labels
        final difficulty = _difficultyFromLevel(difficultyLevel);

        // Build the question text from type
        final question = type == 'sentence' ? hint : word;

        // Generate a stable questionId from the word + level
        final questionId = 'lv${difficultyLevel}_${word.toLowerCase()}';

        batch.insert(
          db.vocabularyItems,
          VocabularyItemsCompanion.insert(
            questionId: questionId,
            type: 'word_scramble',
            category: type == 'sentence' ? 'cloze' : 'vocabulary',
            difficulty: difficulty,
            question: question,
            questionKo: hint,
            options: '[]',
            correctAnswer: word,
            hint: Value(hint),
            explanation: const Value(null),
            explanationKo: const Value(null),
            isFree: Value(difficultyLevel <= 5),
            unlockLevel: Value(difficultyLevel),
          ),
          mode: InsertMode.insertOrIgnore,
        );
        insertedCount++;
      }
    });

    return insertedCount;
  }

  /// Map a difficulty_level (1-50) to a difficulty label.
  static String _difficultyFromLevel(int level) {
    if (level <= 15) return 'easy';
    if (level <= 35) return 'medium';
    return 'hard';
  }
}
