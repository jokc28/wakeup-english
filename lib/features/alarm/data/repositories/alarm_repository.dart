import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/services/alarm_service.dart';
import '../../domain/entities/alarm.dart';
import '../models/alarm_model.dart';

/// Provider for AlarmRepository
final alarmRepositoryProvider = Provider<AlarmRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final alarmService = ref.watch(alarmServiceProvider);
  return AlarmRepository(db, alarmService);
});

/// Repository for alarm CRUD operations and scheduling
class AlarmRepository {
  final AppDatabase _db;
  final AlarmService _alarmService;

  AlarmRepository(this._db, this._alarmService);

  /// Get all alarms as domain entities
  Future<List<AlarmEntity>> getAllAlarms() async {
    final alarms = await _db.getAllAlarms();
    return alarms.map((a) => a.toEntity()).toList();
  }

  /// Get enabled alarms only
  Future<List<AlarmEntity>> getEnabledAlarms() async {
    final alarms = await _db.getEnabledAlarms();
    return alarms.map((a) => a.toEntity()).toList();
  }

  /// Get a single alarm by ID
  Future<AlarmEntity?> getAlarmById(int id) async {
    final alarm = await _db.getAlarmById(id);
    return alarm?.toEntity();
  }

  /// Watch all alarms as a stream
  Stream<List<AlarmEntity>> watchAllAlarms() {
    return _db.watchAllAlarms().map(
          (alarms) => alarms.map((a) => a.toEntity()).toList(),
        );
  }

  /// Watch enabled alarms as a stream
  Stream<List<AlarmEntity>> watchEnabledAlarms() {
    return _db.watchEnabledAlarms().map(
          (alarms) => alarms.map((a) => a.toEntity()).toList(),
        );
  }

  /// Create a new alarm
  /// Returns the created alarm's ID
  Future<int> createAlarm(AlarmEntity alarm) async {
    final id = await _db.insertAlarm(alarm.toInsertCompanion());

    // Schedule the alarm if enabled
    if (alarm.isEnabled) {
      try {
        final createdAlarm = await _db.getAlarmById(id);
        if (createdAlarm != null) {
          await _alarmService.setAlarm(createdAlarm);
        }
      } catch (e) {
        // Alarm is saved in DB; scheduling can be retried later
        debugPrint('Alarm scheduling failed: $e');
      }
    }

    return id;
  }

  /// Update an existing alarm
  Future<bool> updateAlarm(AlarmEntity alarm) async {
    if (alarm.id == null) return false;

    await _db.updateAlarmFields(alarm.id!, alarm.toCompanion());

    // Reschedule the alarm
    final updatedAlarm = await _db.getAlarmById(alarm.id!);
    if (updatedAlarm != null) {
      if (alarm.isEnabled) {
        await _alarmService.setAlarm(updatedAlarm);
      } else {
        await _alarmService.cancelAlarm(alarm.id!);
      }
    }

    return true;
  }

  /// Toggle alarm enabled state
  Future<bool> toggleAlarmEnabled(int id, bool enabled) async {
    await _db.toggleAlarmEnabled(id, enabled);

    if (enabled) {
      final alarm = await _db.getAlarmById(id);
      if (alarm != null) {
        await _alarmService.setAlarm(alarm);
      }
    } else {
      await _alarmService.cancelAlarm(id);
    }

    return true;
  }

  /// Delete an alarm
  Future<bool> deleteAlarm(int id) async {
    // Cancel scheduled alarm first
    await _alarmService.cancelAlarm(id);

    final result = await _db.deleteAlarm(id);
    return result > 0;
  }

  /// Reschedule all enabled alarms
  Future<void> rescheduleAllAlarms() async {
    await _alarmService.rescheduleAllAlarms();
  }

  /// Stop a ringing alarm
  Future<bool> stopAlarm(int id) async {
    return _alarmService.stopAlarm(id);
  }

  /// Snooze an alarm
  Future<bool> snoozeAlarm(int id, {int? durationMinutes}) async {
    return _alarmService.snoozeAlarm(id, durationMinutes: durationMinutes);
  }
}
