import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/app_settings_provider.dart';
import '../../data/repositories/alarm_repository.dart';
import '../../domain/entities/alarm.dart';

part 'alarm_provider.g.dart';

/// Provider for watching all alarms
@riverpod
Stream<List<AlarmEntity>> alarms(Ref ref) {
  final repository = ref.watch(alarmRepositoryProvider);
  return repository.watchAllAlarms();
}

/// Provider for getting a single alarm by ID
@riverpod
Future<AlarmEntity?> alarmById(Ref ref, int id) async {
  final repository = ref.watch(alarmRepositoryProvider);
  return repository.getAlarmById(id);
}

/// Provider for the alarm form state (for create/edit)
@riverpod
class AlarmForm extends _$AlarmForm {
  @override
  AlarmEntity build({int? alarmId}) {
    if (alarmId != null) {
      // Load existing alarm
      _loadAlarm(alarmId);
      return _defaultAlarm(const AppSettingsState());
    }
    final settings = ref.watch(appSettingsProvider);
    return _defaultAlarm(settings);
  }

  AlarmEntity _defaultAlarm(AppSettingsState settings) {
    final now = TimeOfDay.now();
    return AlarmEntity(
      time: TimeOfDay(
        hour: (now.hour + 1) % 24,
        minute: 0,
      ),
      quizDifficulty: settings.defaultDifficulty,
      quizCount: settings.defaultQuizCount,
      snoozeDuration: settings.defaultSnoozeMinutes,
      vibrationEnabled: settings.vibrationEnabled,
      gradualVolume: settings.gradualVolumeEnabled,
    );
  }

  Future<void> _loadAlarm(int id) async {
    final repository = ref.read(alarmRepositoryProvider);
    final alarm = await repository.getAlarmById(id);
    if (alarm != null) {
      state = alarm;
    }
  }

  void setTime(TimeOfDay time) {
    state = state.copyWith(time: time);
  }

  void setLabel(String label) {
    state = state.copyWith(label: label);
  }

  void setEnabled(bool enabled) {
    state = state.copyWith(isEnabled: enabled);
  }

  void setRepeatDays(List<int> days) {
    state = state.copyWith(repeatDays: days);
  }

  void toggleRepeatDay(int day) {
    final days = List<int>.from(state.repeatDays);
    if (days.contains(day)) {
      days.remove(day);
    } else {
      days.add(day);
      days.sort();
    }
    state = state.copyWith(repeatDays: days);
  }

  void setQuizDifficulty(QuizDifficulty difficulty) {
    state = state.copyWith(quizDifficulty: difficulty);
  }

  void setQuizCount(int count) {
    state = state.copyWith(quizCount: count);
  }

  void setSoundPath(String path) {
    state = state.copyWith(soundPath: path);
  }

  void setVibrationEnabled(bool enabled) {
    state = state.copyWith(vibrationEnabled: enabled);
  }

  void setSnoozeDuration(int minutes) {
    state = state.copyWith(snoozeDuration: minutes);
  }

  void setMaxSnoozes(int count) {
    state = state.copyWith(maxSnoozes: count);
  }

  void setVolume(int volume) {
    state = state.copyWith(volume: volume);
  }

  void setGradualVolume(bool enabled) {
    state = state.copyWith(gradualVolume: enabled);
  }

  Future<int?> save() async {
    final repository = ref.read(alarmRepositoryProvider);

    if (state.id != null) {
      // Update existing alarm
      final success = await repository.updateAlarm(state);
      return success ? state.id : null;
    } else {
      // Create new alarm
      return repository.createAlarm(state);
    }
  }
}

/// Provider for alarm operations (toggle, delete, etc.)
@riverpod
class AlarmOperations extends _$AlarmOperations {
  @override
  FutureOr<void> build() {}

  Future<bool> toggleAlarm(int id, bool enabled) async {
    final repository = ref.read(alarmRepositoryProvider);
    return repository.toggleAlarmEnabled(id, enabled);
  }

  Future<bool> deleteAlarm(int id) async {
    final repository = ref.read(alarmRepositoryProvider);
    return repository.deleteAlarm(id);
  }

  Future<bool> restoreAlarm(AlarmEntity alarm) async {
    final repository = ref.read(alarmRepositoryProvider);
    return repository.restoreAlarm(alarm);
  }

  Future<bool> stopAlarm(int id) async {
    final repository = ref.read(alarmRepositoryProvider);
    return repository.stopAlarm(id);
  }

  Future<bool> snoozeAlarm(int id, {int? durationMinutes}) async {
    final repository = ref.read(alarmRepositoryProvider);
    return repository.snoozeAlarm(id, durationMinutes: durationMinutes);
  }
}
