/// Determines mastery status for a vocabulary item.
///
/// An item is mastered when:
/// 1. It has been presented at least 3 times
/// 2. First-attempt correct rate is >= 80%
class MasteryLogic {
  static const int minPresentations = 3;
  static const double minCorrectRate = 0.8;

  /// Check if an item should be considered mastered
  static bool isMastered({
    required int timesPresented,
    required int timesCorrectFirstAttempt,
  }) {
    if (timesPresented < minPresentations) return false;
    return (timesCorrectFirstAttempt / timesPresented) >= minCorrectRate;
  }

  /// Check if the NEXT answer would cause the item to become mastered
  /// (assuming the answer is correct on first attempt)
  static bool wouldBecomeNewlyMastered({
    required int currentTimesPresented,
    required int currentTimesCorrectFirstAttempt,
    required bool currentlyMastered,
    required bool nextAnswerCorrect,
  }) {
    if (currentlyMastered) return false;

    final newPresented = currentTimesPresented + 1;
    final newCorrect =
        currentTimesCorrectFirstAttempt + (nextAnswerCorrect ? 1 : 0);

    return isMastered(
      timesPresented: newPresented,
      timesCorrectFirstAttempt: newCorrect,
    );
  }
}
