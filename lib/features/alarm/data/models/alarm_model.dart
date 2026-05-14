import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/alarm.dart';

/// Extension to convert between database model and domain entity
extension AlarmModelMapper on Alarm {
  /// Convert database model to domain entity
  AlarmEntity toEntity() {
    return AlarmEntity(
      id: id,
      label: label,
      time: TimeOfDay(hour: hour, minute: minute),
      isEnabled: isEnabled,
      repeatDays: _parseRepeatDays(repeatDays),
      quizDifficulty: QuizDifficulty.fromString(quizDifficulty),
      quizCount: quizCount,
      soundPath: soundPath,
      vibrationEnabled: vibrationEnabled,
      snoozeDuration: snoozeDuration,
      maxSnoozes: maxSnoozes,
      volume: volume,
      gradualVolume: gradualVolume,
      nextFireTime: nextFireTime,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static List<int> _parseRepeatDays(String json) {
    try {
      final decoded = jsonDecode(json) as List<dynamic>;
      return decoded.cast<int>();
    } catch (e) {
      return [];
    }
  }
}

/// Extension to convert domain entity to database companion
extension AlarmEntityMapper on AlarmEntity {
  /// Convert domain entity to database companion for insert/update
  AlarmsCompanion toCompanion() {
    return AlarmsCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      label: Value(label),
      hour: Value(time.hour),
      minute: Value(time.minute),
      isEnabled: Value(isEnabled),
      repeatDays: Value(jsonEncode(repeatDays)),
      quizDifficulty: Value(quizDifficulty.name),
      quizCount: Value(quizCount),
      soundPath: Value(soundPath),
      vibrationEnabled: Value(vibrationEnabled),
      snoozeDuration: Value(snoozeDuration),
      maxSnoozes: Value(maxSnoozes),
      volume: Value(volume),
      gradualVolume: Value(gradualVolume),
      updatedAt: Value(DateTime.now()),
    );
  }

  /// Convert domain entity to database companion for insert (without id)
  AlarmsCompanion toInsertCompanion() {
    return AlarmsCompanion.insert(
      label: Value(label),
      hour: time.hour,
      minute: time.minute,
      isEnabled: Value(isEnabled),
      repeatDays: Value(jsonEncode(repeatDays)),
      quizDifficulty: Value(quizDifficulty.name),
      quizCount: Value(quizCount),
      soundPath: Value(soundPath),
      vibrationEnabled: Value(vibrationEnabled),
      snoozeDuration: Value(snoozeDuration),
      maxSnoozes: Value(maxSnoozes),
      volume: Value(volume),
      gradualVolume: Value(gradualVolume),
    );
  }
}

/// Helper class for creating alarm companions
class AlarmModel {
  /// Create a new alarm companion from individual values
  static AlarmsCompanion create({
    required int hour,
    required int minute,
    String label = '',
    bool isEnabled = true,
    List<int> repeatDays = const [],
    QuizDifficulty quizDifficulty = QuizDifficulty.medium,
    int quizCount = 3,
    String soundPath = 'assets/sounds/default_alarm.mp3',
    bool vibrationEnabled = true,
    int snoozeDuration = 5,
    int maxSnoozes = 3,
    int volume = 100,
    bool gradualVolume = false,
  }) {
    return AlarmsCompanion.insert(
      label: Value(label),
      hour: hour,
      minute: minute,
      isEnabled: Value(isEnabled),
      repeatDays: Value(jsonEncode(repeatDays)),
      quizDifficulty: Value(quizDifficulty.name),
      quizCount: Value(quizCount),
      soundPath: Value(soundPath),
      vibrationEnabled: Value(vibrationEnabled),
      snoozeDuration: Value(snoozeDuration),
      maxSnoozes: Value(maxSnoozes),
      volume: Value(volume),
      gradualVolume: Value(gradualVolume),
    );
  }
}
