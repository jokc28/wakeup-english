import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/alarm/domain/entities/alarm.dart';
import '../constants/app_strings.dart';

class AppSettingsState {
  final int defaultQuizCount;
  final QuizDifficulty defaultDifficulty;
  final int defaultSnoozeMinutes;
  final bool vibrationEnabled;
  final bool gradualVolumeEnabled;

  const AppSettingsState({
    this.defaultQuizCount = 3,
    this.defaultDifficulty = QuizDifficulty.medium,
    this.defaultSnoozeMinutes = 5,
    this.vibrationEnabled = true,
    this.gradualVolumeEnabled = false,
  });

  AppSettingsState copyWith({
    int? defaultQuizCount,
    QuizDifficulty? defaultDifficulty,
    int? defaultSnoozeMinutes,
    bool? vibrationEnabled,
    bool? gradualVolumeEnabled,
  }) {
    return AppSettingsState(
      defaultQuizCount: defaultQuizCount ?? this.defaultQuizCount,
      defaultDifficulty: defaultDifficulty ?? this.defaultDifficulty,
      defaultSnoozeMinutes: defaultSnoozeMinutes ?? this.defaultSnoozeMinutes,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      gradualVolumeEnabled: gradualVolumeEnabled ?? this.gradualVolumeEnabled,
    );
  }
}

final appSettingsProvider =
    StateNotifierProvider<AppSettingsNotifier, AppSettingsState>((ref) {
  return AppSettingsNotifier();
});

class AppSettingsNotifier extends StateNotifier<AppSettingsState> {
  AppSettingsNotifier() : super(const AppSettingsState()) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = AppSettingsState(
      defaultQuizCount: prefs.getInt(AppStrings.prefDefaultQuizCount) ?? 3,
      defaultDifficulty: QuizDifficulty.fromString(
        prefs.getString(AppStrings.prefDefaultDifficulty) ?? 'medium',
      ),
      defaultSnoozeMinutes: prefs.getInt(AppStrings.prefDefaultSnooze) ?? 5,
      vibrationEnabled: prefs.getBool(AppStrings.prefVibrationEnabled) ?? true,
      gradualVolumeEnabled:
          prefs.getBool(AppStrings.prefGradualVolume) ?? false,
    );
  }

  Future<void> setDefaultQuizCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppStrings.prefDefaultQuizCount, count);
    state = state.copyWith(defaultQuizCount: count);
  }

  Future<void> setDefaultDifficulty(QuizDifficulty difficulty) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppStrings.prefDefaultDifficulty,
      difficulty.name,
    );
    state = state.copyWith(defaultDifficulty: difficulty);
  }

  Future<void> setDefaultSnoozeMinutes(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppStrings.prefDefaultSnooze, minutes);
    state = state.copyWith(defaultSnoozeMinutes: minutes);
  }

  Future<void> setVibrationEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppStrings.prefVibrationEnabled, enabled);
    state = state.copyWith(vibrationEnabled: enabled);
  }

  Future<void> setGradualVolumeEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppStrings.prefGradualVolume, enabled);
    state = state.copyWith(gradualVolumeEnabled: enabled);
  }
}
