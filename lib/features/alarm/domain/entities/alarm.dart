import 'package:flutter/material.dart';

/// Difficulty levels for quizzes
enum QuizDifficulty {
  easy,
  medium,
  hard;

  String get displayName {
    switch (this) {
      case QuizDifficulty.easy:
        return '쉬움';
      case QuizDifficulty.medium:
        return '보통';
      case QuizDifficulty.hard:
        return '어려움';
    }
  }

  static QuizDifficulty fromString(String value) {
    switch (value.toLowerCase()) {
      case 'easy':
        return QuizDifficulty.easy;
      case 'hard':
        return QuizDifficulty.hard;
      default:
        return QuizDifficulty.medium;
    }
  }
}

/// Domain entity representing an alarm
class AlarmEntity {
  final int? id;
  final String label;
  final TimeOfDay time;
  final bool isEnabled;
  final List<int> repeatDays; // 0-6 (Mon-Sun)
  final QuizDifficulty quizDifficulty;
  final int quizCount;
  final String soundPath;
  final bool vibrationEnabled;
  final int snoozeDuration; // minutes, 0 = disabled
  final int maxSnoozes;
  final int volume; // 0-100
  final bool gradualVolume;
  final DateTime? nextFireTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AlarmEntity({
    required this.time,
    this.id,
    this.label = '',
    this.isEnabled = true,
    this.repeatDays = const [],
    this.quizDifficulty = QuizDifficulty.medium,
    this.quizCount = 3,
    this.soundPath = 'assets/sounds/default_alarm.mp3',
    this.vibrationEnabled = true,
    this.snoozeDuration = 5,
    this.maxSnoozes = 3,
    this.volume = 100,
    this.gradualVolume = false,
    this.nextFireTime,
    this.createdAt,
    this.updatedAt,
  });

  /// Returns true if this is a repeating alarm
  bool get isRepeating => repeatDays.isNotEmpty;

  /// Returns true if this alarm repeats on all weekdays (Mon-Fri)
  bool get isWeekdays =>
      repeatDays.length == 5 &&
      repeatDays.contains(0) &&
      repeatDays.contains(1) &&
      repeatDays.contains(2) &&
      repeatDays.contains(3) &&
      repeatDays.contains(4);

  /// Returns true if this alarm repeats on weekends (Sat-Sun)
  bool get isWeekends =>
      repeatDays.length == 2 &&
      repeatDays.contains(5) &&
      repeatDays.contains(6);

  /// Returns true if this alarm repeats every day
  bool get isDaily => repeatDays.length == 7;

  /// Returns a formatted string for repeat days
  String get repeatDaysDisplay {
    if (repeatDays.isEmpty) return '한 번';
    if (isDaily) return '매일';
    if (isWeekdays) return '주중';
    if (isWeekends) return '주말';

    const dayNames = ['월', '화', '수', '목', '금', '토', '일'];
    final sortedDays = List<int>.from(repeatDays)..sort();
    return sortedDays.map((d) => dayNames[d]).join(', ');
  }

  /// Returns a formatted time string
  String get timeDisplay {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// Returns a 12-hour formatted time string
  String get timeDisplay12Hour {
    final h = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final period = time.hour < 12 ? 'AM' : 'PM';
    final minute = time.minute.toString().padLeft(2, '0');
    return '$h:$minute $period';
  }

  /// Create a copy with updated fields
  AlarmEntity copyWith({
    int? id,
    String? label,
    TimeOfDay? time,
    bool? isEnabled,
    List<int>? repeatDays,
    QuizDifficulty? quizDifficulty,
    int? quizCount,
    String? soundPath,
    bool? vibrationEnabled,
    int? snoozeDuration,
    int? maxSnoozes,
    int? volume,
    bool? gradualVolume,
    DateTime? nextFireTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AlarmEntity(
      id: id ?? this.id,
      label: label ?? this.label,
      time: time ?? this.time,
      isEnabled: isEnabled ?? this.isEnabled,
      repeatDays: repeatDays ?? this.repeatDays,
      quizDifficulty: quizDifficulty ?? this.quizDifficulty,
      quizCount: quizCount ?? this.quizCount,
      soundPath: soundPath ?? this.soundPath,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      snoozeDuration: snoozeDuration ?? this.snoozeDuration,
      maxSnoozes: maxSnoozes ?? this.maxSnoozes,
      volume: volume ?? this.volume,
      gradualVolume: gradualVolume ?? this.gradualVolume,
      nextFireTime: nextFireTime ?? this.nextFireTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          label == other.label &&
          time == other.time &&
          isEnabled == other.isEnabled &&
          _listEquals(repeatDays, other.repeatDays) &&
          quizDifficulty == other.quizDifficulty &&
          quizCount == other.quizCount &&
          soundPath == other.soundPath &&
          vibrationEnabled == other.vibrationEnabled &&
          snoozeDuration == other.snoozeDuration &&
          maxSnoozes == other.maxSnoozes &&
          volume == other.volume &&
          gradualVolume == other.gradualVolume;

  @override
  int get hashCode => Object.hash(
        id,
        label,
        time,
        isEnabled,
        Object.hashAll(repeatDays),
        quizDifficulty,
        quizCount,
        soundPath,
        vibrationEnabled,
        snoozeDuration,
        maxSnoozes,
        volume,
        gradualVolume,
      );

  static bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
