// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'WakeUp English';

  @override
  String get alarms => '알람';

  @override
  String get settings => '설정';

  @override
  String get addAlarm => '알람 추가';

  @override
  String get editAlarm => '알람 편집';

  @override
  String get deleteAlarm => '알람 삭제';

  @override
  String get saveAlarm => '저장';

  @override
  String get cancel => '취소';

  @override
  String get alarmTime => '알람 시간';

  @override
  String get repeatDays => '반복';

  @override
  String get alarmLabel => '라벨';

  @override
  String get quizDifficulty => '퀴즈 난이도';

  @override
  String get difficultyEasy => '쉬움';

  @override
  String get difficultyMedium => '보통';

  @override
  String get difficultyHard => '어려움';

  @override
  String get monday => '월';

  @override
  String get tuesday => '화';

  @override
  String get wednesday => '수';

  @override
  String get thursday => '목';

  @override
  String get friday => '금';

  @override
  String get saturday => '토';

  @override
  String get sunday => '일';

  @override
  String get solveToStop => '알람을 끄려면 퀴즈를 풀어주세요';

  @override
  String get correct => '정답!';

  @override
  String get incorrect => '틀렸습니다. 다시 시도하세요';

  @override
  String get submit => '제출';

  @override
  String questionsRemaining(int count) {
    return '$count문제 남음';
  }

  @override
  String get noAlarms => '설정된 알람이 없습니다';

  @override
  String get alarmEnabled => '알람 켜짐';

  @override
  String get alarmDisabled => '알람 꺼짐';

  @override
  String get language => '언어';

  @override
  String get english => 'English';

  @override
  String get korean => '한국어';

  @override
  String get sound => '소리';

  @override
  String get vibration => '진동';

  @override
  String get snooze => '스누즈';

  @override
  String get snoozeDuration => '스누즈 시간';

  @override
  String minutes(int count) {
    return '$count분';
  }

  @override
  String get quizCount => '문제 수';
}
