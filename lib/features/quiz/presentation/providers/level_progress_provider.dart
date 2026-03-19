import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/utils/xp_formula.dart';

/// Result returned after awarding XP
class XpAwardResult {
  final int xpEarned;
  final bool leveledUp;
  final int? newLevel;
  final int newMasteryCount;

  const XpAwardResult({
    required this.xpEarned,
    required this.leveledUp,
    this.newLevel,
    required this.newMasteryCount,
  });
}

/// State for user level progression
class LevelProgressState {
  final int currentLevel;
  final int totalXp;
  final double progressInLevel; // 0.0-1.0
  final int xpToNextLevel;
  final int totalItemsMastered;
  final int totalQuizzesCompleted;
  final int dailyXp;

  const LevelProgressState({
    this.currentLevel = 1,
    this.totalXp = 0,
    this.progressInLevel = 0.0,
    this.xpToNextLevel = 0,
    this.totalItemsMastered = 0,
    this.totalQuizzesCompleted = 0,
    this.dailyXp = 0,
  });

  LevelProgressState copyWith({
    int? currentLevel,
    int? totalXp,
    double? progressInLevel,
    int? xpToNextLevel,
    int? totalItemsMastered,
    int? totalQuizzesCompleted,
    int? dailyXp,
  }) {
    return LevelProgressState(
      currentLevel: currentLevel ?? this.currentLevel,
      totalXp: totalXp ?? this.totalXp,
      progressInLevel: progressInLevel ?? this.progressInLevel,
      xpToNextLevel: xpToNextLevel ?? this.xpToNextLevel,
      totalItemsMastered: totalItemsMastered ?? this.totalItemsMastered,
      totalQuizzesCompleted:
          totalQuizzesCompleted ?? this.totalQuizzesCompleted,
      dailyXp: dailyXp ?? this.dailyXp,
    );
  }
}

class LevelProgressNotifier extends StateNotifier<LevelProgressState> {
  final AppDatabase _db;

  LevelProgressNotifier(this._db) : super(const LevelProgressState()) {
    refresh();
  }

  /// Refresh state from database
  Future<void> refresh() async {
    try {
      final progress = await _db.getUserLevelProgress();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      // Reset daily XP if it's a new day
      int dailyXp = progress.dailyXp;
      if (progress.lastXpDate != null) {
        final lastDate = DateTime(
          progress.lastXpDate!.year,
          progress.lastXpDate!.month,
          progress.lastXpDate!.day,
        );
        if (lastDate.isBefore(today)) {
          dailyXp = 0;
          await _db.updateUserLevelProgress(dailyXp: 0);
        }
      }

      state = LevelProgressState(
        currentLevel: progress.currentLevel,
        totalXp: progress.totalXp,
        progressInLevel: XpFormula.progressInLevel(
          progress.totalXp,
          progress.currentLevel,
        ),
        xpToNextLevel: XpFormula.xpToNextLevel(
          progress.totalXp,
          progress.currentLevel,
        ),
        totalItemsMastered: progress.totalItemsMastered,
        totalQuizzesCompleted: progress.totalQuizzesCompleted,
        dailyXp: dailyXp,
      );
    } catch (e) {
      debugPrint('[LevelProgress] Failed to refresh: $e');
    }
  }

  /// Award XP after a quiz session
  Future<XpAwardResult> awardXp({
    required int correctCount,
    required int totalCount,
    required int newMasteryCount,
    required int streakDays,
  }) async {
    final xpEarned = XpFormula.calculateSessionXp(
      questionCount: totalCount,
      correctCount: correctCount,
      streakDays: streakDays,
      newMasteryCount: newMasteryCount,
    );

    final progress = await _db.getUserLevelProgress();
    final newTotalXp = progress.totalXp + xpEarned;
    final newLevel = XpFormula.levelFromTotalXp(newTotalXp);
    final leveledUp = newLevel > progress.currentLevel;
    final now = DateTime.now();

    // Reset daily XP if new day
    final today = DateTime(now.year, now.month, now.day);
    int newDailyXp = progress.dailyXp + xpEarned;
    if (progress.lastXpDate != null) {
      final lastDate = DateTime(
        progress.lastXpDate!.year,
        progress.lastXpDate!.month,
        progress.lastXpDate!.day,
      );
      if (lastDate.isBefore(today)) {
        newDailyXp = xpEarned;
      }
    }

    final masteredCount = await _db.getMasteredCount();

    // Update DB
    await _db.updateUserLevelProgress(
      currentLevel: newLevel,
      totalXp: newTotalXp,
      dailyXp: newDailyXp,
      lastXpDate: now,
      totalQuizzesCompleted: progress.totalQuizzesCompleted + 1,
      totalCorrectAnswers: progress.totalCorrectAnswers + correctCount,
      totalItemsMastered: masteredCount,
    );

    // Record XP transaction (includes mastery bonus in the total)
    await _db.insertXpTransaction(
      amount: xpEarned,
      source: correctCount == totalCount ? 'perfect_quiz' : 'quiz_complete',
      levelAtTime: progress.currentLevel,
    );

    // Update state
    state = LevelProgressState(
      currentLevel: newLevel,
      totalXp: newTotalXp,
      progressInLevel: XpFormula.progressInLevel(newTotalXp, newLevel),
      xpToNextLevel: XpFormula.xpToNextLevel(newTotalXp, newLevel),
      totalItemsMastered: masteredCount,
      totalQuizzesCompleted: progress.totalQuizzesCompleted + 1,
      dailyXp: newDailyXp,
    );

    return XpAwardResult(
      xpEarned: xpEarned,
      leveledUp: leveledUp,
      newLevel: leveledUp ? newLevel : null,
      newMasteryCount: newMasteryCount,
    );
  }
}

final levelProgressProvider =
    StateNotifierProvider<LevelProgressNotifier, LevelProgressState>((ref) {
  final db = ref.watch(databaseProvider);
  return LevelProgressNotifier(db);
});
