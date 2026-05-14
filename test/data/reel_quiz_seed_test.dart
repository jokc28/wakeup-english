import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wakeup_english/core/database/app_database.dart';
import 'package:wakeup_english/core/database/utils/db_seeder.dart';

void main() {
  test('seeds only trusted Instagram Reel expressions as non-leaking choices',
      () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    await db.delete(db.vocabularyItems).go();

    final inserted = await DbSeeder.seedFromJsonString(
      db,
      jsonEncode([
        {
          'id': 1,
          'expression_en': 'Put yourself out there',
          'expression_meaning_kr': '적극적으로 나서다',
          'situation_kr': '용기를 내서 사람 만날 때',
          'description_kr': '새로운 사람을 만날 때 쓰는 표현이에요.',
          'category': '일상대화',
          'difficulty': 'intermediate',
          'reel_url': 'https://www.instagram.com/reel/DX86xDZNS3X/',
          'source': 'instagram_reel',
        },
        {
          'id': 2,
          'expression_en': 'squeeze in',
          'expression_meaning_kr': '시간을 끼워 넣다',
          'situation_kr': '바쁜 와중에 시간을 낼 때',
          'description_kr': '일정이 꽉 찼을 때 쓰는 표현이에요.',
          'category': '일상대화',
          'difficulty': 'intermediate',
          'reel_url': 'https://www.instagram.com/reel/DX1t-1zR6Ik/',
          'source': 'instagram_reel',
        },
        {
          'id': 3,
          'expression_en': 'corny',
          'expression_meaning_kr': '뻔한',
          'situation_kr': '재미없는 상황을 표현할 때',
          'description_kr': '오글거릴 때 쓰는 표현이에요.',
          'category': '감정·리액션',
          'difficulty': 'beginner',
          'reel_url': 'https://www.instagram.com/reel/DV3lCaIAczg/',
          'source': 'instagram_reel',
        },
        {
          'id': 4,
          'expression_en': 'random generated word',
          'expression_meaning_kr': '가짜',
          'situation_kr': '가짜 상황',
          'reel_url': '',
          'source': 'ai_generated',
        },
      ]),
    );

    expect(inserted, 3);

    final questions = await db.getVocabularyItemsForQuiz(
      userLevel: 50,
      isFreeUser: false,
      limit: 10,
    );

    expect(questions, hasLength(3));
    for (final question in questions) {
      expect(question.type, 'multiple_choice');
      expect(question.source, 'instagram_reel');
      expect(question.sourceLabel, '@ok.english.kr Reel');
      expect(question.sourceUrl, startsWith('https://www.instagram.com/reel/'));
      expect(question.question, isNot(contains(question.correctAnswer)));
      expect(question.questionKo, isNot(contains(question.correctAnswer)));

      final options = (jsonDecode(question.options) as List).cast<String>();
      expect(options, contains(question.correctAnswer));
      expect(options.length, greaterThanOrEqualTo(3));
      expect(options.toSet(), hasLength(options.length));
    }
  });
}
