// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '옥모닝';

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

  @override
  String get errorRestartApp => '앱을 다시 시작해 주세요';

  @override
  String get errorTemporaryIssue => '일시적인 오류가 발생했습니다.';

  @override
  String get errorLoadingAlarms => '알람 불러오기 오류';

  @override
  String alarmDeletedMessage(String label) {
    return '\"$label\" 삭제됨';
  }

  @override
  String get alarmDeletedGeneric => '알람이 삭제되었습니다';

  @override
  String get undoAction => '되돌리기';

  @override
  String get confirmDeleteAlarm => '이 알람을 삭제하시겠습니까?';

  @override
  String confirmDeleteAlarmWithLabel(String label) {
    return '\"$label\" 알람을 삭제하시겠습니까?';
  }

  @override
  String confirmDeleteAlarmWithTime(String time) {
    return '$time 알람을 삭제하시겠습니까?';
  }

  @override
  String get alarmUpdated => '알람이 업데이트되었습니다';

  @override
  String get alarmCreated => '알람이 생성되었습니다';

  @override
  String get deleteButton => '삭제';

  @override
  String get timePickerTapHint => '탭하여 시간 변경';

  @override
  String get alarmNameLabel => '알람 이름';

  @override
  String get optionalLabel => '선택사항';

  @override
  String get wakeMissionLabel => '기상 미션';

  @override
  String get difficultyLabel => '난이도';

  @override
  String get alarmSoundLabel => '알람음';

  @override
  String get soundLabel => '소리';

  @override
  String get gradualVolumeLabel => '점진적 볼륨';

  @override
  String get volumeLabel => '볼륨';

  @override
  String get snoozeLabel => '다시 알림';

  @override
  String get snoozeIntervalLabel => '간격';

  @override
  String get maxSnoozesLabel => '최대 횟수';

  @override
  String maxSnoozesFormat(int count) {
    return '$count회';
  }

  @override
  String get setAlarmTimeTitle => '알람 시간 설정';

  @override
  String get doneButton => '완료';

  @override
  String get repeatOnce => '한 번';

  @override
  String get repeatDaily => '매일';

  @override
  String get repeatWeekdays => '주중';

  @override
  String get repeatWeekends => '주말';

  @override
  String get goodMorningGreeting => '오늘도 상쾌한 옥모닝!';

  @override
  String get loadingQuiz => '퀴즈 불러오는 중...';

  @override
  String get explanationLabel => '해설';

  @override
  String get quizCompleteButton => '퀴즈 완료';

  @override
  String get nextQuestionButton => '다음 문제';

  @override
  String scoreDisplay(int correct, int total) {
    return '$correct/$total 정답!';
  }

  @override
  String get quizCompletedMessage => '퀴즈 완료!';

  @override
  String get dismissAlarmButton => '알람 해제';

  @override
  String get trialExpiredTitle => '무료 체험 종료';

  @override
  String get trialExpiredMessage => '무료 체험 기간(7일)이 만료되었습니다.\n계속 이용하려면 구독해주세요.';

  @override
  String get restorePurchasesDebug => '구매 복원 (Debug)';

  @override
  String get subscribeButton => '구독하기';

  @override
  String get correctAnswerLabel => '정답: ';

  @override
  String hintLabel(String hint) {
    return '힌트: $hint';
  }

  @override
  String get enterAnswerPlaceholder => '답을 입력하세요...';

  @override
  String get startMissionSlide => '미션 시작하기';

  @override
  String get speakInstructions => '아래 문장을 영어로 말해 보세요';

  @override
  String get recognizedTextLabel => '인식된 텍스트:';

  @override
  String similarityPercentage(String percent) {
    return '일치도: $percent%';
  }

  @override
  String get micNotAvailableMessage => '마이크를 사용할 수 없습니다. 답을 직접 입력해 주세요.';

  @override
  String get enterEnglishPlaceholder => '영어로 입력하세요...';

  @override
  String get holdToSpeak => '길게 눌러 말하기';

  @override
  String get typeInsteadButton => '직접 입력하기';

  @override
  String get listeningMessage => '듣고 있습니다...';

  @override
  String get wordScrambleInstruction => '글자를 맞춰 단어를 완성하세요';

  @override
  String get speakingChallengeInstruction => '다음 문장을 영어로 말해 보세요';

  @override
  String get noAlarmsSubtitle => '아래 버튼을 눌러 영어 퀴즈 알람을 만들어 보세요';

  @override
  String get homeWelcome => '오늘도 상쾌한 옥모닝!';

  @override
  String quizInfoFormat(String difficulty, int count) {
    return '$difficulty $count문제';
  }

  @override
  String get alarmSoundTitle => '알람 소리';

  @override
  String get soundPickerHint => '탭하여 미리 듣기, 길게 눌러 선택';

  @override
  String get defaultAlarmSettings => '기본 알람 설정';

  @override
  String get defaultQuizCount => '기본 문제 수';

  @override
  String get defaultDifficulty => '기본 난이도';

  @override
  String get defaultSnoozeTime => '기본 미루기 시간';

  @override
  String get missionTypeHeader => '미션 유형';

  @override
  String get wordScrambleMission => '철자 맞추기';

  @override
  String get wordScrambleDescription => '영어 단어의 철자를 맞추는 미션';

  @override
  String get speakingChallengeMission => '말하기 도전';

  @override
  String get speakingChallengeDescription => '영어 문장을 소리 내어 말하는 미션';

  @override
  String get soundVibrationHeader => '소리 및 진동';

  @override
  String get vibrationDescription => '알람 울릴 때 진동';

  @override
  String get gradualVolumeDescription => '알람 볼륨을 점진적으로 높이기';

  @override
  String get subscriptionHeader => '구독';

  @override
  String get upgradeToPremium => '프리미엄으로 업그레이드';

  @override
  String get unlockAllContent => '모든 소리 및 문제 잠금 해제';

  @override
  String get restorePurchasesLabel => '구매 복원';

  @override
  String get restorePurchasesDescription => '이전 구매 내역 복원';

  @override
  String get debugPremiumMode => '[Debug] 프리미엄 모드';

  @override
  String get debugPremiumEnabled => '활성화됨 - 탭하여 해제';

  @override
  String get debugPremiumDisabled => '비활성화됨 - 탭하여 활성화';

  @override
  String get aboutHeader => '정보';

  @override
  String get versionLabel => '버전';

  @override
  String get licensesLabel => '오픈소스 라이선스';

  @override
  String get licensesDescription => '사용된 오픈소스 라이선스';

  @override
  String get dataHeader => '데이터';

  @override
  String get clearProgressLabel => '퀴즈 진행 기록 초기화';

  @override
  String get clearProgressDescription => '모든 학습 기록 초기화';

  @override
  String get selectLanguageDialog => '언어 선택';

  @override
  String get selectQuizCountDialog => '기본 문제 수';

  @override
  String quizCountFormat(int count) {
    return '$count문제';
  }

  @override
  String get selectDifficultyDialog => '기본 난이도';

  @override
  String get easyDifficultyDesc => '기본 어휘 및 문법';

  @override
  String get mediumDifficultyDesc => '중급 수준';

  @override
  String get hardDifficultyDesc => '고급 어휘 및 관용어';

  @override
  String get selectSnoozeDialog => '기본 미루기 시간';

  @override
  String get clearProgressDialog => '진행 기록 초기화';

  @override
  String get clearProgressWarning => '모든 퀴즈 학습 기록이 초기화됩니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get progressClearedSnackbar => '기록이 초기화되었습니다';

  @override
  String get resetButton => '초기화';

  @override
  String get purchasesRestoredSnackbar => '구매가 복원되었습니다!';

  @override
  String get noPurchasesToRestore => '복원할 구매 내역이 없습니다';

  @override
  String get unlockPremium => '프리미엄 잠금 해제';

  @override
  String get premiumSubtitle => '옥모닝 프로로 더 완벽한 아침을 만드세요';

  @override
  String get feature1Title => '120개 퀴즈 문제';

  @override
  String get feature1Desc => '모든 카테고리와 난이도의 전체 라이브러리';

  @override
  String get feature2Title => '10가지 알람 소리';

  @override
  String get feature2Desc => '파도 소리, 피아노, 재즈 등 프리미엄 사운드';

  @override
  String get feature3Title => '고급 학습 기능';

  @override
  String get feature3Desc => '취약 부분에 집중하는 맞춤형 퀴즈';

  @override
  String get feature4Title => '새로운 콘텐츠 업데이트';

  @override
  String get feature4Desc => '정기적인 새 문제 및 소리 추가';

  @override
  String get subscribeNowButton => '지금 구독하기';

  @override
  String get startTrialButton => '무료 체험 시작';

  @override
  String get subscriptionTerms =>
      '구독은 현재 기간 종료 최소 24시간 전에 해지하지 않으면 자동으로 갱신됩니다. 기기 설정에서 구독을 관리할 수 있습니다.';

  @override
  String get termsOfService => '이용약관';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get premiumMonthlyPlan => '프리미엄 월간';

  @override
  String premiumMonthlyPrice(String price) {
    return '$price/월';
  }

  @override
  String get trialIncluded => '7일 무료 체험 포함';

  @override
  String get welcomeToPremium => '프리미엄에 오신 것을 환영합니다!';

  @override
  String get purchasesRestored => '구매가 복원되었습니다!';

  @override
  String get morningStreak => '기상 스트릭';

  @override
  String streakDays(int count) {
    return '$count일 연속 기상!';
  }

  @override
  String streakRecord(int count) {
    return '최고 기록: $count일';
  }

  @override
  String get streakNewRecord => '신기록!';

  @override
  String get streakStart => '연속 기상을 시작하세요!';

  @override
  String get completedToday => '오늘 완료';

  @override
  String get premiumStatus => '프리미엄';

  @override
  String get premiumAllContent => '모든 콘텐츠 이용 가능';

  @override
  String get freeTrialStatus => '무료 체험';

  @override
  String trialDaysRemaining(int count) {
    return '$count일 남음';
  }

  @override
  String get freePlanStatus => '무료 플랜';

  @override
  String get freePlanLimits => '30문제, 3개 소리';

  @override
  String get upgradeButton => '업그레이드';
}
