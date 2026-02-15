// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AlarmsTable extends Alarms with TableInfo<$AlarmsTable, Alarm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _hourMeta = const VerificationMeta('hour');
  @override
  late final GeneratedColumn<int> hour = GeneratedColumn<int>(
      'hour', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _minuteMeta = const VerificationMeta('minute');
  @override
  late final GeneratedColumn<int> minute = GeneratedColumn<int>(
      'minute', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isEnabledMeta =
      const VerificationMeta('isEnabled');
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
      'is_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _repeatDaysMeta =
      const VerificationMeta('repeatDays');
  @override
  late final GeneratedColumn<String> repeatDays = GeneratedColumn<String>(
      'repeat_days', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _quizDifficultyMeta =
      const VerificationMeta('quizDifficulty');
  @override
  late final GeneratedColumn<String> quizDifficulty = GeneratedColumn<String>(
      'quiz_difficulty', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('medium'));
  static const VerificationMeta _quizCountMeta =
      const VerificationMeta('quizCount');
  @override
  late final GeneratedColumn<int> quizCount = GeneratedColumn<int>(
      'quiz_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  static const VerificationMeta _soundPathMeta =
      const VerificationMeta('soundPath');
  @override
  late final GeneratedColumn<String> soundPath = GeneratedColumn<String>(
      'sound_path', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('assets/sounds/default_alarm.mp3'));
  static const VerificationMeta _vibrationEnabledMeta =
      const VerificationMeta('vibrationEnabled');
  @override
  late final GeneratedColumn<bool> vibrationEnabled = GeneratedColumn<bool>(
      'vibration_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("vibration_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _snoozeDurationMeta =
      const VerificationMeta('snoozeDuration');
  @override
  late final GeneratedColumn<int> snoozeDuration = GeneratedColumn<int>(
      'snooze_duration', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(5));
  static const VerificationMeta _maxSnoozesMeta =
      const VerificationMeta('maxSnoozes');
  @override
  late final GeneratedColumn<int> maxSnoozes = GeneratedColumn<int>(
      'max_snoozes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  static const VerificationMeta _volumeMeta = const VerificationMeta('volume');
  @override
  late final GeneratedColumn<int> volume = GeneratedColumn<int>(
      'volume', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(100));
  static const VerificationMeta _gradualVolumeMeta =
      const VerificationMeta('gradualVolume');
  @override
  late final GeneratedColumn<bool> gradualVolume = GeneratedColumn<bool>(
      'gradual_volume', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("gradual_volume" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _nextFireTimeMeta =
      const VerificationMeta('nextFireTime');
  @override
  late final GeneratedColumn<DateTime> nextFireTime = GeneratedColumn<DateTime>(
      'next_fire_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        label,
        hour,
        minute,
        isEnabled,
        repeatDays,
        quizDifficulty,
        quizCount,
        soundPath,
        vibrationEnabled,
        snoozeDuration,
        maxSnoozes,
        volume,
        gradualVolume,
        createdAt,
        updatedAt,
        nextFireTime
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarms';
  @override
  VerificationContext validateIntegrity(Insertable<Alarm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    }
    if (data.containsKey('hour')) {
      context.handle(
          _hourMeta, hour.isAcceptableOrUnknown(data['hour']!, _hourMeta));
    } else if (isInserting) {
      context.missing(_hourMeta);
    }
    if (data.containsKey('minute')) {
      context.handle(_minuteMeta,
          minute.isAcceptableOrUnknown(data['minute']!, _minuteMeta));
    } else if (isInserting) {
      context.missing(_minuteMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(_isEnabledMeta,
          isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta));
    }
    if (data.containsKey('repeat_days')) {
      context.handle(
          _repeatDaysMeta,
          repeatDays.isAcceptableOrUnknown(
              data['repeat_days']!, _repeatDaysMeta));
    }
    if (data.containsKey('quiz_difficulty')) {
      context.handle(
          _quizDifficultyMeta,
          quizDifficulty.isAcceptableOrUnknown(
              data['quiz_difficulty']!, _quizDifficultyMeta));
    }
    if (data.containsKey('quiz_count')) {
      context.handle(_quizCountMeta,
          quizCount.isAcceptableOrUnknown(data['quiz_count']!, _quizCountMeta));
    }
    if (data.containsKey('sound_path')) {
      context.handle(_soundPathMeta,
          soundPath.isAcceptableOrUnknown(data['sound_path']!, _soundPathMeta));
    }
    if (data.containsKey('vibration_enabled')) {
      context.handle(
          _vibrationEnabledMeta,
          vibrationEnabled.isAcceptableOrUnknown(
              data['vibration_enabled']!, _vibrationEnabledMeta));
    }
    if (data.containsKey('snooze_duration')) {
      context.handle(
          _snoozeDurationMeta,
          snoozeDuration.isAcceptableOrUnknown(
              data['snooze_duration']!, _snoozeDurationMeta));
    }
    if (data.containsKey('max_snoozes')) {
      context.handle(
          _maxSnoozesMeta,
          maxSnoozes.isAcceptableOrUnknown(
              data['max_snoozes']!, _maxSnoozesMeta));
    }
    if (data.containsKey('volume')) {
      context.handle(_volumeMeta,
          volume.isAcceptableOrUnknown(data['volume']!, _volumeMeta));
    }
    if (data.containsKey('gradual_volume')) {
      context.handle(
          _gradualVolumeMeta,
          gradualVolume.isAcceptableOrUnknown(
              data['gradual_volume']!, _gradualVolumeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('next_fire_time')) {
      context.handle(
          _nextFireTimeMeta,
          nextFireTime.isAcceptableOrUnknown(
              data['next_fire_time']!, _nextFireTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Alarm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Alarm(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      hour: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hour'])!,
      minute: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}minute'])!,
      isEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_enabled'])!,
      repeatDays: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}repeat_days'])!,
      quizDifficulty: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}quiz_difficulty'])!,
      quizCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quiz_count'])!,
      soundPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sound_path'])!,
      vibrationEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}vibration_enabled'])!,
      snoozeDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}snooze_duration'])!,
      maxSnoozes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_snoozes'])!,
      volume: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}volume'])!,
      gradualVolume: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}gradual_volume'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      nextFireTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}next_fire_time']),
    );
  }

  @override
  $AlarmsTable createAlias(String alias) {
    return $AlarmsTable(attachedDatabase, alias);
  }
}

class Alarm extends DataClass implements Insertable<Alarm> {
  /// Unique identifier for the alarm
  final int id;

  /// Display label for the alarm
  final String label;

  /// Hour of the alarm (0-23)
  final int hour;

  /// Minute of the alarm (0-59)
  final int minute;

  /// Whether the alarm is enabled
  final bool isEnabled;

  /// Days of week to repeat (stored as JSON array, e.g., [0,1,2,3,4] for Mon-Fri)
  /// Empty array means one-time alarm
  final String repeatDays;

  /// Quiz difficulty level: 'easy', 'medium', 'hard'
  final String quizDifficulty;

  /// Number of quiz questions to solve
  final int quizCount;

  /// Sound file path or asset name
  final String soundPath;

  /// Whether vibration is enabled
  final bool vibrationEnabled;

  /// Snooze duration in minutes (0 = snooze disabled)
  final int snoozeDuration;

  /// Maximum number of snoozes allowed
  final int maxSnoozes;

  /// Volume level (0.0 - 1.0, stored as int 0-100)
  final int volume;

  /// Whether to gradually increase volume
  final bool gradualVolume;

  /// Created timestamp
  final DateTime createdAt;

  /// Last modified timestamp
  final DateTime updatedAt;

  /// Next scheduled fire time (null if not scheduled)
  final DateTime? nextFireTime;
  const Alarm(
      {required this.id,
      required this.label,
      required this.hour,
      required this.minute,
      required this.isEnabled,
      required this.repeatDays,
      required this.quizDifficulty,
      required this.quizCount,
      required this.soundPath,
      required this.vibrationEnabled,
      required this.snoozeDuration,
      required this.maxSnoozes,
      required this.volume,
      required this.gradualVolume,
      required this.createdAt,
      required this.updatedAt,
      this.nextFireTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['label'] = Variable<String>(label);
    map['hour'] = Variable<int>(hour);
    map['minute'] = Variable<int>(minute);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['repeat_days'] = Variable<String>(repeatDays);
    map['quiz_difficulty'] = Variable<String>(quizDifficulty);
    map['quiz_count'] = Variable<int>(quizCount);
    map['sound_path'] = Variable<String>(soundPath);
    map['vibration_enabled'] = Variable<bool>(vibrationEnabled);
    map['snooze_duration'] = Variable<int>(snoozeDuration);
    map['max_snoozes'] = Variable<int>(maxSnoozes);
    map['volume'] = Variable<int>(volume);
    map['gradual_volume'] = Variable<bool>(gradualVolume);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || nextFireTime != null) {
      map['next_fire_time'] = Variable<DateTime>(nextFireTime);
    }
    return map;
  }

  AlarmsCompanion toCompanion(bool nullToAbsent) {
    return AlarmsCompanion(
      id: Value(id),
      label: Value(label),
      hour: Value(hour),
      minute: Value(minute),
      isEnabled: Value(isEnabled),
      repeatDays: Value(repeatDays),
      quizDifficulty: Value(quizDifficulty),
      quizCount: Value(quizCount),
      soundPath: Value(soundPath),
      vibrationEnabled: Value(vibrationEnabled),
      snoozeDuration: Value(snoozeDuration),
      maxSnoozes: Value(maxSnoozes),
      volume: Value(volume),
      gradualVolume: Value(gradualVolume),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      nextFireTime: nextFireTime == null && nullToAbsent
          ? const Value.absent()
          : Value(nextFireTime),
    );
  }

  factory Alarm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Alarm(
      id: serializer.fromJson<int>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      hour: serializer.fromJson<int>(json['hour']),
      minute: serializer.fromJson<int>(json['minute']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      repeatDays: serializer.fromJson<String>(json['repeatDays']),
      quizDifficulty: serializer.fromJson<String>(json['quizDifficulty']),
      quizCount: serializer.fromJson<int>(json['quizCount']),
      soundPath: serializer.fromJson<String>(json['soundPath']),
      vibrationEnabled: serializer.fromJson<bool>(json['vibrationEnabled']),
      snoozeDuration: serializer.fromJson<int>(json['snoozeDuration']),
      maxSnoozes: serializer.fromJson<int>(json['maxSnoozes']),
      volume: serializer.fromJson<int>(json['volume']),
      gradualVolume: serializer.fromJson<bool>(json['gradualVolume']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      nextFireTime: serializer.fromJson<DateTime?>(json['nextFireTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'label': serializer.toJson<String>(label),
      'hour': serializer.toJson<int>(hour),
      'minute': serializer.toJson<int>(minute),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'repeatDays': serializer.toJson<String>(repeatDays),
      'quizDifficulty': serializer.toJson<String>(quizDifficulty),
      'quizCount': serializer.toJson<int>(quizCount),
      'soundPath': serializer.toJson<String>(soundPath),
      'vibrationEnabled': serializer.toJson<bool>(vibrationEnabled),
      'snoozeDuration': serializer.toJson<int>(snoozeDuration),
      'maxSnoozes': serializer.toJson<int>(maxSnoozes),
      'volume': serializer.toJson<int>(volume),
      'gradualVolume': serializer.toJson<bool>(gradualVolume),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'nextFireTime': serializer.toJson<DateTime?>(nextFireTime),
    };
  }

  Alarm copyWith(
          {int? id,
          String? label,
          int? hour,
          int? minute,
          bool? isEnabled,
          String? repeatDays,
          String? quizDifficulty,
          int? quizCount,
          String? soundPath,
          bool? vibrationEnabled,
          int? snoozeDuration,
          int? maxSnoozes,
          int? volume,
          bool? gradualVolume,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> nextFireTime = const Value.absent()}) =>
      Alarm(
        id: id ?? this.id,
        label: label ?? this.label,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
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
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        nextFireTime:
            nextFireTime.present ? nextFireTime.value : this.nextFireTime,
      );
  Alarm copyWithCompanion(AlarmsCompanion data) {
    return Alarm(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      hour: data.hour.present ? data.hour.value : this.hour,
      minute: data.minute.present ? data.minute.value : this.minute,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      repeatDays:
          data.repeatDays.present ? data.repeatDays.value : this.repeatDays,
      quizDifficulty: data.quizDifficulty.present
          ? data.quizDifficulty.value
          : this.quizDifficulty,
      quizCount: data.quizCount.present ? data.quizCount.value : this.quizCount,
      soundPath: data.soundPath.present ? data.soundPath.value : this.soundPath,
      vibrationEnabled: data.vibrationEnabled.present
          ? data.vibrationEnabled.value
          : this.vibrationEnabled,
      snoozeDuration: data.snoozeDuration.present
          ? data.snoozeDuration.value
          : this.snoozeDuration,
      maxSnoozes:
          data.maxSnoozes.present ? data.maxSnoozes.value : this.maxSnoozes,
      volume: data.volume.present ? data.volume.value : this.volume,
      gradualVolume: data.gradualVolume.present
          ? data.gradualVolume.value
          : this.gradualVolume,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      nextFireTime: data.nextFireTime.present
          ? data.nextFireTime.value
          : this.nextFireTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Alarm(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('repeatDays: $repeatDays, ')
          ..write('quizDifficulty: $quizDifficulty, ')
          ..write('quizCount: $quizCount, ')
          ..write('soundPath: $soundPath, ')
          ..write('vibrationEnabled: $vibrationEnabled, ')
          ..write('snoozeDuration: $snoozeDuration, ')
          ..write('maxSnoozes: $maxSnoozes, ')
          ..write('volume: $volume, ')
          ..write('gradualVolume: $gradualVolume, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('nextFireTime: $nextFireTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      label,
      hour,
      minute,
      isEnabled,
      repeatDays,
      quizDifficulty,
      quizCount,
      soundPath,
      vibrationEnabled,
      snoozeDuration,
      maxSnoozes,
      volume,
      gradualVolume,
      createdAt,
      updatedAt,
      nextFireTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Alarm &&
          other.id == this.id &&
          other.label == this.label &&
          other.hour == this.hour &&
          other.minute == this.minute &&
          other.isEnabled == this.isEnabled &&
          other.repeatDays == this.repeatDays &&
          other.quizDifficulty == this.quizDifficulty &&
          other.quizCount == this.quizCount &&
          other.soundPath == this.soundPath &&
          other.vibrationEnabled == this.vibrationEnabled &&
          other.snoozeDuration == this.snoozeDuration &&
          other.maxSnoozes == this.maxSnoozes &&
          other.volume == this.volume &&
          other.gradualVolume == this.gradualVolume &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.nextFireTime == this.nextFireTime);
}

class AlarmsCompanion extends UpdateCompanion<Alarm> {
  final Value<int> id;
  final Value<String> label;
  final Value<int> hour;
  final Value<int> minute;
  final Value<bool> isEnabled;
  final Value<String> repeatDays;
  final Value<String> quizDifficulty;
  final Value<int> quizCount;
  final Value<String> soundPath;
  final Value<bool> vibrationEnabled;
  final Value<int> snoozeDuration;
  final Value<int> maxSnoozes;
  final Value<int> volume;
  final Value<bool> gradualVolume;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> nextFireTime;
  const AlarmsCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.hour = const Value.absent(),
    this.minute = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.repeatDays = const Value.absent(),
    this.quizDifficulty = const Value.absent(),
    this.quizCount = const Value.absent(),
    this.soundPath = const Value.absent(),
    this.vibrationEnabled = const Value.absent(),
    this.snoozeDuration = const Value.absent(),
    this.maxSnoozes = const Value.absent(),
    this.volume = const Value.absent(),
    this.gradualVolume = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.nextFireTime = const Value.absent(),
  });
  AlarmsCompanion.insert({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    required int hour,
    required int minute,
    this.isEnabled = const Value.absent(),
    this.repeatDays = const Value.absent(),
    this.quizDifficulty = const Value.absent(),
    this.quizCount = const Value.absent(),
    this.soundPath = const Value.absent(),
    this.vibrationEnabled = const Value.absent(),
    this.snoozeDuration = const Value.absent(),
    this.maxSnoozes = const Value.absent(),
    this.volume = const Value.absent(),
    this.gradualVolume = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.nextFireTime = const Value.absent(),
  })  : hour = Value(hour),
        minute = Value(minute);
  static Insertable<Alarm> custom({
    Expression<int>? id,
    Expression<String>? label,
    Expression<int>? hour,
    Expression<int>? minute,
    Expression<bool>? isEnabled,
    Expression<String>? repeatDays,
    Expression<String>? quizDifficulty,
    Expression<int>? quizCount,
    Expression<String>? soundPath,
    Expression<bool>? vibrationEnabled,
    Expression<int>? snoozeDuration,
    Expression<int>? maxSnoozes,
    Expression<int>? volume,
    Expression<bool>? gradualVolume,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? nextFireTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (hour != null) 'hour': hour,
      if (minute != null) 'minute': minute,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (repeatDays != null) 'repeat_days': repeatDays,
      if (quizDifficulty != null) 'quiz_difficulty': quizDifficulty,
      if (quizCount != null) 'quiz_count': quizCount,
      if (soundPath != null) 'sound_path': soundPath,
      if (vibrationEnabled != null) 'vibration_enabled': vibrationEnabled,
      if (snoozeDuration != null) 'snooze_duration': snoozeDuration,
      if (maxSnoozes != null) 'max_snoozes': maxSnoozes,
      if (volume != null) 'volume': volume,
      if (gradualVolume != null) 'gradual_volume': gradualVolume,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (nextFireTime != null) 'next_fire_time': nextFireTime,
    });
  }

  AlarmsCompanion copyWith(
      {Value<int>? id,
      Value<String>? label,
      Value<int>? hour,
      Value<int>? minute,
      Value<bool>? isEnabled,
      Value<String>? repeatDays,
      Value<String>? quizDifficulty,
      Value<int>? quizCount,
      Value<String>? soundPath,
      Value<bool>? vibrationEnabled,
      Value<int>? snoozeDuration,
      Value<int>? maxSnoozes,
      Value<int>? volume,
      Value<bool>? gradualVolume,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? nextFireTime}) {
    return AlarmsCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
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
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      nextFireTime: nextFireTime ?? this.nextFireTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (hour.present) {
      map['hour'] = Variable<int>(hour.value);
    }
    if (minute.present) {
      map['minute'] = Variable<int>(minute.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (repeatDays.present) {
      map['repeat_days'] = Variable<String>(repeatDays.value);
    }
    if (quizDifficulty.present) {
      map['quiz_difficulty'] = Variable<String>(quizDifficulty.value);
    }
    if (quizCount.present) {
      map['quiz_count'] = Variable<int>(quizCount.value);
    }
    if (soundPath.present) {
      map['sound_path'] = Variable<String>(soundPath.value);
    }
    if (vibrationEnabled.present) {
      map['vibration_enabled'] = Variable<bool>(vibrationEnabled.value);
    }
    if (snoozeDuration.present) {
      map['snooze_duration'] = Variable<int>(snoozeDuration.value);
    }
    if (maxSnoozes.present) {
      map['max_snoozes'] = Variable<int>(maxSnoozes.value);
    }
    if (volume.present) {
      map['volume'] = Variable<int>(volume.value);
    }
    if (gradualVolume.present) {
      map['gradual_volume'] = Variable<bool>(gradualVolume.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (nextFireTime.present) {
      map['next_fire_time'] = Variable<DateTime>(nextFireTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmsCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('repeatDays: $repeatDays, ')
          ..write('quizDifficulty: $quizDifficulty, ')
          ..write('quizCount: $quizCount, ')
          ..write('soundPath: $soundPath, ')
          ..write('vibrationEnabled: $vibrationEnabled, ')
          ..write('snoozeDuration: $snoozeDuration, ')
          ..write('maxSnoozes: $maxSnoozes, ')
          ..write('volume: $volume, ')
          ..write('gradualVolume: $gradualVolume, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('nextFireTime: $nextFireTime')
          ..write(')'))
        .toString();
  }
}

class $QuizProgressTable extends QuizProgress
    with TableInfo<$QuizProgressTable, QuizProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuizProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
      'question_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timesShownMeta =
      const VerificationMeta('timesShown');
  @override
  late final GeneratedColumn<int> timesShown = GeneratedColumn<int>(
      'times_shown', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _timesCorrectMeta =
      const VerificationMeta('timesCorrect');
  @override
  late final GeneratedColumn<int> timesCorrect = GeneratedColumn<int>(
      'times_correct', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _timesIncorrectMeta =
      const VerificationMeta('timesIncorrect');
  @override
  late final GeneratedColumn<int> timesIncorrect = GeneratedColumn<int>(
      'times_incorrect', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastShownAtMeta =
      const VerificationMeta('lastShownAt');
  @override
  late final GeneratedColumn<DateTime> lastShownAt = GeneratedColumn<DateTime>(
      'last_shown_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _avgResponseTimeMsMeta =
      const VerificationMeta('avgResponseTimeMs');
  @override
  late final GeneratedColumn<int> avgResponseTimeMs = GeneratedColumn<int>(
      'avg_response_time_ms', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _performanceRatingMeta =
      const VerificationMeta('performanceRating');
  @override
  late final GeneratedColumn<int> performanceRating = GeneratedColumn<int>(
      'performance_rating', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(50));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        questionId,
        timesShown,
        timesCorrect,
        timesIncorrect,
        lastShownAt,
        avgResponseTimeMs,
        performanceRating
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quiz_progress';
  @override
  VerificationContext validateIntegrity(Insertable<QuizProgressData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('question_id')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['question_id']!, _questionIdMeta));
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('times_shown')) {
      context.handle(
          _timesShownMeta,
          timesShown.isAcceptableOrUnknown(
              data['times_shown']!, _timesShownMeta));
    }
    if (data.containsKey('times_correct')) {
      context.handle(
          _timesCorrectMeta,
          timesCorrect.isAcceptableOrUnknown(
              data['times_correct']!, _timesCorrectMeta));
    }
    if (data.containsKey('times_incorrect')) {
      context.handle(
          _timesIncorrectMeta,
          timesIncorrect.isAcceptableOrUnknown(
              data['times_incorrect']!, _timesIncorrectMeta));
    }
    if (data.containsKey('last_shown_at')) {
      context.handle(
          _lastShownAtMeta,
          lastShownAt.isAcceptableOrUnknown(
              data['last_shown_at']!, _lastShownAtMeta));
    }
    if (data.containsKey('avg_response_time_ms')) {
      context.handle(
          _avgResponseTimeMsMeta,
          avgResponseTimeMs.isAcceptableOrUnknown(
              data['avg_response_time_ms']!, _avgResponseTimeMsMeta));
    }
    if (data.containsKey('performance_rating')) {
      context.handle(
          _performanceRatingMeta,
          performanceRating.isAcceptableOrUnknown(
              data['performance_rating']!, _performanceRatingMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuizProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuizProgressData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_id'])!,
      timesShown: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}times_shown'])!,
      timesCorrect: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}times_correct'])!,
      timesIncorrect: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}times_incorrect'])!,
      lastShownAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_shown_at']),
      avgResponseTimeMs: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}avg_response_time_ms'])!,
      performanceRating: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}performance_rating'])!,
    );
  }

  @override
  $QuizProgressTable createAlias(String alias) {
    return $QuizProgressTable(attachedDatabase, alias);
  }
}

class QuizProgressData extends DataClass
    implements Insertable<QuizProgressData> {
  /// Unique identifier
  final int id;

  /// Question identifier from quiz_questions.json
  final String questionId;

  /// Number of times this question was shown
  final int timesShown;

  /// Number of times answered correctly
  final int timesCorrect;

  /// Number of times answered incorrectly
  final int timesIncorrect;

  /// Last time this question was shown
  final DateTime? lastShownAt;

  /// Average response time in milliseconds
  final int avgResponseTimeMs;

  /// Difficulty rating based on user performance (0.0-1.0, stored as 0-100)
  final int performanceRating;
  const QuizProgressData(
      {required this.id,
      required this.questionId,
      required this.timesShown,
      required this.timesCorrect,
      required this.timesIncorrect,
      this.lastShownAt,
      required this.avgResponseTimeMs,
      required this.performanceRating});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['question_id'] = Variable<String>(questionId);
    map['times_shown'] = Variable<int>(timesShown);
    map['times_correct'] = Variable<int>(timesCorrect);
    map['times_incorrect'] = Variable<int>(timesIncorrect);
    if (!nullToAbsent || lastShownAt != null) {
      map['last_shown_at'] = Variable<DateTime>(lastShownAt);
    }
    map['avg_response_time_ms'] = Variable<int>(avgResponseTimeMs);
    map['performance_rating'] = Variable<int>(performanceRating);
    return map;
  }

  QuizProgressCompanion toCompanion(bool nullToAbsent) {
    return QuizProgressCompanion(
      id: Value(id),
      questionId: Value(questionId),
      timesShown: Value(timesShown),
      timesCorrect: Value(timesCorrect),
      timesIncorrect: Value(timesIncorrect),
      lastShownAt: lastShownAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastShownAt),
      avgResponseTimeMs: Value(avgResponseTimeMs),
      performanceRating: Value(performanceRating),
    );
  }

  factory QuizProgressData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuizProgressData(
      id: serializer.fromJson<int>(json['id']),
      questionId: serializer.fromJson<String>(json['questionId']),
      timesShown: serializer.fromJson<int>(json['timesShown']),
      timesCorrect: serializer.fromJson<int>(json['timesCorrect']),
      timesIncorrect: serializer.fromJson<int>(json['timesIncorrect']),
      lastShownAt: serializer.fromJson<DateTime?>(json['lastShownAt']),
      avgResponseTimeMs: serializer.fromJson<int>(json['avgResponseTimeMs']),
      performanceRating: serializer.fromJson<int>(json['performanceRating']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'questionId': serializer.toJson<String>(questionId),
      'timesShown': serializer.toJson<int>(timesShown),
      'timesCorrect': serializer.toJson<int>(timesCorrect),
      'timesIncorrect': serializer.toJson<int>(timesIncorrect),
      'lastShownAt': serializer.toJson<DateTime?>(lastShownAt),
      'avgResponseTimeMs': serializer.toJson<int>(avgResponseTimeMs),
      'performanceRating': serializer.toJson<int>(performanceRating),
    };
  }

  QuizProgressData copyWith(
          {int? id,
          String? questionId,
          int? timesShown,
          int? timesCorrect,
          int? timesIncorrect,
          Value<DateTime?> lastShownAt = const Value.absent(),
          int? avgResponseTimeMs,
          int? performanceRating}) =>
      QuizProgressData(
        id: id ?? this.id,
        questionId: questionId ?? this.questionId,
        timesShown: timesShown ?? this.timesShown,
        timesCorrect: timesCorrect ?? this.timesCorrect,
        timesIncorrect: timesIncorrect ?? this.timesIncorrect,
        lastShownAt: lastShownAt.present ? lastShownAt.value : this.lastShownAt,
        avgResponseTimeMs: avgResponseTimeMs ?? this.avgResponseTimeMs,
        performanceRating: performanceRating ?? this.performanceRating,
      );
  QuizProgressData copyWithCompanion(QuizProgressCompanion data) {
    return QuizProgressData(
      id: data.id.present ? data.id.value : this.id,
      questionId:
          data.questionId.present ? data.questionId.value : this.questionId,
      timesShown:
          data.timesShown.present ? data.timesShown.value : this.timesShown,
      timesCorrect: data.timesCorrect.present
          ? data.timesCorrect.value
          : this.timesCorrect,
      timesIncorrect: data.timesIncorrect.present
          ? data.timesIncorrect.value
          : this.timesIncorrect,
      lastShownAt:
          data.lastShownAt.present ? data.lastShownAt.value : this.lastShownAt,
      avgResponseTimeMs: data.avgResponseTimeMs.present
          ? data.avgResponseTimeMs.value
          : this.avgResponseTimeMs,
      performanceRating: data.performanceRating.present
          ? data.performanceRating.value
          : this.performanceRating,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuizProgressData(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('timesShown: $timesShown, ')
          ..write('timesCorrect: $timesCorrect, ')
          ..write('timesIncorrect: $timesIncorrect, ')
          ..write('lastShownAt: $lastShownAt, ')
          ..write('avgResponseTimeMs: $avgResponseTimeMs, ')
          ..write('performanceRating: $performanceRating')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, questionId, timesShown, timesCorrect,
      timesIncorrect, lastShownAt, avgResponseTimeMs, performanceRating);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuizProgressData &&
          other.id == this.id &&
          other.questionId == this.questionId &&
          other.timesShown == this.timesShown &&
          other.timesCorrect == this.timesCorrect &&
          other.timesIncorrect == this.timesIncorrect &&
          other.lastShownAt == this.lastShownAt &&
          other.avgResponseTimeMs == this.avgResponseTimeMs &&
          other.performanceRating == this.performanceRating);
}

class QuizProgressCompanion extends UpdateCompanion<QuizProgressData> {
  final Value<int> id;
  final Value<String> questionId;
  final Value<int> timesShown;
  final Value<int> timesCorrect;
  final Value<int> timesIncorrect;
  final Value<DateTime?> lastShownAt;
  final Value<int> avgResponseTimeMs;
  final Value<int> performanceRating;
  const QuizProgressCompanion({
    this.id = const Value.absent(),
    this.questionId = const Value.absent(),
    this.timesShown = const Value.absent(),
    this.timesCorrect = const Value.absent(),
    this.timesIncorrect = const Value.absent(),
    this.lastShownAt = const Value.absent(),
    this.avgResponseTimeMs = const Value.absent(),
    this.performanceRating = const Value.absent(),
  });
  QuizProgressCompanion.insert({
    this.id = const Value.absent(),
    required String questionId,
    this.timesShown = const Value.absent(),
    this.timesCorrect = const Value.absent(),
    this.timesIncorrect = const Value.absent(),
    this.lastShownAt = const Value.absent(),
    this.avgResponseTimeMs = const Value.absent(),
    this.performanceRating = const Value.absent(),
  }) : questionId = Value(questionId);
  static Insertable<QuizProgressData> custom({
    Expression<int>? id,
    Expression<String>? questionId,
    Expression<int>? timesShown,
    Expression<int>? timesCorrect,
    Expression<int>? timesIncorrect,
    Expression<DateTime>? lastShownAt,
    Expression<int>? avgResponseTimeMs,
    Expression<int>? performanceRating,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionId != null) 'question_id': questionId,
      if (timesShown != null) 'times_shown': timesShown,
      if (timesCorrect != null) 'times_correct': timesCorrect,
      if (timesIncorrect != null) 'times_incorrect': timesIncorrect,
      if (lastShownAt != null) 'last_shown_at': lastShownAt,
      if (avgResponseTimeMs != null) 'avg_response_time_ms': avgResponseTimeMs,
      if (performanceRating != null) 'performance_rating': performanceRating,
    });
  }

  QuizProgressCompanion copyWith(
      {Value<int>? id,
      Value<String>? questionId,
      Value<int>? timesShown,
      Value<int>? timesCorrect,
      Value<int>? timesIncorrect,
      Value<DateTime?>? lastShownAt,
      Value<int>? avgResponseTimeMs,
      Value<int>? performanceRating}) {
    return QuizProgressCompanion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      timesShown: timesShown ?? this.timesShown,
      timesCorrect: timesCorrect ?? this.timesCorrect,
      timesIncorrect: timesIncorrect ?? this.timesIncorrect,
      lastShownAt: lastShownAt ?? this.lastShownAt,
      avgResponseTimeMs: avgResponseTimeMs ?? this.avgResponseTimeMs,
      performanceRating: performanceRating ?? this.performanceRating,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (timesShown.present) {
      map['times_shown'] = Variable<int>(timesShown.value);
    }
    if (timesCorrect.present) {
      map['times_correct'] = Variable<int>(timesCorrect.value);
    }
    if (timesIncorrect.present) {
      map['times_incorrect'] = Variable<int>(timesIncorrect.value);
    }
    if (lastShownAt.present) {
      map['last_shown_at'] = Variable<DateTime>(lastShownAt.value);
    }
    if (avgResponseTimeMs.present) {
      map['avg_response_time_ms'] = Variable<int>(avgResponseTimeMs.value);
    }
    if (performanceRating.present) {
      map['performance_rating'] = Variable<int>(performanceRating.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuizProgressCompanion(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('timesShown: $timesShown, ')
          ..write('timesCorrect: $timesCorrect, ')
          ..write('timesIncorrect: $timesIncorrect, ')
          ..write('lastShownAt: $lastShownAt, ')
          ..write('avgResponseTimeMs: $avgResponseTimeMs, ')
          ..write('performanceRating: $performanceRating')
          ..write(')'))
        .toString();
  }
}

class $AlarmHistoryTable extends AlarmHistory
    with TableInfo<$AlarmHistoryTable, AlarmHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _alarmIdMeta =
      const VerificationMeta('alarmId');
  @override
  late final GeneratedColumn<int> alarmId = GeneratedColumn<int>(
      'alarm_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _triggeredAtMeta =
      const VerificationMeta('triggeredAt');
  @override
  late final GeneratedColumn<DateTime> triggeredAt = GeneratedColumn<DateTime>(
      'triggered_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dismissedAtMeta =
      const VerificationMeta('dismissedAt');
  @override
  late final GeneratedColumn<DateTime> dismissedAt = GeneratedColumn<DateTime>(
      'dismissed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _questionsAttemptedMeta =
      const VerificationMeta('questionsAttempted');
  @override
  late final GeneratedColumn<int> questionsAttempted = GeneratedColumn<int>(
      'questions_attempted', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _questionsCorrectMeta =
      const VerificationMeta('questionsCorrect');
  @override
  late final GeneratedColumn<int> questionsCorrect = GeneratedColumn<int>(
      'questions_correct', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _snoozeCountMeta =
      const VerificationMeta('snoozeCount');
  @override
  late final GeneratedColumn<int> snoozeCount = GeneratedColumn<int>(
      'snooze_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _dismissMethodMeta =
      const VerificationMeta('dismissMethod');
  @override
  late final GeneratedColumn<String> dismissMethod = GeneratedColumn<String>(
      'dismiss_method', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        alarmId,
        triggeredAt,
        dismissedAt,
        questionsAttempted,
        questionsCorrect,
        snoozeCount,
        dismissMethod
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarm_history';
  @override
  VerificationContext validateIntegrity(Insertable<AlarmHistoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('alarm_id')) {
      context.handle(_alarmIdMeta,
          alarmId.isAcceptableOrUnknown(data['alarm_id']!, _alarmIdMeta));
    } else if (isInserting) {
      context.missing(_alarmIdMeta);
    }
    if (data.containsKey('triggered_at')) {
      context.handle(
          _triggeredAtMeta,
          triggeredAt.isAcceptableOrUnknown(
              data['triggered_at']!, _triggeredAtMeta));
    } else if (isInserting) {
      context.missing(_triggeredAtMeta);
    }
    if (data.containsKey('dismissed_at')) {
      context.handle(
          _dismissedAtMeta,
          dismissedAt.isAcceptableOrUnknown(
              data['dismissed_at']!, _dismissedAtMeta));
    }
    if (data.containsKey('questions_attempted')) {
      context.handle(
          _questionsAttemptedMeta,
          questionsAttempted.isAcceptableOrUnknown(
              data['questions_attempted']!, _questionsAttemptedMeta));
    }
    if (data.containsKey('questions_correct')) {
      context.handle(
          _questionsCorrectMeta,
          questionsCorrect.isAcceptableOrUnknown(
              data['questions_correct']!, _questionsCorrectMeta));
    }
    if (data.containsKey('snooze_count')) {
      context.handle(
          _snoozeCountMeta,
          snoozeCount.isAcceptableOrUnknown(
              data['snooze_count']!, _snoozeCountMeta));
    }
    if (data.containsKey('dismiss_method')) {
      context.handle(
          _dismissMethodMeta,
          dismissMethod.isAcceptableOrUnknown(
              data['dismiss_method']!, _dismissMethodMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AlarmHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlarmHistoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      alarmId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}alarm_id'])!,
      triggeredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}triggered_at'])!,
      dismissedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}dismissed_at']),
      questionsAttempted: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}questions_attempted'])!,
      questionsCorrect: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}questions_correct'])!,
      snoozeCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}snooze_count'])!,
      dismissMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dismiss_method']),
    );
  }

  @override
  $AlarmHistoryTable createAlias(String alias) {
    return $AlarmHistoryTable(attachedDatabase, alias);
  }
}

class AlarmHistoryData extends DataClass
    implements Insertable<AlarmHistoryData> {
  /// Unique identifier
  final int id;

  /// Reference to the alarm that was triggered
  final int alarmId;

  /// When the alarm was triggered
  final DateTime triggeredAt;

  /// When the alarm was dismissed (null if still active)
  final DateTime? dismissedAt;

  /// Number of quiz questions attempted
  final int questionsAttempted;

  /// Number of quiz questions answered correctly
  final int questionsCorrect;

  /// Number of times snoozed
  final int snoozeCount;

  /// How the alarm was dismissed: 'quiz', 'snooze_limit', 'force_stop'
  final String? dismissMethod;
  const AlarmHistoryData(
      {required this.id,
      required this.alarmId,
      required this.triggeredAt,
      this.dismissedAt,
      required this.questionsAttempted,
      required this.questionsCorrect,
      required this.snoozeCount,
      this.dismissMethod});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['alarm_id'] = Variable<int>(alarmId);
    map['triggered_at'] = Variable<DateTime>(triggeredAt);
    if (!nullToAbsent || dismissedAt != null) {
      map['dismissed_at'] = Variable<DateTime>(dismissedAt);
    }
    map['questions_attempted'] = Variable<int>(questionsAttempted);
    map['questions_correct'] = Variable<int>(questionsCorrect);
    map['snooze_count'] = Variable<int>(snoozeCount);
    if (!nullToAbsent || dismissMethod != null) {
      map['dismiss_method'] = Variable<String>(dismissMethod);
    }
    return map;
  }

  AlarmHistoryCompanion toCompanion(bool nullToAbsent) {
    return AlarmHistoryCompanion(
      id: Value(id),
      alarmId: Value(alarmId),
      triggeredAt: Value(triggeredAt),
      dismissedAt: dismissedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dismissedAt),
      questionsAttempted: Value(questionsAttempted),
      questionsCorrect: Value(questionsCorrect),
      snoozeCount: Value(snoozeCount),
      dismissMethod: dismissMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(dismissMethod),
    );
  }

  factory AlarmHistoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlarmHistoryData(
      id: serializer.fromJson<int>(json['id']),
      alarmId: serializer.fromJson<int>(json['alarmId']),
      triggeredAt: serializer.fromJson<DateTime>(json['triggeredAt']),
      dismissedAt: serializer.fromJson<DateTime?>(json['dismissedAt']),
      questionsAttempted: serializer.fromJson<int>(json['questionsAttempted']),
      questionsCorrect: serializer.fromJson<int>(json['questionsCorrect']),
      snoozeCount: serializer.fromJson<int>(json['snoozeCount']),
      dismissMethod: serializer.fromJson<String?>(json['dismissMethod']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'alarmId': serializer.toJson<int>(alarmId),
      'triggeredAt': serializer.toJson<DateTime>(triggeredAt),
      'dismissedAt': serializer.toJson<DateTime?>(dismissedAt),
      'questionsAttempted': serializer.toJson<int>(questionsAttempted),
      'questionsCorrect': serializer.toJson<int>(questionsCorrect),
      'snoozeCount': serializer.toJson<int>(snoozeCount),
      'dismissMethod': serializer.toJson<String?>(dismissMethod),
    };
  }

  AlarmHistoryData copyWith(
          {int? id,
          int? alarmId,
          DateTime? triggeredAt,
          Value<DateTime?> dismissedAt = const Value.absent(),
          int? questionsAttempted,
          int? questionsCorrect,
          int? snoozeCount,
          Value<String?> dismissMethod = const Value.absent()}) =>
      AlarmHistoryData(
        id: id ?? this.id,
        alarmId: alarmId ?? this.alarmId,
        triggeredAt: triggeredAt ?? this.triggeredAt,
        dismissedAt: dismissedAt.present ? dismissedAt.value : this.dismissedAt,
        questionsAttempted: questionsAttempted ?? this.questionsAttempted,
        questionsCorrect: questionsCorrect ?? this.questionsCorrect,
        snoozeCount: snoozeCount ?? this.snoozeCount,
        dismissMethod:
            dismissMethod.present ? dismissMethod.value : this.dismissMethod,
      );
  AlarmHistoryData copyWithCompanion(AlarmHistoryCompanion data) {
    return AlarmHistoryData(
      id: data.id.present ? data.id.value : this.id,
      alarmId: data.alarmId.present ? data.alarmId.value : this.alarmId,
      triggeredAt:
          data.triggeredAt.present ? data.triggeredAt.value : this.triggeredAt,
      dismissedAt:
          data.dismissedAt.present ? data.dismissedAt.value : this.dismissedAt,
      questionsAttempted: data.questionsAttempted.present
          ? data.questionsAttempted.value
          : this.questionsAttempted,
      questionsCorrect: data.questionsCorrect.present
          ? data.questionsCorrect.value
          : this.questionsCorrect,
      snoozeCount:
          data.snoozeCount.present ? data.snoozeCount.value : this.snoozeCount,
      dismissMethod: data.dismissMethod.present
          ? data.dismissMethod.value
          : this.dismissMethod,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlarmHistoryData(')
          ..write('id: $id, ')
          ..write('alarmId: $alarmId, ')
          ..write('triggeredAt: $triggeredAt, ')
          ..write('dismissedAt: $dismissedAt, ')
          ..write('questionsAttempted: $questionsAttempted, ')
          ..write('questionsCorrect: $questionsCorrect, ')
          ..write('snoozeCount: $snoozeCount, ')
          ..write('dismissMethod: $dismissMethod')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, alarmId, triggeredAt, dismissedAt,
      questionsAttempted, questionsCorrect, snoozeCount, dismissMethod);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlarmHistoryData &&
          other.id == this.id &&
          other.alarmId == this.alarmId &&
          other.triggeredAt == this.triggeredAt &&
          other.dismissedAt == this.dismissedAt &&
          other.questionsAttempted == this.questionsAttempted &&
          other.questionsCorrect == this.questionsCorrect &&
          other.snoozeCount == this.snoozeCount &&
          other.dismissMethod == this.dismissMethod);
}

class AlarmHistoryCompanion extends UpdateCompanion<AlarmHistoryData> {
  final Value<int> id;
  final Value<int> alarmId;
  final Value<DateTime> triggeredAt;
  final Value<DateTime?> dismissedAt;
  final Value<int> questionsAttempted;
  final Value<int> questionsCorrect;
  final Value<int> snoozeCount;
  final Value<String?> dismissMethod;
  const AlarmHistoryCompanion({
    this.id = const Value.absent(),
    this.alarmId = const Value.absent(),
    this.triggeredAt = const Value.absent(),
    this.dismissedAt = const Value.absent(),
    this.questionsAttempted = const Value.absent(),
    this.questionsCorrect = const Value.absent(),
    this.snoozeCount = const Value.absent(),
    this.dismissMethod = const Value.absent(),
  });
  AlarmHistoryCompanion.insert({
    this.id = const Value.absent(),
    required int alarmId,
    required DateTime triggeredAt,
    this.dismissedAt = const Value.absent(),
    this.questionsAttempted = const Value.absent(),
    this.questionsCorrect = const Value.absent(),
    this.snoozeCount = const Value.absent(),
    this.dismissMethod = const Value.absent(),
  })  : alarmId = Value(alarmId),
        triggeredAt = Value(triggeredAt);
  static Insertable<AlarmHistoryData> custom({
    Expression<int>? id,
    Expression<int>? alarmId,
    Expression<DateTime>? triggeredAt,
    Expression<DateTime>? dismissedAt,
    Expression<int>? questionsAttempted,
    Expression<int>? questionsCorrect,
    Expression<int>? snoozeCount,
    Expression<String>? dismissMethod,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (alarmId != null) 'alarm_id': alarmId,
      if (triggeredAt != null) 'triggered_at': triggeredAt,
      if (dismissedAt != null) 'dismissed_at': dismissedAt,
      if (questionsAttempted != null) 'questions_attempted': questionsAttempted,
      if (questionsCorrect != null) 'questions_correct': questionsCorrect,
      if (snoozeCount != null) 'snooze_count': snoozeCount,
      if (dismissMethod != null) 'dismiss_method': dismissMethod,
    });
  }

  AlarmHistoryCompanion copyWith(
      {Value<int>? id,
      Value<int>? alarmId,
      Value<DateTime>? triggeredAt,
      Value<DateTime?>? dismissedAt,
      Value<int>? questionsAttempted,
      Value<int>? questionsCorrect,
      Value<int>? snoozeCount,
      Value<String?>? dismissMethod}) {
    return AlarmHistoryCompanion(
      id: id ?? this.id,
      alarmId: alarmId ?? this.alarmId,
      triggeredAt: triggeredAt ?? this.triggeredAt,
      dismissedAt: dismissedAt ?? this.dismissedAt,
      questionsAttempted: questionsAttempted ?? this.questionsAttempted,
      questionsCorrect: questionsCorrect ?? this.questionsCorrect,
      snoozeCount: snoozeCount ?? this.snoozeCount,
      dismissMethod: dismissMethod ?? this.dismissMethod,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (alarmId.present) {
      map['alarm_id'] = Variable<int>(alarmId.value);
    }
    if (triggeredAt.present) {
      map['triggered_at'] = Variable<DateTime>(triggeredAt.value);
    }
    if (dismissedAt.present) {
      map['dismissed_at'] = Variable<DateTime>(dismissedAt.value);
    }
    if (questionsAttempted.present) {
      map['questions_attempted'] = Variable<int>(questionsAttempted.value);
    }
    if (questionsCorrect.present) {
      map['questions_correct'] = Variable<int>(questionsCorrect.value);
    }
    if (snoozeCount.present) {
      map['snooze_count'] = Variable<int>(snoozeCount.value);
    }
    if (dismissMethod.present) {
      map['dismiss_method'] = Variable<String>(dismissMethod.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmHistoryCompanion(')
          ..write('id: $id, ')
          ..write('alarmId: $alarmId, ')
          ..write('triggeredAt: $triggeredAt, ')
          ..write('dismissedAt: $dismissedAt, ')
          ..write('questionsAttempted: $questionsAttempted, ')
          ..write('questionsCorrect: $questionsCorrect, ')
          ..write('snoozeCount: $snoozeCount, ')
          ..write('dismissMethod: $dismissMethod')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AlarmsTable alarms = $AlarmsTable(this);
  late final $QuizProgressTable quizProgress = $QuizProgressTable(this);
  late final $AlarmHistoryTable alarmHistory = $AlarmHistoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [alarms, quizProgress, alarmHistory];
}

typedef $$AlarmsTableCreateCompanionBuilder = AlarmsCompanion Function({
  Value<int> id,
  Value<String> label,
  required int hour,
  required int minute,
  Value<bool> isEnabled,
  Value<String> repeatDays,
  Value<String> quizDifficulty,
  Value<int> quizCount,
  Value<String> soundPath,
  Value<bool> vibrationEnabled,
  Value<int> snoozeDuration,
  Value<int> maxSnoozes,
  Value<int> volume,
  Value<bool> gradualVolume,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> nextFireTime,
});
typedef $$AlarmsTableUpdateCompanionBuilder = AlarmsCompanion Function({
  Value<int> id,
  Value<String> label,
  Value<int> hour,
  Value<int> minute,
  Value<bool> isEnabled,
  Value<String> repeatDays,
  Value<String> quizDifficulty,
  Value<int> quizCount,
  Value<String> soundPath,
  Value<bool> vibrationEnabled,
  Value<int> snoozeDuration,
  Value<int> maxSnoozes,
  Value<int> volume,
  Value<bool> gradualVolume,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> nextFireTime,
});

class $$AlarmsTableFilterComposer
    extends Composer<_$AppDatabase, $AlarmsTable> {
  $$AlarmsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hour => $composableBuilder(
      column: $table.hour, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minute => $composableBuilder(
      column: $table.minute, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get repeatDays => $composableBuilder(
      column: $table.repeatDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get quizDifficulty => $composableBuilder(
      column: $table.quizDifficulty,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quizCount => $composableBuilder(
      column: $table.quizCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get soundPath => $composableBuilder(
      column: $table.soundPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get vibrationEnabled => $composableBuilder(
      column: $table.vibrationEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get snoozeDuration => $composableBuilder(
      column: $table.snoozeDuration,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxSnoozes => $composableBuilder(
      column: $table.maxSnoozes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get volume => $composableBuilder(
      column: $table.volume, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get gradualVolume => $composableBuilder(
      column: $table.gradualVolume, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextFireTime => $composableBuilder(
      column: $table.nextFireTime, builder: (column) => ColumnFilters(column));
}

class $$AlarmsTableOrderingComposer
    extends Composer<_$AppDatabase, $AlarmsTable> {
  $$AlarmsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hour => $composableBuilder(
      column: $table.hour, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minute => $composableBuilder(
      column: $table.minute, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get repeatDays => $composableBuilder(
      column: $table.repeatDays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get quizDifficulty => $composableBuilder(
      column: $table.quizDifficulty,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quizCount => $composableBuilder(
      column: $table.quizCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get soundPath => $composableBuilder(
      column: $table.soundPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get vibrationEnabled => $composableBuilder(
      column: $table.vibrationEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get snoozeDuration => $composableBuilder(
      column: $table.snoozeDuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxSnoozes => $composableBuilder(
      column: $table.maxSnoozes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get volume => $composableBuilder(
      column: $table.volume, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get gradualVolume => $composableBuilder(
      column: $table.gradualVolume,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextFireTime => $composableBuilder(
      column: $table.nextFireTime,
      builder: (column) => ColumnOrderings(column));
}

class $$AlarmsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlarmsTable> {
  $$AlarmsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<int> get hour =>
      $composableBuilder(column: $table.hour, builder: (column) => column);

  GeneratedColumn<int> get minute =>
      $composableBuilder(column: $table.minute, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get repeatDays => $composableBuilder(
      column: $table.repeatDays, builder: (column) => column);

  GeneratedColumn<String> get quizDifficulty => $composableBuilder(
      column: $table.quizDifficulty, builder: (column) => column);

  GeneratedColumn<int> get quizCount =>
      $composableBuilder(column: $table.quizCount, builder: (column) => column);

  GeneratedColumn<String> get soundPath =>
      $composableBuilder(column: $table.soundPath, builder: (column) => column);

  GeneratedColumn<bool> get vibrationEnabled => $composableBuilder(
      column: $table.vibrationEnabled, builder: (column) => column);

  GeneratedColumn<int> get snoozeDuration => $composableBuilder(
      column: $table.snoozeDuration, builder: (column) => column);

  GeneratedColumn<int> get maxSnoozes => $composableBuilder(
      column: $table.maxSnoozes, builder: (column) => column);

  GeneratedColumn<int> get volume =>
      $composableBuilder(column: $table.volume, builder: (column) => column);

  GeneratedColumn<bool> get gradualVolume => $composableBuilder(
      column: $table.gradualVolume, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get nextFireTime => $composableBuilder(
      column: $table.nextFireTime, builder: (column) => column);
}

class $$AlarmsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AlarmsTable,
    Alarm,
    $$AlarmsTableFilterComposer,
    $$AlarmsTableOrderingComposer,
    $$AlarmsTableAnnotationComposer,
    $$AlarmsTableCreateCompanionBuilder,
    $$AlarmsTableUpdateCompanionBuilder,
    (Alarm, BaseReferences<_$AppDatabase, $AlarmsTable, Alarm>),
    Alarm,
    PrefetchHooks Function()> {
  $$AlarmsTableTableManager(_$AppDatabase db, $AlarmsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlarmsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlarmsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlarmsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<int> hour = const Value.absent(),
            Value<int> minute = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
            Value<String> repeatDays = const Value.absent(),
            Value<String> quizDifficulty = const Value.absent(),
            Value<int> quizCount = const Value.absent(),
            Value<String> soundPath = const Value.absent(),
            Value<bool> vibrationEnabled = const Value.absent(),
            Value<int> snoozeDuration = const Value.absent(),
            Value<int> maxSnoozes = const Value.absent(),
            Value<int> volume = const Value.absent(),
            Value<bool> gradualVolume = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> nextFireTime = const Value.absent(),
          }) =>
              AlarmsCompanion(
            id: id,
            label: label,
            hour: hour,
            minute: minute,
            isEnabled: isEnabled,
            repeatDays: repeatDays,
            quizDifficulty: quizDifficulty,
            quizCount: quizCount,
            soundPath: soundPath,
            vibrationEnabled: vibrationEnabled,
            snoozeDuration: snoozeDuration,
            maxSnoozes: maxSnoozes,
            volume: volume,
            gradualVolume: gradualVolume,
            createdAt: createdAt,
            updatedAt: updatedAt,
            nextFireTime: nextFireTime,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> label = const Value.absent(),
            required int hour,
            required int minute,
            Value<bool> isEnabled = const Value.absent(),
            Value<String> repeatDays = const Value.absent(),
            Value<String> quizDifficulty = const Value.absent(),
            Value<int> quizCount = const Value.absent(),
            Value<String> soundPath = const Value.absent(),
            Value<bool> vibrationEnabled = const Value.absent(),
            Value<int> snoozeDuration = const Value.absent(),
            Value<int> maxSnoozes = const Value.absent(),
            Value<int> volume = const Value.absent(),
            Value<bool> gradualVolume = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> nextFireTime = const Value.absent(),
          }) =>
              AlarmsCompanion.insert(
            id: id,
            label: label,
            hour: hour,
            minute: minute,
            isEnabled: isEnabled,
            repeatDays: repeatDays,
            quizDifficulty: quizDifficulty,
            quizCount: quizCount,
            soundPath: soundPath,
            vibrationEnabled: vibrationEnabled,
            snoozeDuration: snoozeDuration,
            maxSnoozes: maxSnoozes,
            volume: volume,
            gradualVolume: gradualVolume,
            createdAt: createdAt,
            updatedAt: updatedAt,
            nextFireTime: nextFireTime,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AlarmsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AlarmsTable,
    Alarm,
    $$AlarmsTableFilterComposer,
    $$AlarmsTableOrderingComposer,
    $$AlarmsTableAnnotationComposer,
    $$AlarmsTableCreateCompanionBuilder,
    $$AlarmsTableUpdateCompanionBuilder,
    (Alarm, BaseReferences<_$AppDatabase, $AlarmsTable, Alarm>),
    Alarm,
    PrefetchHooks Function()>;
typedef $$QuizProgressTableCreateCompanionBuilder = QuizProgressCompanion
    Function({
  Value<int> id,
  required String questionId,
  Value<int> timesShown,
  Value<int> timesCorrect,
  Value<int> timesIncorrect,
  Value<DateTime?> lastShownAt,
  Value<int> avgResponseTimeMs,
  Value<int> performanceRating,
});
typedef $$QuizProgressTableUpdateCompanionBuilder = QuizProgressCompanion
    Function({
  Value<int> id,
  Value<String> questionId,
  Value<int> timesShown,
  Value<int> timesCorrect,
  Value<int> timesIncorrect,
  Value<DateTime?> lastShownAt,
  Value<int> avgResponseTimeMs,
  Value<int> performanceRating,
});

class $$QuizProgressTableFilterComposer
    extends Composer<_$AppDatabase, $QuizProgressTable> {
  $$QuizProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timesShown => $composableBuilder(
      column: $table.timesShown, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timesCorrect => $composableBuilder(
      column: $table.timesCorrect, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timesIncorrect => $composableBuilder(
      column: $table.timesIncorrect,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastShownAt => $composableBuilder(
      column: $table.lastShownAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get avgResponseTimeMs => $composableBuilder(
      column: $table.avgResponseTimeMs,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get performanceRating => $composableBuilder(
      column: $table.performanceRating,
      builder: (column) => ColumnFilters(column));
}

class $$QuizProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $QuizProgressTable> {
  $$QuizProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timesShown => $composableBuilder(
      column: $table.timesShown, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timesCorrect => $composableBuilder(
      column: $table.timesCorrect,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timesIncorrect => $composableBuilder(
      column: $table.timesIncorrect,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastShownAt => $composableBuilder(
      column: $table.lastShownAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get avgResponseTimeMs => $composableBuilder(
      column: $table.avgResponseTimeMs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get performanceRating => $composableBuilder(
      column: $table.performanceRating,
      builder: (column) => ColumnOrderings(column));
}

class $$QuizProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuizProgressTable> {
  $$QuizProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => column);

  GeneratedColumn<int> get timesShown => $composableBuilder(
      column: $table.timesShown, builder: (column) => column);

  GeneratedColumn<int> get timesCorrect => $composableBuilder(
      column: $table.timesCorrect, builder: (column) => column);

  GeneratedColumn<int> get timesIncorrect => $composableBuilder(
      column: $table.timesIncorrect, builder: (column) => column);

  GeneratedColumn<DateTime> get lastShownAt => $composableBuilder(
      column: $table.lastShownAt, builder: (column) => column);

  GeneratedColumn<int> get avgResponseTimeMs => $composableBuilder(
      column: $table.avgResponseTimeMs, builder: (column) => column);

  GeneratedColumn<int> get performanceRating => $composableBuilder(
      column: $table.performanceRating, builder: (column) => column);
}

class $$QuizProgressTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuizProgressTable,
    QuizProgressData,
    $$QuizProgressTableFilterComposer,
    $$QuizProgressTableOrderingComposer,
    $$QuizProgressTableAnnotationComposer,
    $$QuizProgressTableCreateCompanionBuilder,
    $$QuizProgressTableUpdateCompanionBuilder,
    (
      QuizProgressData,
      BaseReferences<_$AppDatabase, $QuizProgressTable, QuizProgressData>
    ),
    QuizProgressData,
    PrefetchHooks Function()> {
  $$QuizProgressTableTableManager(_$AppDatabase db, $QuizProgressTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuizProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuizProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuizProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> questionId = const Value.absent(),
            Value<int> timesShown = const Value.absent(),
            Value<int> timesCorrect = const Value.absent(),
            Value<int> timesIncorrect = const Value.absent(),
            Value<DateTime?> lastShownAt = const Value.absent(),
            Value<int> avgResponseTimeMs = const Value.absent(),
            Value<int> performanceRating = const Value.absent(),
          }) =>
              QuizProgressCompanion(
            id: id,
            questionId: questionId,
            timesShown: timesShown,
            timesCorrect: timesCorrect,
            timesIncorrect: timesIncorrect,
            lastShownAt: lastShownAt,
            avgResponseTimeMs: avgResponseTimeMs,
            performanceRating: performanceRating,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String questionId,
            Value<int> timesShown = const Value.absent(),
            Value<int> timesCorrect = const Value.absent(),
            Value<int> timesIncorrect = const Value.absent(),
            Value<DateTime?> lastShownAt = const Value.absent(),
            Value<int> avgResponseTimeMs = const Value.absent(),
            Value<int> performanceRating = const Value.absent(),
          }) =>
              QuizProgressCompanion.insert(
            id: id,
            questionId: questionId,
            timesShown: timesShown,
            timesCorrect: timesCorrect,
            timesIncorrect: timesIncorrect,
            lastShownAt: lastShownAt,
            avgResponseTimeMs: avgResponseTimeMs,
            performanceRating: performanceRating,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$QuizProgressTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuizProgressTable,
    QuizProgressData,
    $$QuizProgressTableFilterComposer,
    $$QuizProgressTableOrderingComposer,
    $$QuizProgressTableAnnotationComposer,
    $$QuizProgressTableCreateCompanionBuilder,
    $$QuizProgressTableUpdateCompanionBuilder,
    (
      QuizProgressData,
      BaseReferences<_$AppDatabase, $QuizProgressTable, QuizProgressData>
    ),
    QuizProgressData,
    PrefetchHooks Function()>;
typedef $$AlarmHistoryTableCreateCompanionBuilder = AlarmHistoryCompanion
    Function({
  Value<int> id,
  required int alarmId,
  required DateTime triggeredAt,
  Value<DateTime?> dismissedAt,
  Value<int> questionsAttempted,
  Value<int> questionsCorrect,
  Value<int> snoozeCount,
  Value<String?> dismissMethod,
});
typedef $$AlarmHistoryTableUpdateCompanionBuilder = AlarmHistoryCompanion
    Function({
  Value<int> id,
  Value<int> alarmId,
  Value<DateTime> triggeredAt,
  Value<DateTime?> dismissedAt,
  Value<int> questionsAttempted,
  Value<int> questionsCorrect,
  Value<int> snoozeCount,
  Value<String?> dismissMethod,
});

class $$AlarmHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $AlarmHistoryTable> {
  $$AlarmHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get alarmId => $composableBuilder(
      column: $table.alarmId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get triggeredAt => $composableBuilder(
      column: $table.triggeredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dismissedAt => $composableBuilder(
      column: $table.dismissedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get questionsAttempted => $composableBuilder(
      column: $table.questionsAttempted,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get questionsCorrect => $composableBuilder(
      column: $table.questionsCorrect,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get snoozeCount => $composableBuilder(
      column: $table.snoozeCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dismissMethod => $composableBuilder(
      column: $table.dismissMethod, builder: (column) => ColumnFilters(column));
}

class $$AlarmHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $AlarmHistoryTable> {
  $$AlarmHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get alarmId => $composableBuilder(
      column: $table.alarmId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get triggeredAt => $composableBuilder(
      column: $table.triggeredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dismissedAt => $composableBuilder(
      column: $table.dismissedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get questionsAttempted => $composableBuilder(
      column: $table.questionsAttempted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get questionsCorrect => $composableBuilder(
      column: $table.questionsCorrect,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get snoozeCount => $composableBuilder(
      column: $table.snoozeCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dismissMethod => $composableBuilder(
      column: $table.dismissMethod,
      builder: (column) => ColumnOrderings(column));
}

class $$AlarmHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlarmHistoryTable> {
  $$AlarmHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get alarmId =>
      $composableBuilder(column: $table.alarmId, builder: (column) => column);

  GeneratedColumn<DateTime> get triggeredAt => $composableBuilder(
      column: $table.triggeredAt, builder: (column) => column);

  GeneratedColumn<DateTime> get dismissedAt => $composableBuilder(
      column: $table.dismissedAt, builder: (column) => column);

  GeneratedColumn<int> get questionsAttempted => $composableBuilder(
      column: $table.questionsAttempted, builder: (column) => column);

  GeneratedColumn<int> get questionsCorrect => $composableBuilder(
      column: $table.questionsCorrect, builder: (column) => column);

  GeneratedColumn<int> get snoozeCount => $composableBuilder(
      column: $table.snoozeCount, builder: (column) => column);

  GeneratedColumn<String> get dismissMethod => $composableBuilder(
      column: $table.dismissMethod, builder: (column) => column);
}

class $$AlarmHistoryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AlarmHistoryTable,
    AlarmHistoryData,
    $$AlarmHistoryTableFilterComposer,
    $$AlarmHistoryTableOrderingComposer,
    $$AlarmHistoryTableAnnotationComposer,
    $$AlarmHistoryTableCreateCompanionBuilder,
    $$AlarmHistoryTableUpdateCompanionBuilder,
    (
      AlarmHistoryData,
      BaseReferences<_$AppDatabase, $AlarmHistoryTable, AlarmHistoryData>
    ),
    AlarmHistoryData,
    PrefetchHooks Function()> {
  $$AlarmHistoryTableTableManager(_$AppDatabase db, $AlarmHistoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlarmHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlarmHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlarmHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> alarmId = const Value.absent(),
            Value<DateTime> triggeredAt = const Value.absent(),
            Value<DateTime?> dismissedAt = const Value.absent(),
            Value<int> questionsAttempted = const Value.absent(),
            Value<int> questionsCorrect = const Value.absent(),
            Value<int> snoozeCount = const Value.absent(),
            Value<String?> dismissMethod = const Value.absent(),
          }) =>
              AlarmHistoryCompanion(
            id: id,
            alarmId: alarmId,
            triggeredAt: triggeredAt,
            dismissedAt: dismissedAt,
            questionsAttempted: questionsAttempted,
            questionsCorrect: questionsCorrect,
            snoozeCount: snoozeCount,
            dismissMethod: dismissMethod,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int alarmId,
            required DateTime triggeredAt,
            Value<DateTime?> dismissedAt = const Value.absent(),
            Value<int> questionsAttempted = const Value.absent(),
            Value<int> questionsCorrect = const Value.absent(),
            Value<int> snoozeCount = const Value.absent(),
            Value<String?> dismissMethod = const Value.absent(),
          }) =>
              AlarmHistoryCompanion.insert(
            id: id,
            alarmId: alarmId,
            triggeredAt: triggeredAt,
            dismissedAt: dismissedAt,
            questionsAttempted: questionsAttempted,
            questionsCorrect: questionsCorrect,
            snoozeCount: snoozeCount,
            dismissMethod: dismissMethod,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AlarmHistoryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AlarmHistoryTable,
    AlarmHistoryData,
    $$AlarmHistoryTableFilterComposer,
    $$AlarmHistoryTableOrderingComposer,
    $$AlarmHistoryTableAnnotationComposer,
    $$AlarmHistoryTableCreateCompanionBuilder,
    $$AlarmHistoryTableUpdateCompanionBuilder,
    (
      AlarmHistoryData,
      BaseReferences<_$AppDatabase, $AlarmHistoryTable, AlarmHistoryData>
    ),
    AlarmHistoryData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AlarmsTableTableManager get alarms =>
      $$AlarmsTableTableManager(_db, _db.alarms);
  $$QuizProgressTableTableManager get quizProgress =>
      $$QuizProgressTableTableManager(_db, _db.quizProgress);
  $$AlarmHistoryTableTableManager get alarmHistory =>
      $$AlarmHistoryTableTableManager(_db, _db.alarmHistory);
}
