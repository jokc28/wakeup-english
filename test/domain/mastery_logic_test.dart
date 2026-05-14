import 'package:flutter_test/flutter_test.dart';
import 'package:wakeup_english/features/quiz/domain/utils/mastery_logic.dart';

void main() {
  group('MasteryLogic.isMastered', () {
    test('3 presentations, 3 correct (100%) → mastered', () {
      expect(
        MasteryLogic.isMastered(timesPresented: 3, timesCorrectFirstAttempt: 3),
        isTrue,
      );
    });

    test('3 presentations, 2 correct (66.7%) → NOT mastered', () {
      expect(
        MasteryLogic.isMastered(timesPresented: 3, timesCorrectFirstAttempt: 2),
        isFalse,
      );
    });

    test('5 presentations, 4 correct (80%) → mastered (boundary)', () {
      expect(
        MasteryLogic.isMastered(timesPresented: 5, timesCorrectFirstAttempt: 4),
        isTrue,
      );
    });

    test('5 presentations, 3 correct (60%) → NOT mastered', () {
      expect(
        MasteryLogic.isMastered(timesPresented: 5, timesCorrectFirstAttempt: 3),
        isFalse,
      );
    });

    test('10 presentations, 8 correct (80%) → mastered', () {
      expect(
        MasteryLogic.isMastered(
            timesPresented: 10, timesCorrectFirstAttempt: 8),
        isTrue,
      );
    });

    test('10 presentations, 7 correct (70%) → NOT mastered', () {
      expect(
        MasteryLogic.isMastered(
            timesPresented: 10, timesCorrectFirstAttempt: 7),
        isFalse,
      );
    });

    test('2 presentations, 2 correct → NOT mastered (below min presentations)',
        () {
      expect(
        MasteryLogic.isMastered(timesPresented: 2, timesCorrectFirstAttempt: 2),
        isFalse,
      );
    });

    test('0 presentations → NOT mastered', () {
      expect(
        MasteryLogic.isMastered(timesPresented: 0, timesCorrectFirstAttempt: 0),
        isFalse,
      );
    });

    test('1 presentation, 1 correct → NOT mastered', () {
      expect(
        MasteryLogic.isMastered(timesPresented: 1, timesCorrectFirstAttempt: 1),
        isFalse,
      );
    });

    test('4 presentations, 3 correct (75%) → NOT mastered', () {
      expect(
        MasteryLogic.isMastered(timesPresented: 4, timesCorrectFirstAttempt: 3),
        isFalse,
      );
    });

    test('constants are accessible', () {
      expect(MasteryLogic.minPresentations, 3);
      expect(MasteryLogic.minCorrectRate, 0.8);
    });
  });

  group('MasteryLogic.wouldBecomeNewlyMastered', () {
    test('already mastered → returns false', () {
      expect(
        MasteryLogic.wouldBecomeNewlyMastered(
          currentTimesPresented: 10,
          currentTimesCorrectFirstAttempt: 10,
          currentlyMastered: true,
          nextAnswerCorrect: true,
        ),
        isFalse,
      );
    });

    test(
        '2 presentations, 2 correct, next correct → becomes mastered (3/3 = 100%)',
        () {
      expect(
        MasteryLogic.wouldBecomeNewlyMastered(
          currentTimesPresented: 2,
          currentTimesCorrectFirstAttempt: 2,
          currentlyMastered: false,
          nextAnswerCorrect: true,
        ),
        isTrue,
      );
    });

    test('2 presentations, 2 correct, next wrong → NOT mastered (2/3 = 66%)',
        () {
      expect(
        MasteryLogic.wouldBecomeNewlyMastered(
          currentTimesPresented: 2,
          currentTimesCorrectFirstAttempt: 2,
          currentlyMastered: false,
          nextAnswerCorrect: false,
        ),
        isFalse,
      );
    });

    test('4 presentations, 3 correct, next correct → mastered (4/5 = 80%)', () {
      expect(
        MasteryLogic.wouldBecomeNewlyMastered(
          currentTimesPresented: 4,
          currentTimesCorrectFirstAttempt: 3,
          currentlyMastered: false,
          nextAnswerCorrect: true,
        ),
        isTrue,
      );
    });

    test(
        '1 presentation, 1 correct, next correct → NOT mastered (2/2, but < 3 presentations)',
        () {
      expect(
        MasteryLogic.wouldBecomeNewlyMastered(
          currentTimesPresented: 1,
          currentTimesCorrectFirstAttempt: 1,
          currentlyMastered: false,
          nextAnswerCorrect: true,
        ),
        isFalse,
      );
    });
  });
}
