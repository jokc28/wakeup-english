import 'dart:math';

class XpFormula {
  /// XP required to advance FROM currentLevel TO currentLevel+1
  static int xpForNextLevel(int currentLevel) {
    final next = currentLevel + 1;
    return 100 * next + 10 * next * next;
  }

  /// Total cumulative XP needed to reach a given level (from level 1)
  static int cumulativeXpForLevel(int level) {
    var total = 0;
    for (var i = 1; i < level; i++) {
      total += xpForNextLevel(i);
    }
    return total;
  }

  /// Determine current level from total XP
  static int levelFromTotalXp(int totalXp) {
    var level = 1;
    var accumulated = 0;
    while (level < 50) {
      final needed = xpForNextLevel(level);
      if (accumulated + needed > totalXp) break;
      accumulated += needed;
      level++;
    }
    return level;
  }

  /// Progress within current level (0.0 to 1.0)
  static double progressInLevel(int totalXp, int currentLevel) {
    if (currentLevel >= 50) return 1;
    final base = cumulativeXpForLevel(currentLevel);
    final needed = xpForNextLevel(currentLevel);
    if (needed == 0) return 1;
    return ((totalXp - base) / needed).clamp(0.0, 1.0);
  }

  /// XP remaining to reach next level
  static int xpToNextLevel(int totalXp, int currentLevel) {
    if (currentLevel >= 50) return 0;
    final nextLevelCumulative = cumulativeXpForLevel(currentLevel + 1);
    return max(0, nextLevelCumulative - totalXp);
  }

  /// Calculate streak multiplier based on streak days
  static double streakMultiplier(int streakDays) {
    if (streakDays >= 30) return 1.5;
    if (streakDays >= 14) return 1.3;
    if (streakDays >= 7) return 1.2;
    if (streakDays >= 3) return 1.1;
    return 1;
  }

  /// Calculate total XP earned for a quiz session
  static int calculateSessionXp({
    required int questionCount,
    required int correctCount,
    required int streakDays,
    required int newMasteryCount,
  }) {
    // Base XP: 20 per question
    final baseXp = 20 * questionCount;

    // Accuracy bonus: 15 per correct answer
    final accuracyBonus = 15 * correctCount;

    // Perfect bonus: +50 if 100% correct
    final perfectBonus =
        (correctCount == questionCount && questionCount > 0) ? 50 : 0;

    // Mastery bonus: +25 per newly mastered item
    final masteryBonus = 25 * newMasteryCount;

    // Sub-total before streak
    final subtotal = baseXp + accuracyBonus + perfectBonus + masteryBonus;

    // Apply streak multiplier
    final multiplier = streakMultiplier(streakDays);
    return (subtotal * multiplier).round();
  }
}
