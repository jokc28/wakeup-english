import 'dart:convert';
import 'dart:io';

import 'package:alarm/alarm.dart' as alarm_pkg;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/alarm_sounds.dart';
import '../constants/iap_constants.dart';
import '../database/app_database.dart';

/// Provider for AlarmService
final alarmServiceProvider = Provider<AlarmService>((ref) {
  return AlarmService(ref);
});

/// Critical service for managing alarm scheduling, background execution,
/// screen wake-up, and quiz lock integration.
class AlarmService {
  final Ref _ref;
  static bool _initialized = false;

  AlarmService(this._ref);

  /// Initialize the alarm service
  /// Must be called before any other method
  static Future<void> initialize() async {
    if (_initialized) return;

    await alarm_pkg.Alarm.init();
    _initialized = true;
  }

  /// Request all necessary permissions for alarm functionality
  Future<bool> requestPermissions() async {
    final permissions = <Permission>[
      Permission.notification,
      Permission.scheduleExactAlarm,
    ];

    if (Platform.isAndroid) {
      permissions.add(Permission.ignoreBatteryOptimizations);
    }

    final statuses = await permissions.request();

    // Check if critical permissions are granted
    final notificationGranted =
        statuses[Permission.notification]?.isGranted ?? false;
    final alarmGranted =
        statuses[Permission.scheduleExactAlarm]?.isGranted ?? true;

    return notificationGranted && alarmGranted;
  }

  /// Check if all required permissions are granted
  Future<bool> hasRequiredPermissions() async {
    final notification = await Permission.notification.isGranted;
    final exactAlarm = await Permission.scheduleExactAlarm.isGranted;

    // On iOS, scheduleExactAlarm may not be applicable
    if (Platform.isIOS) {
      return notification;
    }

    return notification && exactAlarm;
  }

  /// Validate sound path against subscription status.
  /// Falls back to default if premium sound is used without access.
  String _validateSoundPath(String soundPath, bool hasFullAccess) {
    if (hasFullAccess) return soundPath;
    final sound = AlarmSounds.getByPath(soundPath);
    if (sound == null || sound.isFree) return soundPath;
    return IapConstants.freeSoundPaths.first;
  }

  /// Schedule a new alarm
  /// Returns true if successful
  Future<bool> setAlarm(Alarm alarm, {bool hasFullAccess = false}) async {
    if (!_initialized) {
      throw StateError('AlarmService not initialized. Call initialize() first.');
    }

    // Calculate next fire time
    final nextFireTime = _calculateNextFireTime(
      TimeOfDay(hour: alarm.hour, minute: alarm.minute),
      _parseRepeatDays(alarm.repeatDays),
    );

    if (nextFireTime == null) {
      return false;
    }

    // Validate sound path against subscription
    final validatedSoundPath = _validateSoundPath(alarm.soundPath, hasFullAccess);

    // Create alarm settings
    final alarmSettings = alarm_pkg.AlarmSettings(
      id: alarm.id,
      dateTime: nextFireTime,
      assetAudioPath: validatedSoundPath,
      loopAudio: true,
      vibrate: alarm.vibrationEnabled,
      volume: alarm.volume / 100.0,
      fadeDuration: alarm.gradualVolume ? 30.0 : 0.0,
      warningNotificationOnKill: Platform.isIOS,
      androidFullScreenIntent: true,
      notificationSettings: alarm_pkg.NotificationSettings(
        title: alarm.label.isEmpty ? 'OK-Morning' : alarm.label,
        body: 'Time to wake up! Solve the quiz to dismiss.',
        stopButton: null, // No stop button - must solve quiz
        icon: 'notification_icon',
      ),
    );

    final success = await alarm_pkg.Alarm.set(alarmSettings: alarmSettings);

    if (success) {
      // Update next fire time in database
      final db = _ref.read(databaseProvider);
      await db.updateNextFireTime(alarm.id, nextFireTime);
    }

    return success;
  }

  /// Cancel an existing alarm
  Future<bool> cancelAlarm(int alarmId) async {
    if (!_initialized) {
      throw StateError('AlarmService not initialized. Call initialize() first.');
    }

    final success = await alarm_pkg.Alarm.stop(alarmId);

    if (success) {
      // Clear next fire time in database
      final db = _ref.read(databaseProvider);
      await db.updateNextFireTime(alarmId, null);
    }

    return success;
  }

  /// Get all currently scheduled alarms from the alarm package
  Future<List<alarm_pkg.AlarmSettings>> getActiveAlarms() async {
    return alarm_pkg.Alarm.getAlarms();
  }

  /// Check if a specific alarm is currently ringing
  Future<bool> isAlarmRinging(int alarmId) async {
    final ringing = await alarm_pkg.Alarm.getAlarms();
    return ringing.any((a) => a.id == alarmId);
  }

  /// Stop a ringing alarm (after quiz is solved)
  Future<bool> stopAlarm(int alarmId) async {
    final success = await alarm_pkg.Alarm.stop(alarmId);

    if (success) {
      // Check if this is a repeating alarm and reschedule
      final db = _ref.read(databaseProvider);
      final alarm = await db.getAlarmById(alarmId);

      if (alarm != null && alarm.isEnabled) {
        final repeatDays = _parseRepeatDays(alarm.repeatDays);
        if (repeatDays.isNotEmpty) {
          // Reschedule for next occurrence
          await setAlarm(alarm);
        } else {
          // One-time alarm - disable it
          await db.toggleAlarmEnabled(alarmId, false);
        }
      }
    }

    return success;
  }

  /// Snooze an alarm
  Future<bool> snoozeAlarm(int alarmId, {int? durationMinutes}) async {
    final db = _ref.read(databaseProvider);
    final alarm = await db.getAlarmById(alarmId);

    if (alarm == null) return false;

    final snoozeDuration = durationMinutes ?? alarm.snoozeDuration;
    if (snoozeDuration <= 0) return false;

    // Stop current alarm
    await alarm_pkg.Alarm.stop(alarmId);

    // Schedule snooze alarm
    final snoozeTime = DateTime.now().add(Duration(minutes: snoozeDuration));

    final alarmSettings = alarm_pkg.AlarmSettings(
      id: alarmId,
      dateTime: snoozeTime,
      assetAudioPath: alarm.soundPath,
      loopAudio: true,
      vibrate: alarm.vibrationEnabled,
      volume: alarm.volume / 100.0,
      fadeDuration: alarm.gradualVolume ? 30.0 : 0.0,
      warningNotificationOnKill: Platform.isIOS,
      androidFullScreenIntent: true,
      notificationSettings: alarm_pkg.NotificationSettings(
        title: 'Snoozed: ${alarm.label.isEmpty ? 'OK-Morning' : alarm.label}',
        body: 'Time to wake up! Solve the quiz to dismiss.',
        stopButton: null,
        icon: 'notification_icon',
      ),
    );

    return alarm_pkg.Alarm.set(alarmSettings: alarmSettings);
  }

  /// Handle alarm ring event
  /// This should be called from the alarm callback to trigger quiz screen
  Future<void> handleAlarmRing(int alarmId) async {
    final db = _ref.read(databaseProvider);

    // Record alarm trigger in history
    await db.recordAlarmTrigger(alarmId);

    // The quiz lock screen navigation should be handled by the UI layer
    // listening to the alarm stream
  }

  /// Get the stream of ringing alarms
  Stream<alarm_pkg.AlarmSettings> get onAlarmRing => alarm_pkg.Alarm.ringStream.stream;

  /// Reschedule all enabled alarms
  /// Useful after app restart or timezone change
  Future<void> rescheduleAllAlarms() async {
    final db = _ref.read(databaseProvider);
    final enabledAlarms = await db.getEnabledAlarms();

    for (final alarm in enabledAlarms) {
      await setAlarm(alarm);
    }
  }

  /// Calculate the next fire time for an alarm
  DateTime? _calculateNextFireTime(
    TimeOfDay time,
    List<int> repeatDays,
  ) {
    final now = DateTime.now();
    var alarmDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (repeatDays.isEmpty) {
      // One-time alarm
      if (alarmDateTime.isBefore(now)) {
        alarmDateTime = alarmDateTime.add(const Duration(days: 1));
      }
      return alarmDateTime;
    }

    // Repeating alarm - find next valid day
    for (var i = 0; i < 7; i++) {
      final checkDate = alarmDateTime.add(Duration(days: i));
      final weekday = checkDate.weekday - 1; // Convert to 0-6 (Mon-Sun)

      if (repeatDays.contains(weekday)) {
        if (i == 0 && checkDate.isBefore(now)) {
          // Today but already passed, continue to next day
          continue;
        }
        return checkDate;
      }
    }

    return null;
  }

  /// Parse repeat days JSON string to list of integers
  List<int> _parseRepeatDays(String repeatDaysJson) {
    try {
      final decoded = jsonDecode(repeatDaysJson) as List<dynamic>;
      return decoded.cast<int>();
    } catch (e) {
      return [];
    }
  }
}
