import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  /// Converts TimeOfDay to total minutes since midnight
  int toMinutes() => hour * 60 + minute;

  /// Creates TimeOfDay from total minutes since midnight
  static TimeOfDay fromMinutes(int minutes) {
    return TimeOfDay(
      hour: minutes ~/ 60,
      minute: minutes % 60,
    );
  }

  /// Formats TimeOfDay as HH:mm string
  String toFormattedString() {
    final hourStr = hour.toString().padLeft(2, '0');
    final minuteStr = minute.toString().padLeft(2, '0');
    return '$hourStr:$minuteStr';
  }

  /// Formats TimeOfDay as 12-hour string with AM/PM
  String to12HourString() {
    final h = hour % 12 == 0 ? 12 : hour % 12;
    final period = hour < 12 ? 'AM' : 'PM';
    final minuteStr = minute.toString().padLeft(2, '0');
    return '$h:$minuteStr $period';
  }

  /// Returns DateTime for today at this time
  DateTime toDateTime() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  /// Returns DateTime for the next occurrence of this time
  DateTime toNextDateTime() {
    final now = DateTime.now();
    var dateTime = DateTime(now.year, now.month, now.day, hour, minute);
    if (dateTime.isBefore(now)) {
      dateTime = dateTime.add(const Duration(days: 1));
    }
    return dateTime;
  }
}

extension DateTimeExtension on DateTime {
  /// Converts DateTime to TimeOfDay
  TimeOfDay toTimeOfDay() => TimeOfDay(hour: hour, minute: minute);

  /// Returns true if this DateTime is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Returns true if this DateTime is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Returns the weekday as 0-6 (Monday = 0, Sunday = 6)
  int get weekdayIndex => weekday - 1;
}

extension StringExtension on String {
  /// Capitalizes the first letter
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Parses time string (HH:mm) to TimeOfDay
  TimeOfDay? toTimeOfDay() {
    final parts = split(':');
    if (parts.length != 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    return TimeOfDay(hour: hour, minute: minute);
  }
}

extension IntExtension on int {
  /// Converts weekday index (0-6) to weekday name abbreviation
  String toWeekdayAbbr() {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    if (this < 0 || this > 6) return '';
    return days[this];
  }

  /// Returns ordinal string (1st, 2nd, 3rd, etc.)
  String toOrdinal() {
    if (this >= 11 && this <= 13) {
      return '${this}th';
    }
    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }
}

extension ListExtension<T> on List<T> {
  /// Returns a random element from the list
  T? randomElement() {
    if (isEmpty) return null;
    return this[DateTime.now().millisecondsSinceEpoch % length];
  }
}
