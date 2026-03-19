import 'package:flutter_test/flutter_test.dart';
import 'package:wakeup_english/features/quiz/domain/utils/xp_formula.dart';

void main() {
  group('xpForNextLevel', () {
    // Formula: 100 * next + 10 * next * next, where next = currentLevel + 1
    test('level 1 → 2 requires 240 XP', () {
      // next=2, 100*2 + 10*2*2 = 200 + 40 = 240
      expect(XpFormula.xpForNextLevel(1), 240);
    });

    test('level 2 → 3 requires 390 XP', () {
      // next=3, 100*3 + 10*3*3 = 300 + 90 = 390
      expect(XpFormula.xpForNextLevel(2), 390);
    });

    test('level 10 → 11 requires 2310 XP', () {
      // next=11, 100*11 + 10*11*11 = 1100 + 1210 = 2310
      expect(XpFormula.xpForNextLevel(10), 2310);
    });

    test('level 49 → 50', () {
      // next=50, 100*50 + 10*50*50 = 5000 + 25000 = 30000
      expect(XpFormula.xpForNextLevel(49), 30000);
    });

    test('XP requirement increases with level', () {
      for (int i = 1; i < 49; i++) {
        expect(XpFormula.xpForNextLevel(i + 1), greaterThan(XpFormula.xpForNextLevel(i)));
      }
    });
  });

  group('cumulativeXpForLevel', () {
    test('level 1 requires 0 cumulative XP', () {
      expect(XpFormula.cumulativeXpForLevel(1), 0);
    });

    test('level 2 requires xpForNextLevel(1)', () {
      expect(XpFormula.cumulativeXpForLevel(2), XpFormula.xpForNextLevel(1));
    });

    test('level 3 requires sum of levels 1 and 2', () {
      expect(
        XpFormula.cumulativeXpForLevel(3),
        XpFormula.xpForNextLevel(1) + XpFormula.xpForNextLevel(2),
      );
    });

    test('cumulative XP is monotonically increasing', () {
      for (int i = 1; i < 50; i++) {
        expect(
          XpFormula.cumulativeXpForLevel(i + 1),
          greaterThan(XpFormula.cumulativeXpForLevel(i)),
        );
      }
    });
  });

  group('levelFromTotalXp', () {
    test('0 XP = level 1', () {
      expect(XpFormula.levelFromTotalXp(0), 1);
    });

    test('XP just below level 2 threshold = level 1', () {
      final threshold = XpFormula.cumulativeXpForLevel(2);
      expect(XpFormula.levelFromTotalXp(threshold - 1), 1);
    });

    test('XP exactly at level 2 threshold = level 2', () {
      final threshold = XpFormula.cumulativeXpForLevel(2);
      expect(XpFormula.levelFromTotalXp(threshold), 2);
    });

    test('XP between level 2 and 3 = level 2', () {
      final threshold2 = XpFormula.cumulativeXpForLevel(2);
      final threshold3 = XpFormula.cumulativeXpForLevel(3);
      final midpoint = (threshold2 + threshold3) ~/ 2;
      expect(XpFormula.levelFromTotalXp(midpoint), 2);
    });

    test('massive XP is capped at level 50', () {
      expect(XpFormula.levelFromTotalXp(999999999), 50);
    });

    test('exactly at level 50 threshold = level 50', () {
      final threshold = XpFormula.cumulativeXpForLevel(50);
      expect(XpFormula.levelFromTotalXp(threshold), 50);
    });
  });

  group('progressInLevel', () {
    test('0 XP at level 1 = 0.0 progress', () {
      expect(XpFormula.progressInLevel(0, 1), 0.0);
    });

    test('at level 50, progress is 1.0', () {
      expect(XpFormula.progressInLevel(999999, 50), 1.0);
    });

    test('halfway through a level = ~0.5', () {
      final base = XpFormula.cumulativeXpForLevel(5);
      final needed = XpFormula.xpForNextLevel(5);
      final halfwayXp = base + (needed ~/ 2);
      final progress = XpFormula.progressInLevel(halfwayXp, 5);
      expect(progress, closeTo(0.5, 0.02));
    });

    test('progress is clamped between 0.0 and 1.0', () {
      expect(XpFormula.progressInLevel(0, 1), greaterThanOrEqualTo(0.0));
      expect(XpFormula.progressInLevel(0, 1), lessThanOrEqualTo(1.0));
    });
  });

  group('xpToNextLevel', () {
    test('0 XP at level 1 needs full amount for level 2', () {
      expect(XpFormula.xpToNextLevel(0, 1), XpFormula.xpForNextLevel(1));
    });

    test('at level 50, returns 0', () {
      expect(XpFormula.xpToNextLevel(999999, 50), 0);
    });

    test('never returns negative', () {
      expect(XpFormula.xpToNextLevel(0, 1), greaterThanOrEqualTo(0));
      expect(XpFormula.xpToNextLevel(999999, 50), greaterThanOrEqualTo(0));
    });
  });

  group('streakMultiplier', () {
    test('0 days = 1.0x', () {
      expect(XpFormula.streakMultiplier(0), 1.0);
    });

    test('2 days = 1.0x', () {
      expect(XpFormula.streakMultiplier(2), 1.0);
    });

    test('3 days = 1.1x', () {
      expect(XpFormula.streakMultiplier(3), 1.1);
    });

    test('7 days = 1.2x', () {
      expect(XpFormula.streakMultiplier(7), 1.2);
    });

    test('14 days = 1.3x', () {
      expect(XpFormula.streakMultiplier(14), 1.3);
    });

    test('30 days = 1.5x', () {
      expect(XpFormula.streakMultiplier(30), 1.5);
    });

    test('100 days = 1.5x (capped)', () {
      expect(XpFormula.streakMultiplier(100), 1.5);
    });
  });

  group('calculateSessionXp', () {
    test('zero questions yields 0 XP', () {
      final xp = XpFormula.calculateSessionXp(
        questionCount: 0,
        correctCount: 0,
        streakDays: 0,
        newMasteryCount: 0,
      );
      expect(xp, 0);
    });

    test('3 questions, 0 correct, no streak, no mastery', () {
      final xp = XpFormula.calculateSessionXp(
        questionCount: 3,
        correctCount: 0,
        streakDays: 0,
        newMasteryCount: 0,
      );
      // base: 20*3 = 60, accuracy: 15*0 = 0, perfect: 0, mastery: 0
      expect(xp, 60);
    });

    test('3 questions, 3 correct (perfect), no streak', () {
      final xp = XpFormula.calculateSessionXp(
        questionCount: 3,
        correctCount: 3,
        streakDays: 0,
        newMasteryCount: 0,
      );
      // base: 60, accuracy: 45, perfect: 50, mastery: 0 → 155
      expect(xp, 155);
    });

    test('3 questions, 2 correct (no perfect bonus)', () {
      final xp = XpFormula.calculateSessionXp(
        questionCount: 3,
        correctCount: 2,
        streakDays: 0,
        newMasteryCount: 0,
      );
      // base: 60, accuracy: 30, perfect: 0, mastery: 0 → 90
      expect(xp, 90);
    });

    test('mastery bonus adds 25 per mastered item', () {
      final xpNoMastery = XpFormula.calculateSessionXp(
        questionCount: 3,
        correctCount: 3,
        streakDays: 0,
        newMasteryCount: 0,
      );
      final xpWithMastery = XpFormula.calculateSessionXp(
        questionCount: 3,
        correctCount: 3,
        streakDays: 0,
        newMasteryCount: 2,
      );
      expect(xpWithMastery - xpNoMastery, 50); // 25 * 2
    });

    test('streak multiplier applies correctly', () {
      final xpNoStreak = XpFormula.calculateSessionXp(
        questionCount: 3,
        correctCount: 3,
        streakDays: 0,
        newMasteryCount: 0,
      );
      final xpWith30DayStreak = XpFormula.calculateSessionXp(
        questionCount: 3,
        correctCount: 3,
        streakDays: 30,
        newMasteryCount: 0,
      );
      // 1.5x multiplier
      expect(xpWith30DayStreak, (xpNoStreak * 1.5).round());
    });
  });
}
