import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'streak_service.dart';

class StreakState {
  final int currentStreak;
  final int maxStreak;
  final bool completedToday;

  const StreakState({
    this.currentStreak = 0,
    this.maxStreak = 0,
    this.completedToday = false,
  });

  StreakState copyWith({
    int? currentStreak,
    int? maxStreak,
    bool? completedToday,
  }) {
    return StreakState(
      currentStreak: currentStreak ?? this.currentStreak,
      maxStreak: maxStreak ?? this.maxStreak,
      completedToday: completedToday ?? this.completedToday,
    );
  }
}

class StreakNotifier extends StateNotifier<StreakState> {
  StreakNotifier() : super(const StreakState()) {
    loadStreak();
  }

  Future<void> loadStreak() async {
    try {
      final data = await StreakService.getStreak();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final completedToday = data.lastCompletedDate != null &&
          DateTime(
                data.lastCompletedDate!.year,
                data.lastCompletedDate!.month,
                data.lastCompletedDate!.day,
              ) ==
              today;

      state = StreakState(
        currentStreak: data.currentStreak,
        maxStreak: data.maxStreak,
        completedToday: completedToday,
      );
    } catch (e) {
      debugPrint('[StreakProvider] Failed to load streak: $e');
    }
  }

  Future<void> recordCompletion() async {
    try {
      final data = await StreakService.recordCompletion();
      state = StreakState(
        currentStreak: data.currentStreak,
        maxStreak: data.maxStreak,
        completedToday: true,
      );
    } catch (e) {
      debugPrint('[StreakProvider] Failed to record completion: $e');
    }
  }
}

final streakProvider =
    StateNotifierProvider<StreakNotifier, StreakState>((ref) {
  return StreakNotifier();
});
