import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/services/alarm_service.dart';
import '../../../../core/services/subscription_provider.dart';
import '../../domain/entities/alarm.dart';
import '../models/alarm_model.dart';

/// Provider for AlarmRepository
final alarmRepositoryProvider = Provider<AlarmRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final alarmService = ref.watch(alarmServiceProvider);
  final hasFullAccess = ref.watch(hasFullAccessProvider);
  return AlarmRepository(db, alarmService, hasFullAccess: hasFullAccess);
});

class AlarmSchedulingException implements Exception {
  final String message;
  final bool canOpenSettings;

  const AlarmSchedulingException(
    this.message, {
    this.canOpenSettings = false,
  });

  @override
  String toString() => message;
}

/// Repository for alarm CRUD operations and scheduling
class AlarmRepository {
  final AppDatabase _db;
  final AlarmService _alarmService;
  final bool _hasFullAccess;

  AlarmRepository(
    this._db,
    this._alarmService, {
    required bool hasFullAccess,
  }) : _hasFullAccess = hasFullAccess;

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
          await _scheduleOrThrow(createdAlarm);
        }
      } catch (e) {
        debugPrint('Alarm scheduling failed: $e');
        await _db.deleteAlarm(id);
        rethrow;
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
        await _scheduleOrThrow(updatedAlarm);
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
        await _scheduleOrThrow(alarm);
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

  /// Restore a previously deleted alarm, preserving its original ID.
  Future<bool> restoreAlarm(AlarmEntity alarm) async {
    if (alarm.id == null) return false;

    await _db.insertAlarm(alarm.toCompanion());

    if (alarm.isEnabled) {
      try {
        final restoredAlarm = await _db.getAlarmById(alarm.id!);
        if (restoredAlarm != null) {
          await _scheduleOrThrow(restoredAlarm);
        }
      } catch (e) {
        debugPrint('Alarm restore scheduling failed: $e');
        await _db.deleteAlarm(alarm.id!);
        rethrow;
      }
    }

    return true;
  }

  /// Reschedule all enabled alarms
  Future<void> rescheduleAllAlarms() async {
    final alarms = await _db.getEnabledAlarms();
    for (final alarm in alarms) {
      await _scheduleOrThrow(alarm);
    }
  }

  /// Stop a ringing alarm
  Future<bool> stopAlarm(int id) async {
    return _alarmService.stopAlarm(id, hasFullAccess: _hasFullAccess);
  }

  /// Snooze an alarm
  Future<bool> snoozeAlarm(int id, {int? durationMinutes}) async {
    return _alarmService.snoozeAlarm(id, durationMinutes: durationMinutes);
  }

  Future<void> _scheduleOrThrow(Alarm alarm) async {
    final hasPermissions = await _alarmService.hasRequiredPermissions();
    if (!hasPermissions) {
      final granted = await _alarmService.requestPermissions();
      if (!granted) {
        throw AlarmSchedulingException(
          Platform.isIOS
              ? '알림 권한이 꺼져 있어 알람을 예약하지 못했습니다. iPhone 설정에서 옥모닝 알림을 허용해 주세요.'
              : '알람 권한이 없어 알람을 예약하지 못했습니다. 알림과 정확한 알람 권한을 허용해 주세요.',
          canOpenSettings: true,
        );
      }
    }

    final scheduled = await _alarmService.setAlarm(
      alarm,
      hasFullAccess: _hasFullAccess,
    );
    if (!scheduled) {
      throw const AlarmSchedulingException(
        '알람 예약에 실패했습니다. 권한과 기기 설정을 확인해 주세요.',
      );
    }
  }
}
