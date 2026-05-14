import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../app_database.dart';

/// Standalone utility for seeding the VocabularyItems table.
class DbSeeder {
  static final _trustedReelUrl = RegExp(
    r'^https:\/\/www\.instagram\.com\/reel\/[A-Za-z0-9_-]+\/?$',
  );

  /// Seed from the bundled Reel expression asset.
  /// Returns number of items inserted.
  static Future<int> seedFromAsset(AppDatabase db) async {
    final jsonString = await rootBundle.loadString(
      'assets/data/reel_expressions.json',
    );
    return seedFromJsonString(db, jsonString);
  }

  /// Seed from an external JSON string.
  ///
  /// Expected format: JSON array of verified Instagram Reel expression objects.
  /// Entries without a Reel URL, expression, Korean meaning, or Korean situation
  /// are rejected so generated vocabulary cannot enter the quiz pool.
  ///
  /// Returns number of items inserted (duplicates are silently ignored).
  static Future<int> seedFromJsonString(
    AppDatabase db,
    String jsonString,
  ) async {
    final jsonList = jsonDecode(jsonString) as List<dynamic>;
    final entries = jsonList
        .whereType<Map<String, dynamic>>()
        .where(_isTrustedReelEntry)
        .toList();
    var insertedCount = 0;

    await db.transaction(() async {
      for (var i = 0; i < entries.length; i++) {
        final entry = entries[i];
        final expression = (entry['expression_en'] as String).trim();
        final meaning = (entry['expression_meaning_kr'] as String).trim();
        final situation = (entry['situation_kr'] as String).trim();
        final description = (entry['description_kr'] as String? ?? '').trim();
        final category = (entry['category'] as String? ?? '일상대화').trim();
        final difficulty = _normalizeDifficulty(entry['difficulty'] as String?);
        final unlockLevel = _unlockLevelForIndex(i, entries.length);
        final questionId = 'reel_${entry['id']}_${_slug(expression)}';
        final options = _buildOptions(entry, entries);

        final rowId = await db.into(db.vocabularyItems).insert(
              VocabularyItemsCompanion.insert(
                questionId: questionId,
                type: 'multiple_choice',
                category: _normalizeCategory(category),
                difficulty: difficulty,
                question: '다음 상황에서 가장 자연스러운 영어 표현은?',
                questionKo: '$meaning · $situation',
                options: jsonEncode(options),
                correctAnswer: expression,
                hint: Value(situation),
                explanation: Value(description.isEmpty ? null : description),
                explanationKo: Value(
                  '출처: @ok.english.kr Instagram Reel ${entry['reel_url']}',
                ),
                isFree: Value(unlockLevel <= 5),
                unlockLevel: Value(unlockLevel),
              ),
              mode: InsertMode.insertOrIgnore,
            );
        if (rowId > 0) insertedCount++;
      }
    });

    return insertedCount;
  }

  static bool _isTrustedReelEntry(Map<String, dynamic> entry) {
    return (entry['source'] == 'instagram_reel') &&
        (entry['expression_en'] as String? ?? '').trim().isNotEmpty &&
        (entry['expression_meaning_kr'] as String? ?? '').trim().isNotEmpty &&
        (entry['situation_kr'] as String? ?? '').trim().isNotEmpty &&
        _trustedReelUrl.hasMatch(
          (entry['reel_url'] as String? ?? '').trim(),
        );
  }

  static List<String> _buildOptions(
    Map<String, dynamic> entry,
    List<Map<String, dynamic>> entries,
  ) {
    final expression = (entry['expression_en'] as String).trim();
    final seen = {expression.toLowerCase()};
    final tiers = [
      entries.where((candidate) =>
          candidate['id'] != entry['id'] &&
          candidate['category'] == entry['category'] &&
          candidate['difficulty'] == entry['difficulty']),
      entries.where((candidate) =>
          candidate['id'] != entry['id'] &&
          candidate['category'] == entry['category']),
      entries.where((candidate) =>
          candidate['id'] != entry['id'] &&
          candidate['difficulty'] == entry['difficulty']),
      entries.where((candidate) => candidate['id'] != entry['id']),
    ];
    final distractors = <String>[];

    for (final tier in tiers) {
      for (final candidate in tier) {
        final candidateExpression =
            (candidate['expression_en'] as String? ?? '').trim();
        final key = candidateExpression.toLowerCase();
        if (candidateExpression.isEmpty || seen.contains(key)) continue;
        seen.add(key);
        distractors.add(candidateExpression);
        if (distractors.length >= 3) break;
      }
      if (distractors.length >= 3) break;
    }

    return _stableShuffle(
      [expression, ...distractors],
      '${entry['id']}:$expression',
    );
  }

  static List<String> _stableShuffle(List<String> values, String seedText) {
    final result = [...values];
    var seed = seedText.codeUnits.fold<int>(
      2166136261,
      (acc, codeUnit) => (acc * 31 + codeUnit) & 0x7fffffff,
    );

    for (var i = result.length - 1; i > 0; i--) {
      seed = (seed * 1103515245 + 12345) & 0x7fffffff;
      final j = seed % (i + 1);
      final tmp = result[i];
      result[i] = result[j];
      result[j] = tmp;
    }

    return result;
  }

  static String _normalizeDifficulty(String? difficulty) {
    switch ((difficulty ?? '').toLowerCase()) {
      case 'advanced':
        return 'hard';
      case 'intermediate':
        return 'medium';
      case 'beginner':
      default:
        return 'easy';
    }
  }

  static int _unlockLevelForIndex(int index, int totalCount) {
    if (totalCount <= 1) return 1;
    final level = ((index * 50) ~/ totalCount) + 1;
    return level.clamp(1, 50);
  }

  static String _normalizeCategory(String category) {
    if (category.contains('비즈니스')) return 'phrases';
    if (category.contains('발음')) return 'pronunciation';
    if (category.contains('관용')) return 'idioms';
    return 'phrases';
  }

  static String _slug(String expression) {
    final slug = expression
        .toLowerCase()
        .replaceAll(RegExp('[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');
    return slug.isEmpty ? 'expression' : slug;
  }
}
