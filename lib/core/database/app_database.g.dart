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

  /// Question identifier from the seeded quiz content
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

class $VocabularyItemsTable extends VocabularyItems
    with TableInfo<$VocabularyItemsTable, VocabularyItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabularyItemsTable(this.attachedDatabase, [this._alias]);
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
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
      'difficulty', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionMeta =
      const VerificationMeta('question');
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
      'question', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionKoMeta =
      const VerificationMeta('questionKo');
  @override
  late final GeneratedColumn<String> questionKo = GeneratedColumn<String>(
      'question_ko', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _optionsMeta =
      const VerificationMeta('options');
  @override
  late final GeneratedColumn<String> options = GeneratedColumn<String>(
      'options', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _correctAnswerMeta =
      const VerificationMeta('correctAnswer');
  @override
  late final GeneratedColumn<String> correctAnswer = GeneratedColumn<String>(
      'correct_answer', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _hintMeta = const VerificationMeta('hint');
  @override
  late final GeneratedColumn<String> hint = GeneratedColumn<String>(
      'hint', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _explanationMeta =
      const VerificationMeta('explanation');
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
      'explanation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _explanationKoMeta =
      const VerificationMeta('explanationKo');
  @override
  late final GeneratedColumn<String> explanationKo = GeneratedColumn<String>(
      'explanation_ko', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceUrlMeta =
      const VerificationMeta('sourceUrl');
  @override
  late final GeneratedColumn<String> sourceUrl = GeneratedColumn<String>(
      'source_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceLabelMeta =
      const VerificationMeta('sourceLabel');
  @override
  late final GeneratedColumn<String> sourceLabel = GeneratedColumn<String>(
      'source_label', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timesPresentedMeta =
      const VerificationMeta('timesPresented');
  @override
  late final GeneratedColumn<int> timesPresented = GeneratedColumn<int>(
      'times_presented', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _timesCorrectFirstAttemptMeta =
      const VerificationMeta('timesCorrectFirstAttempt');
  @override
  late final GeneratedColumn<int> timesCorrectFirstAttempt =
      GeneratedColumn<int>('times_correct_first_attempt', aliasedName, false,
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
  static const VerificationMeta _isMasteredMeta =
      const VerificationMeta('isMastered');
  @override
  late final GeneratedColumn<bool> isMastered = GeneratedColumn<bool>(
      'is_mastered', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_mastered" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _lastPresentedAtMeta =
      const VerificationMeta('lastPresentedAt');
  @override
  late final GeneratedColumn<DateTime> lastPresentedAt =
      GeneratedColumn<DateTime>('last_presented_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _masteredAtMeta =
      const VerificationMeta('masteredAt');
  @override
  late final GeneratedColumn<DateTime> masteredAt = GeneratedColumn<DateTime>(
      'mastered_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isFreeMeta = const VerificationMeta('isFree');
  @override
  late final GeneratedColumn<bool> isFree = GeneratedColumn<bool>(
      'is_free', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_free" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _unlockLevelMeta =
      const VerificationMeta('unlockLevel');
  @override
  late final GeneratedColumn<int> unlockLevel = GeneratedColumn<int>(
      'unlock_level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        questionId,
        type,
        category,
        difficulty,
        question,
        questionKo,
        options,
        correctAnswer,
        hint,
        explanation,
        explanationKo,
        source,
        sourceUrl,
        sourceLabel,
        timesPresented,
        timesCorrectFirstAttempt,
        timesIncorrect,
        isMastered,
        lastPresentedAt,
        masteredAt,
        isFree,
        unlockLevel,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocabulary_items';
  @override
  VerificationContext validateIntegrity(Insertable<VocabularyItem> instance,
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
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('question')) {
      context.handle(_questionMeta,
          question.isAcceptableOrUnknown(data['question']!, _questionMeta));
    } else if (isInserting) {
      context.missing(_questionMeta);
    }
    if (data.containsKey('question_ko')) {
      context.handle(
          _questionKoMeta,
          questionKo.isAcceptableOrUnknown(
              data['question_ko']!, _questionKoMeta));
    } else if (isInserting) {
      context.missing(_questionKoMeta);
    }
    if (data.containsKey('options')) {
      context.handle(_optionsMeta,
          options.isAcceptableOrUnknown(data['options']!, _optionsMeta));
    } else if (isInserting) {
      context.missing(_optionsMeta);
    }
    if (data.containsKey('correct_answer')) {
      context.handle(
          _correctAnswerMeta,
          correctAnswer.isAcceptableOrUnknown(
              data['correct_answer']!, _correctAnswerMeta));
    } else if (isInserting) {
      context.missing(_correctAnswerMeta);
    }
    if (data.containsKey('hint')) {
      context.handle(
          _hintMeta, hint.isAcceptableOrUnknown(data['hint']!, _hintMeta));
    }
    if (data.containsKey('explanation')) {
      context.handle(
          _explanationMeta,
          explanation.isAcceptableOrUnknown(
              data['explanation']!, _explanationMeta));
    }
    if (data.containsKey('explanation_ko')) {
      context.handle(
          _explanationKoMeta,
          explanationKo.isAcceptableOrUnknown(
              data['explanation_ko']!, _explanationKoMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('source_url')) {
      context.handle(_sourceUrlMeta,
          sourceUrl.isAcceptableOrUnknown(data['source_url']!, _sourceUrlMeta));
    }
    if (data.containsKey('source_label')) {
      context.handle(
          _sourceLabelMeta,
          sourceLabel.isAcceptableOrUnknown(
              data['source_label']!, _sourceLabelMeta));
    }
    if (data.containsKey('times_presented')) {
      context.handle(
          _timesPresentedMeta,
          timesPresented.isAcceptableOrUnknown(
              data['times_presented']!, _timesPresentedMeta));
    }
    if (data.containsKey('times_correct_first_attempt')) {
      context.handle(
          _timesCorrectFirstAttemptMeta,
          timesCorrectFirstAttempt.isAcceptableOrUnknown(
              data['times_correct_first_attempt']!,
              _timesCorrectFirstAttemptMeta));
    }
    if (data.containsKey('times_incorrect')) {
      context.handle(
          _timesIncorrectMeta,
          timesIncorrect.isAcceptableOrUnknown(
              data['times_incorrect']!, _timesIncorrectMeta));
    }
    if (data.containsKey('is_mastered')) {
      context.handle(
          _isMasteredMeta,
          isMastered.isAcceptableOrUnknown(
              data['is_mastered']!, _isMasteredMeta));
    }
    if (data.containsKey('last_presented_at')) {
      context.handle(
          _lastPresentedAtMeta,
          lastPresentedAt.isAcceptableOrUnknown(
              data['last_presented_at']!, _lastPresentedAtMeta));
    }
    if (data.containsKey('mastered_at')) {
      context.handle(
          _masteredAtMeta,
          masteredAt.isAcceptableOrUnknown(
              data['mastered_at']!, _masteredAtMeta));
    }
    if (data.containsKey('is_free')) {
      context.handle(_isFreeMeta,
          isFree.isAcceptableOrUnknown(data['is_free']!, _isFreeMeta));
    }
    if (data.containsKey('unlock_level')) {
      context.handle(
          _unlockLevelMeta,
          unlockLevel.isAcceptableOrUnknown(
              data['unlock_level']!, _unlockLevelMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VocabularyItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VocabularyItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}difficulty'])!,
      question: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question'])!,
      questionKo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_ko'])!,
      options: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}options'])!,
      correctAnswer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}correct_answer'])!,
      hint: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hint']),
      explanation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}explanation']),
      explanationKo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}explanation_ko']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source']),
      sourceUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_url']),
      sourceLabel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_label']),
      timesPresented: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}times_presented'])!,
      timesCorrectFirstAttempt: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}times_correct_first_attempt'])!,
      timesIncorrect: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}times_incorrect'])!,
      isMastered: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_mastered'])!,
      lastPresentedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_presented_at']),
      masteredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}mastered_at']),
      isFree: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_free'])!,
      unlockLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unlock_level'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $VocabularyItemsTable createAlias(String alias) {
    return $VocabularyItemsTable(attachedDatabase, alias);
  }
}

class VocabularyItem extends DataClass implements Insertable<VocabularyItem> {
  final int id;

  /// Original ID from JSON (e.g., "vocab_easy_1")
  final String questionId;

  /// 'multiple_choice', 'fill_in_blank', 'translation', 'word_scramble'
  final String type;

  /// 'vocabulary', 'grammar', 'reading', 'idioms', 'daily_expression', 'phrases', 'pronunciation'
  final String category;

  /// 'easy', 'medium', 'hard'
  final String difficulty;

  /// English question text
  final String question;

  /// Korean question text
  final String questionKo;

  /// JSON-encoded array of options
  final String options;

  /// Correct answer string
  final String correctAnswer;

  /// Optional hint
  final String? hint;

  /// English explanation
  final String? explanation;

  /// Korean explanation
  final String? explanationKo;

  /// Content source key, e.g. instagram_reel or tatoeba_sentence
  final String? source;

  /// Canonical source URL for attribution/provenance
  final String? sourceUrl;

  /// Human-readable source label
  final String? sourceLabel;

  /// Total presentations
  final int timesPresented;

  /// Correct on first attempt count
  final int timesCorrectFirstAttempt;

  /// Incorrect count
  final int timesIncorrect;

  /// Mastery achieved flag
  final bool isMastered;

  /// Last shown timestamp
  final DateTime? lastPresentedAt;

  /// When mastery was achieved
  final DateTime? masteredAt;

  /// Available in free tier
  final bool isFree;

  /// Minimum level to access
  final int unlockLevel;

  /// Row creation timestamp
  final DateTime createdAt;
  const VocabularyItem(
      {required this.id,
      required this.questionId,
      required this.type,
      required this.category,
      required this.difficulty,
      required this.question,
      required this.questionKo,
      required this.options,
      required this.correctAnswer,
      this.hint,
      this.explanation,
      this.explanationKo,
      this.source,
      this.sourceUrl,
      this.sourceLabel,
      required this.timesPresented,
      required this.timesCorrectFirstAttempt,
      required this.timesIncorrect,
      required this.isMastered,
      this.lastPresentedAt,
      this.masteredAt,
      required this.isFree,
      required this.unlockLevel,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['question_id'] = Variable<String>(questionId);
    map['type'] = Variable<String>(type);
    map['category'] = Variable<String>(category);
    map['difficulty'] = Variable<String>(difficulty);
    map['question'] = Variable<String>(question);
    map['question_ko'] = Variable<String>(questionKo);
    map['options'] = Variable<String>(options);
    map['correct_answer'] = Variable<String>(correctAnswer);
    if (!nullToAbsent || hint != null) {
      map['hint'] = Variable<String>(hint);
    }
    if (!nullToAbsent || explanation != null) {
      map['explanation'] = Variable<String>(explanation);
    }
    if (!nullToAbsent || explanationKo != null) {
      map['explanation_ko'] = Variable<String>(explanationKo);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    if (!nullToAbsent || sourceUrl != null) {
      map['source_url'] = Variable<String>(sourceUrl);
    }
    if (!nullToAbsent || sourceLabel != null) {
      map['source_label'] = Variable<String>(sourceLabel);
    }
    map['times_presented'] = Variable<int>(timesPresented);
    map['times_correct_first_attempt'] =
        Variable<int>(timesCorrectFirstAttempt);
    map['times_incorrect'] = Variable<int>(timesIncorrect);
    map['is_mastered'] = Variable<bool>(isMastered);
    if (!nullToAbsent || lastPresentedAt != null) {
      map['last_presented_at'] = Variable<DateTime>(lastPresentedAt);
    }
    if (!nullToAbsent || masteredAt != null) {
      map['mastered_at'] = Variable<DateTime>(masteredAt);
    }
    map['is_free'] = Variable<bool>(isFree);
    map['unlock_level'] = Variable<int>(unlockLevel);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  VocabularyItemsCompanion toCompanion(bool nullToAbsent) {
    return VocabularyItemsCompanion(
      id: Value(id),
      questionId: Value(questionId),
      type: Value(type),
      category: Value(category),
      difficulty: Value(difficulty),
      question: Value(question),
      questionKo: Value(questionKo),
      options: Value(options),
      correctAnswer: Value(correctAnswer),
      hint: hint == null && nullToAbsent ? const Value.absent() : Value(hint),
      explanation: explanation == null && nullToAbsent
          ? const Value.absent()
          : Value(explanation),
      explanationKo: explanationKo == null && nullToAbsent
          ? const Value.absent()
          : Value(explanationKo),
      source:
          source == null && nullToAbsent ? const Value.absent() : Value(source),
      sourceUrl: sourceUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceUrl),
      sourceLabel: sourceLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceLabel),
      timesPresented: Value(timesPresented),
      timesCorrectFirstAttempt: Value(timesCorrectFirstAttempt),
      timesIncorrect: Value(timesIncorrect),
      isMastered: Value(isMastered),
      lastPresentedAt: lastPresentedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPresentedAt),
      masteredAt: masteredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(masteredAt),
      isFree: Value(isFree),
      unlockLevel: Value(unlockLevel),
      createdAt: Value(createdAt),
    );
  }

  factory VocabularyItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VocabularyItem(
      id: serializer.fromJson<int>(json['id']),
      questionId: serializer.fromJson<String>(json['questionId']),
      type: serializer.fromJson<String>(json['type']),
      category: serializer.fromJson<String>(json['category']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      question: serializer.fromJson<String>(json['question']),
      questionKo: serializer.fromJson<String>(json['questionKo']),
      options: serializer.fromJson<String>(json['options']),
      correctAnswer: serializer.fromJson<String>(json['correctAnswer']),
      hint: serializer.fromJson<String?>(json['hint']),
      explanation: serializer.fromJson<String?>(json['explanation']),
      explanationKo: serializer.fromJson<String?>(json['explanationKo']),
      source: serializer.fromJson<String?>(json['source']),
      sourceUrl: serializer.fromJson<String?>(json['sourceUrl']),
      sourceLabel: serializer.fromJson<String?>(json['sourceLabel']),
      timesPresented: serializer.fromJson<int>(json['timesPresented']),
      timesCorrectFirstAttempt:
          serializer.fromJson<int>(json['timesCorrectFirstAttempt']),
      timesIncorrect: serializer.fromJson<int>(json['timesIncorrect']),
      isMastered: serializer.fromJson<bool>(json['isMastered']),
      lastPresentedAt: serializer.fromJson<DateTime?>(json['lastPresentedAt']),
      masteredAt: serializer.fromJson<DateTime?>(json['masteredAt']),
      isFree: serializer.fromJson<bool>(json['isFree']),
      unlockLevel: serializer.fromJson<int>(json['unlockLevel']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'questionId': serializer.toJson<String>(questionId),
      'type': serializer.toJson<String>(type),
      'category': serializer.toJson<String>(category),
      'difficulty': serializer.toJson<String>(difficulty),
      'question': serializer.toJson<String>(question),
      'questionKo': serializer.toJson<String>(questionKo),
      'options': serializer.toJson<String>(options),
      'correctAnswer': serializer.toJson<String>(correctAnswer),
      'hint': serializer.toJson<String?>(hint),
      'explanation': serializer.toJson<String?>(explanation),
      'explanationKo': serializer.toJson<String?>(explanationKo),
      'source': serializer.toJson<String?>(source),
      'sourceUrl': serializer.toJson<String?>(sourceUrl),
      'sourceLabel': serializer.toJson<String?>(sourceLabel),
      'timesPresented': serializer.toJson<int>(timesPresented),
      'timesCorrectFirstAttempt':
          serializer.toJson<int>(timesCorrectFirstAttempt),
      'timesIncorrect': serializer.toJson<int>(timesIncorrect),
      'isMastered': serializer.toJson<bool>(isMastered),
      'lastPresentedAt': serializer.toJson<DateTime?>(lastPresentedAt),
      'masteredAt': serializer.toJson<DateTime?>(masteredAt),
      'isFree': serializer.toJson<bool>(isFree),
      'unlockLevel': serializer.toJson<int>(unlockLevel),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  VocabularyItem copyWith(
          {int? id,
          String? questionId,
          String? type,
          String? category,
          String? difficulty,
          String? question,
          String? questionKo,
          String? options,
          String? correctAnswer,
          Value<String?> hint = const Value.absent(),
          Value<String?> explanation = const Value.absent(),
          Value<String?> explanationKo = const Value.absent(),
          Value<String?> source = const Value.absent(),
          Value<String?> sourceUrl = const Value.absent(),
          Value<String?> sourceLabel = const Value.absent(),
          int? timesPresented,
          int? timesCorrectFirstAttempt,
          int? timesIncorrect,
          bool? isMastered,
          Value<DateTime?> lastPresentedAt = const Value.absent(),
          Value<DateTime?> masteredAt = const Value.absent(),
          bool? isFree,
          int? unlockLevel,
          DateTime? createdAt}) =>
      VocabularyItem(
        id: id ?? this.id,
        questionId: questionId ?? this.questionId,
        type: type ?? this.type,
        category: category ?? this.category,
        difficulty: difficulty ?? this.difficulty,
        question: question ?? this.question,
        questionKo: questionKo ?? this.questionKo,
        options: options ?? this.options,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        hint: hint.present ? hint.value : this.hint,
        explanation: explanation.present ? explanation.value : this.explanation,
        explanationKo:
            explanationKo.present ? explanationKo.value : this.explanationKo,
        source: source.present ? source.value : this.source,
        sourceUrl: sourceUrl.present ? sourceUrl.value : this.sourceUrl,
        sourceLabel: sourceLabel.present ? sourceLabel.value : this.sourceLabel,
        timesPresented: timesPresented ?? this.timesPresented,
        timesCorrectFirstAttempt:
            timesCorrectFirstAttempt ?? this.timesCorrectFirstAttempt,
        timesIncorrect: timesIncorrect ?? this.timesIncorrect,
        isMastered: isMastered ?? this.isMastered,
        lastPresentedAt: lastPresentedAt.present
            ? lastPresentedAt.value
            : this.lastPresentedAt,
        masteredAt: masteredAt.present ? masteredAt.value : this.masteredAt,
        isFree: isFree ?? this.isFree,
        unlockLevel: unlockLevel ?? this.unlockLevel,
        createdAt: createdAt ?? this.createdAt,
      );
  VocabularyItem copyWithCompanion(VocabularyItemsCompanion data) {
    return VocabularyItem(
      id: data.id.present ? data.id.value : this.id,
      questionId:
          data.questionId.present ? data.questionId.value : this.questionId,
      type: data.type.present ? data.type.value : this.type,
      category: data.category.present ? data.category.value : this.category,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      question: data.question.present ? data.question.value : this.question,
      questionKo:
          data.questionKo.present ? data.questionKo.value : this.questionKo,
      options: data.options.present ? data.options.value : this.options,
      correctAnswer: data.correctAnswer.present
          ? data.correctAnswer.value
          : this.correctAnswer,
      hint: data.hint.present ? data.hint.value : this.hint,
      explanation:
          data.explanation.present ? data.explanation.value : this.explanation,
      explanationKo: data.explanationKo.present
          ? data.explanationKo.value
          : this.explanationKo,
      source: data.source.present ? data.source.value : this.source,
      sourceUrl: data.sourceUrl.present ? data.sourceUrl.value : this.sourceUrl,
      sourceLabel:
          data.sourceLabel.present ? data.sourceLabel.value : this.sourceLabel,
      timesPresented: data.timesPresented.present
          ? data.timesPresented.value
          : this.timesPresented,
      timesCorrectFirstAttempt: data.timesCorrectFirstAttempt.present
          ? data.timesCorrectFirstAttempt.value
          : this.timesCorrectFirstAttempt,
      timesIncorrect: data.timesIncorrect.present
          ? data.timesIncorrect.value
          : this.timesIncorrect,
      isMastered:
          data.isMastered.present ? data.isMastered.value : this.isMastered,
      lastPresentedAt: data.lastPresentedAt.present
          ? data.lastPresentedAt.value
          : this.lastPresentedAt,
      masteredAt:
          data.masteredAt.present ? data.masteredAt.value : this.masteredAt,
      isFree: data.isFree.present ? data.isFree.value : this.isFree,
      unlockLevel:
          data.unlockLevel.present ? data.unlockLevel.value : this.unlockLevel,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyItem(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('type: $type, ')
          ..write('category: $category, ')
          ..write('difficulty: $difficulty, ')
          ..write('question: $question, ')
          ..write('questionKo: $questionKo, ')
          ..write('options: $options, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('hint: $hint, ')
          ..write('explanation: $explanation, ')
          ..write('explanationKo: $explanationKo, ')
          ..write('source: $source, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('sourceLabel: $sourceLabel, ')
          ..write('timesPresented: $timesPresented, ')
          ..write('timesCorrectFirstAttempt: $timesCorrectFirstAttempt, ')
          ..write('timesIncorrect: $timesIncorrect, ')
          ..write('isMastered: $isMastered, ')
          ..write('lastPresentedAt: $lastPresentedAt, ')
          ..write('masteredAt: $masteredAt, ')
          ..write('isFree: $isFree, ')
          ..write('unlockLevel: $unlockLevel, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        questionId,
        type,
        category,
        difficulty,
        question,
        questionKo,
        options,
        correctAnswer,
        hint,
        explanation,
        explanationKo,
        source,
        sourceUrl,
        sourceLabel,
        timesPresented,
        timesCorrectFirstAttempt,
        timesIncorrect,
        isMastered,
        lastPresentedAt,
        masteredAt,
        isFree,
        unlockLevel,
        createdAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VocabularyItem &&
          other.id == this.id &&
          other.questionId == this.questionId &&
          other.type == this.type &&
          other.category == this.category &&
          other.difficulty == this.difficulty &&
          other.question == this.question &&
          other.questionKo == this.questionKo &&
          other.options == this.options &&
          other.correctAnswer == this.correctAnswer &&
          other.hint == this.hint &&
          other.explanation == this.explanation &&
          other.explanationKo == this.explanationKo &&
          other.source == this.source &&
          other.sourceUrl == this.sourceUrl &&
          other.sourceLabel == this.sourceLabel &&
          other.timesPresented == this.timesPresented &&
          other.timesCorrectFirstAttempt == this.timesCorrectFirstAttempt &&
          other.timesIncorrect == this.timesIncorrect &&
          other.isMastered == this.isMastered &&
          other.lastPresentedAt == this.lastPresentedAt &&
          other.masteredAt == this.masteredAt &&
          other.isFree == this.isFree &&
          other.unlockLevel == this.unlockLevel &&
          other.createdAt == this.createdAt);
}

class VocabularyItemsCompanion extends UpdateCompanion<VocabularyItem> {
  final Value<int> id;
  final Value<String> questionId;
  final Value<String> type;
  final Value<String> category;
  final Value<String> difficulty;
  final Value<String> question;
  final Value<String> questionKo;
  final Value<String> options;
  final Value<String> correctAnswer;
  final Value<String?> hint;
  final Value<String?> explanation;
  final Value<String?> explanationKo;
  final Value<String?> source;
  final Value<String?> sourceUrl;
  final Value<String?> sourceLabel;
  final Value<int> timesPresented;
  final Value<int> timesCorrectFirstAttempt;
  final Value<int> timesIncorrect;
  final Value<bool> isMastered;
  final Value<DateTime?> lastPresentedAt;
  final Value<DateTime?> masteredAt;
  final Value<bool> isFree;
  final Value<int> unlockLevel;
  final Value<DateTime> createdAt;
  const VocabularyItemsCompanion({
    this.id = const Value.absent(),
    this.questionId = const Value.absent(),
    this.type = const Value.absent(),
    this.category = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.question = const Value.absent(),
    this.questionKo = const Value.absent(),
    this.options = const Value.absent(),
    this.correctAnswer = const Value.absent(),
    this.hint = const Value.absent(),
    this.explanation = const Value.absent(),
    this.explanationKo = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceUrl = const Value.absent(),
    this.sourceLabel = const Value.absent(),
    this.timesPresented = const Value.absent(),
    this.timesCorrectFirstAttempt = const Value.absent(),
    this.timesIncorrect = const Value.absent(),
    this.isMastered = const Value.absent(),
    this.lastPresentedAt = const Value.absent(),
    this.masteredAt = const Value.absent(),
    this.isFree = const Value.absent(),
    this.unlockLevel = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  VocabularyItemsCompanion.insert({
    this.id = const Value.absent(),
    required String questionId,
    required String type,
    required String category,
    required String difficulty,
    required String question,
    required String questionKo,
    required String options,
    required String correctAnswer,
    this.hint = const Value.absent(),
    this.explanation = const Value.absent(),
    this.explanationKo = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceUrl = const Value.absent(),
    this.sourceLabel = const Value.absent(),
    this.timesPresented = const Value.absent(),
    this.timesCorrectFirstAttempt = const Value.absent(),
    this.timesIncorrect = const Value.absent(),
    this.isMastered = const Value.absent(),
    this.lastPresentedAt = const Value.absent(),
    this.masteredAt = const Value.absent(),
    this.isFree = const Value.absent(),
    this.unlockLevel = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : questionId = Value(questionId),
        type = Value(type),
        category = Value(category),
        difficulty = Value(difficulty),
        question = Value(question),
        questionKo = Value(questionKo),
        options = Value(options),
        correctAnswer = Value(correctAnswer);
  static Insertable<VocabularyItem> custom({
    Expression<int>? id,
    Expression<String>? questionId,
    Expression<String>? type,
    Expression<String>? category,
    Expression<String>? difficulty,
    Expression<String>? question,
    Expression<String>? questionKo,
    Expression<String>? options,
    Expression<String>? correctAnswer,
    Expression<String>? hint,
    Expression<String>? explanation,
    Expression<String>? explanationKo,
    Expression<String>? source,
    Expression<String>? sourceUrl,
    Expression<String>? sourceLabel,
    Expression<int>? timesPresented,
    Expression<int>? timesCorrectFirstAttempt,
    Expression<int>? timesIncorrect,
    Expression<bool>? isMastered,
    Expression<DateTime>? lastPresentedAt,
    Expression<DateTime>? masteredAt,
    Expression<bool>? isFree,
    Expression<int>? unlockLevel,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionId != null) 'question_id': questionId,
      if (type != null) 'type': type,
      if (category != null) 'category': category,
      if (difficulty != null) 'difficulty': difficulty,
      if (question != null) 'question': question,
      if (questionKo != null) 'question_ko': questionKo,
      if (options != null) 'options': options,
      if (correctAnswer != null) 'correct_answer': correctAnswer,
      if (hint != null) 'hint': hint,
      if (explanation != null) 'explanation': explanation,
      if (explanationKo != null) 'explanation_ko': explanationKo,
      if (source != null) 'source': source,
      if (sourceUrl != null) 'source_url': sourceUrl,
      if (sourceLabel != null) 'source_label': sourceLabel,
      if (timesPresented != null) 'times_presented': timesPresented,
      if (timesCorrectFirstAttempt != null)
        'times_correct_first_attempt': timesCorrectFirstAttempt,
      if (timesIncorrect != null) 'times_incorrect': timesIncorrect,
      if (isMastered != null) 'is_mastered': isMastered,
      if (lastPresentedAt != null) 'last_presented_at': lastPresentedAt,
      if (masteredAt != null) 'mastered_at': masteredAt,
      if (isFree != null) 'is_free': isFree,
      if (unlockLevel != null) 'unlock_level': unlockLevel,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  VocabularyItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? questionId,
      Value<String>? type,
      Value<String>? category,
      Value<String>? difficulty,
      Value<String>? question,
      Value<String>? questionKo,
      Value<String>? options,
      Value<String>? correctAnswer,
      Value<String?>? hint,
      Value<String?>? explanation,
      Value<String?>? explanationKo,
      Value<String?>? source,
      Value<String?>? sourceUrl,
      Value<String?>? sourceLabel,
      Value<int>? timesPresented,
      Value<int>? timesCorrectFirstAttempt,
      Value<int>? timesIncorrect,
      Value<bool>? isMastered,
      Value<DateTime?>? lastPresentedAt,
      Value<DateTime?>? masteredAt,
      Value<bool>? isFree,
      Value<int>? unlockLevel,
      Value<DateTime>? createdAt}) {
    return VocabularyItemsCompanion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      type: type ?? this.type,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      question: question ?? this.question,
      questionKo: questionKo ?? this.questionKo,
      options: options ?? this.options,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      hint: hint ?? this.hint,
      explanation: explanation ?? this.explanation,
      explanationKo: explanationKo ?? this.explanationKo,
      source: source ?? this.source,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      sourceLabel: sourceLabel ?? this.sourceLabel,
      timesPresented: timesPresented ?? this.timesPresented,
      timesCorrectFirstAttempt:
          timesCorrectFirstAttempt ?? this.timesCorrectFirstAttempt,
      timesIncorrect: timesIncorrect ?? this.timesIncorrect,
      isMastered: isMastered ?? this.isMastered,
      lastPresentedAt: lastPresentedAt ?? this.lastPresentedAt,
      masteredAt: masteredAt ?? this.masteredAt,
      isFree: isFree ?? this.isFree,
      unlockLevel: unlockLevel ?? this.unlockLevel,
      createdAt: createdAt ?? this.createdAt,
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
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (questionKo.present) {
      map['question_ko'] = Variable<String>(questionKo.value);
    }
    if (options.present) {
      map['options'] = Variable<String>(options.value);
    }
    if (correctAnswer.present) {
      map['correct_answer'] = Variable<String>(correctAnswer.value);
    }
    if (hint.present) {
      map['hint'] = Variable<String>(hint.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (explanationKo.present) {
      map['explanation_ko'] = Variable<String>(explanationKo.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (sourceUrl.present) {
      map['source_url'] = Variable<String>(sourceUrl.value);
    }
    if (sourceLabel.present) {
      map['source_label'] = Variable<String>(sourceLabel.value);
    }
    if (timesPresented.present) {
      map['times_presented'] = Variable<int>(timesPresented.value);
    }
    if (timesCorrectFirstAttempt.present) {
      map['times_correct_first_attempt'] =
          Variable<int>(timesCorrectFirstAttempt.value);
    }
    if (timesIncorrect.present) {
      map['times_incorrect'] = Variable<int>(timesIncorrect.value);
    }
    if (isMastered.present) {
      map['is_mastered'] = Variable<bool>(isMastered.value);
    }
    if (lastPresentedAt.present) {
      map['last_presented_at'] = Variable<DateTime>(lastPresentedAt.value);
    }
    if (masteredAt.present) {
      map['mastered_at'] = Variable<DateTime>(masteredAt.value);
    }
    if (isFree.present) {
      map['is_free'] = Variable<bool>(isFree.value);
    }
    if (unlockLevel.present) {
      map['unlock_level'] = Variable<int>(unlockLevel.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyItemsCompanion(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('type: $type, ')
          ..write('category: $category, ')
          ..write('difficulty: $difficulty, ')
          ..write('question: $question, ')
          ..write('questionKo: $questionKo, ')
          ..write('options: $options, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('hint: $hint, ')
          ..write('explanation: $explanation, ')
          ..write('explanationKo: $explanationKo, ')
          ..write('source: $source, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('sourceLabel: $sourceLabel, ')
          ..write('timesPresented: $timesPresented, ')
          ..write('timesCorrectFirstAttempt: $timesCorrectFirstAttempt, ')
          ..write('timesIncorrect: $timesIncorrect, ')
          ..write('isMastered: $isMastered, ')
          ..write('lastPresentedAt: $lastPresentedAt, ')
          ..write('masteredAt: $masteredAt, ')
          ..write('isFree: $isFree, ')
          ..write('unlockLevel: $unlockLevel, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserLevelProgressTable extends UserLevelProgress
    with TableInfo<$UserLevelProgressTable, UserLevelProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserLevelProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _currentLevelMeta =
      const VerificationMeta('currentLevel');
  @override
  late final GeneratedColumn<int> currentLevel = GeneratedColumn<int>(
      'current_level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _totalXpMeta =
      const VerificationMeta('totalXp');
  @override
  late final GeneratedColumn<int> totalXp = GeneratedColumn<int>(
      'total_xp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _dailyXpMeta =
      const VerificationMeta('dailyXp');
  @override
  late final GeneratedColumn<int> dailyXp = GeneratedColumn<int>(
      'daily_xp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastXpDateMeta =
      const VerificationMeta('lastXpDate');
  @override
  late final GeneratedColumn<DateTime> lastXpDate = GeneratedColumn<DateTime>(
      'last_xp_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _totalQuizzesCompletedMeta =
      const VerificationMeta('totalQuizzesCompleted');
  @override
  late final GeneratedColumn<int> totalQuizzesCompleted = GeneratedColumn<int>(
      'total_quizzes_completed', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalCorrectAnswersMeta =
      const VerificationMeta('totalCorrectAnswers');
  @override
  late final GeneratedColumn<int> totalCorrectAnswers = GeneratedColumn<int>(
      'total_correct_answers', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalItemsMasteredMeta =
      const VerificationMeta('totalItemsMastered');
  @override
  late final GeneratedColumn<int> totalItemsMastered = GeneratedColumn<int>(
      'total_items_mastered', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        currentLevel,
        totalXp,
        dailyXp,
        lastXpDate,
        totalQuizzesCompleted,
        totalCorrectAnswers,
        totalItemsMastered,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_level_progress';
  @override
  VerificationContext validateIntegrity(
      Insertable<UserLevelProgressData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('current_level')) {
      context.handle(
          _currentLevelMeta,
          currentLevel.isAcceptableOrUnknown(
              data['current_level']!, _currentLevelMeta));
    }
    if (data.containsKey('total_xp')) {
      context.handle(_totalXpMeta,
          totalXp.isAcceptableOrUnknown(data['total_xp']!, _totalXpMeta));
    }
    if (data.containsKey('daily_xp')) {
      context.handle(_dailyXpMeta,
          dailyXp.isAcceptableOrUnknown(data['daily_xp']!, _dailyXpMeta));
    }
    if (data.containsKey('last_xp_date')) {
      context.handle(
          _lastXpDateMeta,
          lastXpDate.isAcceptableOrUnknown(
              data['last_xp_date']!, _lastXpDateMeta));
    }
    if (data.containsKey('total_quizzes_completed')) {
      context.handle(
          _totalQuizzesCompletedMeta,
          totalQuizzesCompleted.isAcceptableOrUnknown(
              data['total_quizzes_completed']!, _totalQuizzesCompletedMeta));
    }
    if (data.containsKey('total_correct_answers')) {
      context.handle(
          _totalCorrectAnswersMeta,
          totalCorrectAnswers.isAcceptableOrUnknown(
              data['total_correct_answers']!, _totalCorrectAnswersMeta));
    }
    if (data.containsKey('total_items_mastered')) {
      context.handle(
          _totalItemsMasteredMeta,
          totalItemsMastered.isAcceptableOrUnknown(
              data['total_items_mastered']!, _totalItemsMasteredMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserLevelProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserLevelProgressData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      currentLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_level'])!,
      totalXp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_xp'])!,
      dailyXp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}daily_xp'])!,
      lastXpDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_xp_date']),
      totalQuizzesCompleted: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_quizzes_completed'])!,
      totalCorrectAnswers: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_correct_answers'])!,
      totalItemsMastered: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_items_mastered'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UserLevelProgressTable createAlias(String alias) {
    return $UserLevelProgressTable(attachedDatabase, alias);
  }
}

class UserLevelProgressData extends DataClass
    implements Insertable<UserLevelProgressData> {
  /// Singleton (always row 1)
  final int id;

  /// Current level 1-50
  final int currentLevel;

  /// Lifetime accumulated XP
  final int totalXp;

  /// XP earned today (resets daily)
  final int dailyXp;

  /// For daily reset detection
  final DateTime? lastXpDate;

  /// Lifetime quiz count
  final int totalQuizzesCompleted;

  /// Lifetime correct count
  final int totalCorrectAnswers;

  /// Total mastered items
  final int totalItemsMastered;

  /// Last update timestamp
  final DateTime updatedAt;
  const UserLevelProgressData(
      {required this.id,
      required this.currentLevel,
      required this.totalXp,
      required this.dailyXp,
      this.lastXpDate,
      required this.totalQuizzesCompleted,
      required this.totalCorrectAnswers,
      required this.totalItemsMastered,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['current_level'] = Variable<int>(currentLevel);
    map['total_xp'] = Variable<int>(totalXp);
    map['daily_xp'] = Variable<int>(dailyXp);
    if (!nullToAbsent || lastXpDate != null) {
      map['last_xp_date'] = Variable<DateTime>(lastXpDate);
    }
    map['total_quizzes_completed'] = Variable<int>(totalQuizzesCompleted);
    map['total_correct_answers'] = Variable<int>(totalCorrectAnswers);
    map['total_items_mastered'] = Variable<int>(totalItemsMastered);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserLevelProgressCompanion toCompanion(bool nullToAbsent) {
    return UserLevelProgressCompanion(
      id: Value(id),
      currentLevel: Value(currentLevel),
      totalXp: Value(totalXp),
      dailyXp: Value(dailyXp),
      lastXpDate: lastXpDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastXpDate),
      totalQuizzesCompleted: Value(totalQuizzesCompleted),
      totalCorrectAnswers: Value(totalCorrectAnswers),
      totalItemsMastered: Value(totalItemsMastered),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserLevelProgressData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserLevelProgressData(
      id: serializer.fromJson<int>(json['id']),
      currentLevel: serializer.fromJson<int>(json['currentLevel']),
      totalXp: serializer.fromJson<int>(json['totalXp']),
      dailyXp: serializer.fromJson<int>(json['dailyXp']),
      lastXpDate: serializer.fromJson<DateTime?>(json['lastXpDate']),
      totalQuizzesCompleted:
          serializer.fromJson<int>(json['totalQuizzesCompleted']),
      totalCorrectAnswers:
          serializer.fromJson<int>(json['totalCorrectAnswers']),
      totalItemsMastered: serializer.fromJson<int>(json['totalItemsMastered']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currentLevel': serializer.toJson<int>(currentLevel),
      'totalXp': serializer.toJson<int>(totalXp),
      'dailyXp': serializer.toJson<int>(dailyXp),
      'lastXpDate': serializer.toJson<DateTime?>(lastXpDate),
      'totalQuizzesCompleted': serializer.toJson<int>(totalQuizzesCompleted),
      'totalCorrectAnswers': serializer.toJson<int>(totalCorrectAnswers),
      'totalItemsMastered': serializer.toJson<int>(totalItemsMastered),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserLevelProgressData copyWith(
          {int? id,
          int? currentLevel,
          int? totalXp,
          int? dailyXp,
          Value<DateTime?> lastXpDate = const Value.absent(),
          int? totalQuizzesCompleted,
          int? totalCorrectAnswers,
          int? totalItemsMastered,
          DateTime? updatedAt}) =>
      UserLevelProgressData(
        id: id ?? this.id,
        currentLevel: currentLevel ?? this.currentLevel,
        totalXp: totalXp ?? this.totalXp,
        dailyXp: dailyXp ?? this.dailyXp,
        lastXpDate: lastXpDate.present ? lastXpDate.value : this.lastXpDate,
        totalQuizzesCompleted:
            totalQuizzesCompleted ?? this.totalQuizzesCompleted,
        totalCorrectAnswers: totalCorrectAnswers ?? this.totalCorrectAnswers,
        totalItemsMastered: totalItemsMastered ?? this.totalItemsMastered,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UserLevelProgressData copyWithCompanion(UserLevelProgressCompanion data) {
    return UserLevelProgressData(
      id: data.id.present ? data.id.value : this.id,
      currentLevel: data.currentLevel.present
          ? data.currentLevel.value
          : this.currentLevel,
      totalXp: data.totalXp.present ? data.totalXp.value : this.totalXp,
      dailyXp: data.dailyXp.present ? data.dailyXp.value : this.dailyXp,
      lastXpDate:
          data.lastXpDate.present ? data.lastXpDate.value : this.lastXpDate,
      totalQuizzesCompleted: data.totalQuizzesCompleted.present
          ? data.totalQuizzesCompleted.value
          : this.totalQuizzesCompleted,
      totalCorrectAnswers: data.totalCorrectAnswers.present
          ? data.totalCorrectAnswers.value
          : this.totalCorrectAnswers,
      totalItemsMastered: data.totalItemsMastered.present
          ? data.totalItemsMastered.value
          : this.totalItemsMastered,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserLevelProgressData(')
          ..write('id: $id, ')
          ..write('currentLevel: $currentLevel, ')
          ..write('totalXp: $totalXp, ')
          ..write('dailyXp: $dailyXp, ')
          ..write('lastXpDate: $lastXpDate, ')
          ..write('totalQuizzesCompleted: $totalQuizzesCompleted, ')
          ..write('totalCorrectAnswers: $totalCorrectAnswers, ')
          ..write('totalItemsMastered: $totalItemsMastered, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      currentLevel,
      totalXp,
      dailyXp,
      lastXpDate,
      totalQuizzesCompleted,
      totalCorrectAnswers,
      totalItemsMastered,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserLevelProgressData &&
          other.id == this.id &&
          other.currentLevel == this.currentLevel &&
          other.totalXp == this.totalXp &&
          other.dailyXp == this.dailyXp &&
          other.lastXpDate == this.lastXpDate &&
          other.totalQuizzesCompleted == this.totalQuizzesCompleted &&
          other.totalCorrectAnswers == this.totalCorrectAnswers &&
          other.totalItemsMastered == this.totalItemsMastered &&
          other.updatedAt == this.updatedAt);
}

class UserLevelProgressCompanion
    extends UpdateCompanion<UserLevelProgressData> {
  final Value<int> id;
  final Value<int> currentLevel;
  final Value<int> totalXp;
  final Value<int> dailyXp;
  final Value<DateTime?> lastXpDate;
  final Value<int> totalQuizzesCompleted;
  final Value<int> totalCorrectAnswers;
  final Value<int> totalItemsMastered;
  final Value<DateTime> updatedAt;
  const UserLevelProgressCompanion({
    this.id = const Value.absent(),
    this.currentLevel = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.dailyXp = const Value.absent(),
    this.lastXpDate = const Value.absent(),
    this.totalQuizzesCompleted = const Value.absent(),
    this.totalCorrectAnswers = const Value.absent(),
    this.totalItemsMastered = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserLevelProgressCompanion.insert({
    this.id = const Value.absent(),
    this.currentLevel = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.dailyXp = const Value.absent(),
    this.lastXpDate = const Value.absent(),
    this.totalQuizzesCompleted = const Value.absent(),
    this.totalCorrectAnswers = const Value.absent(),
    this.totalItemsMastered = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<UserLevelProgressData> custom({
    Expression<int>? id,
    Expression<int>? currentLevel,
    Expression<int>? totalXp,
    Expression<int>? dailyXp,
    Expression<DateTime>? lastXpDate,
    Expression<int>? totalQuizzesCompleted,
    Expression<int>? totalCorrectAnswers,
    Expression<int>? totalItemsMastered,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currentLevel != null) 'current_level': currentLevel,
      if (totalXp != null) 'total_xp': totalXp,
      if (dailyXp != null) 'daily_xp': dailyXp,
      if (lastXpDate != null) 'last_xp_date': lastXpDate,
      if (totalQuizzesCompleted != null)
        'total_quizzes_completed': totalQuizzesCompleted,
      if (totalCorrectAnswers != null)
        'total_correct_answers': totalCorrectAnswers,
      if (totalItemsMastered != null)
        'total_items_mastered': totalItemsMastered,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserLevelProgressCompanion copyWith(
      {Value<int>? id,
      Value<int>? currentLevel,
      Value<int>? totalXp,
      Value<int>? dailyXp,
      Value<DateTime?>? lastXpDate,
      Value<int>? totalQuizzesCompleted,
      Value<int>? totalCorrectAnswers,
      Value<int>? totalItemsMastered,
      Value<DateTime>? updatedAt}) {
    return UserLevelProgressCompanion(
      id: id ?? this.id,
      currentLevel: currentLevel ?? this.currentLevel,
      totalXp: totalXp ?? this.totalXp,
      dailyXp: dailyXp ?? this.dailyXp,
      lastXpDate: lastXpDate ?? this.lastXpDate,
      totalQuizzesCompleted:
          totalQuizzesCompleted ?? this.totalQuizzesCompleted,
      totalCorrectAnswers: totalCorrectAnswers ?? this.totalCorrectAnswers,
      totalItemsMastered: totalItemsMastered ?? this.totalItemsMastered,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currentLevel.present) {
      map['current_level'] = Variable<int>(currentLevel.value);
    }
    if (totalXp.present) {
      map['total_xp'] = Variable<int>(totalXp.value);
    }
    if (dailyXp.present) {
      map['daily_xp'] = Variable<int>(dailyXp.value);
    }
    if (lastXpDate.present) {
      map['last_xp_date'] = Variable<DateTime>(lastXpDate.value);
    }
    if (totalQuizzesCompleted.present) {
      map['total_quizzes_completed'] =
          Variable<int>(totalQuizzesCompleted.value);
    }
    if (totalCorrectAnswers.present) {
      map['total_correct_answers'] = Variable<int>(totalCorrectAnswers.value);
    }
    if (totalItemsMastered.present) {
      map['total_items_mastered'] = Variable<int>(totalItemsMastered.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserLevelProgressCompanion(')
          ..write('id: $id, ')
          ..write('currentLevel: $currentLevel, ')
          ..write('totalXp: $totalXp, ')
          ..write('dailyXp: $dailyXp, ')
          ..write('lastXpDate: $lastXpDate, ')
          ..write('totalQuizzesCompleted: $totalQuizzesCompleted, ')
          ..write('totalCorrectAnswers: $totalCorrectAnswers, ')
          ..write('totalItemsMastered: $totalItemsMastered, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $XpTransactionsTable extends XpTransactions
    with TableInfo<$XpTransactionsTable, XpTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $XpTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _referenceIdMeta =
      const VerificationMeta('referenceId');
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
      'reference_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _levelAtTimeMeta =
      const VerificationMeta('levelAtTime');
  @override
  late final GeneratedColumn<int> levelAtTime = GeneratedColumn<int>(
      'level_at_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _earnedAtMeta =
      const VerificationMeta('earnedAt');
  @override
  late final GeneratedColumn<DateTime> earnedAt = GeneratedColumn<DateTime>(
      'earned_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, amount, source, referenceId, levelAtTime, earnedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'xp_transactions';
  @override
  VerificationContext validateIntegrity(Insertable<XpTransaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('reference_id')) {
      context.handle(
          _referenceIdMeta,
          referenceId.isAcceptableOrUnknown(
              data['reference_id']!, _referenceIdMeta));
    }
    if (data.containsKey('level_at_time')) {
      context.handle(
          _levelAtTimeMeta,
          levelAtTime.isAcceptableOrUnknown(
              data['level_at_time']!, _levelAtTimeMeta));
    } else if (isInserting) {
      context.missing(_levelAtTimeMeta);
    }
    if (data.containsKey('earned_at')) {
      context.handle(_earnedAtMeta,
          earnedAt.isAcceptableOrUnknown(data['earned_at']!, _earnedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  XpTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return XpTransaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      referenceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference_id']),
      levelAtTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level_at_time'])!,
      earnedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}earned_at'])!,
    );
  }

  @override
  $XpTransactionsTable createAlias(String alias) {
    return $XpTransactionsTable(attachedDatabase, alias);
  }
}

class XpTransaction extends DataClass implements Insertable<XpTransaction> {
  final int id;

  /// XP awarded
  final int amount;

  /// 'quiz_complete', 'perfect_quiz', 'mastery_bonus', 'streak_bonus'
  final String source;

  /// Optional quiz/question reference
  final String? referenceId;

  /// User level when earned
  final int levelAtTime;

  /// Timestamp
  final DateTime earnedAt;
  const XpTransaction(
      {required this.id,
      required this.amount,
      required this.source,
      this.referenceId,
      required this.levelAtTime,
      required this.earnedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<int>(amount);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<String>(referenceId);
    }
    map['level_at_time'] = Variable<int>(levelAtTime);
    map['earned_at'] = Variable<DateTime>(earnedAt);
    return map;
  }

  XpTransactionsCompanion toCompanion(bool nullToAbsent) {
    return XpTransactionsCompanion(
      id: Value(id),
      amount: Value(amount),
      source: Value(source),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      levelAtTime: Value(levelAtTime),
      earnedAt: Value(earnedAt),
    );
  }

  factory XpTransaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return XpTransaction(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<int>(json['amount']),
      source: serializer.fromJson<String>(json['source']),
      referenceId: serializer.fromJson<String?>(json['referenceId']),
      levelAtTime: serializer.fromJson<int>(json['levelAtTime']),
      earnedAt: serializer.fromJson<DateTime>(json['earnedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<int>(amount),
      'source': serializer.toJson<String>(source),
      'referenceId': serializer.toJson<String?>(referenceId),
      'levelAtTime': serializer.toJson<int>(levelAtTime),
      'earnedAt': serializer.toJson<DateTime>(earnedAt),
    };
  }

  XpTransaction copyWith(
          {int? id,
          int? amount,
          String? source,
          Value<String?> referenceId = const Value.absent(),
          int? levelAtTime,
          DateTime? earnedAt}) =>
      XpTransaction(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        source: source ?? this.source,
        referenceId: referenceId.present ? referenceId.value : this.referenceId,
        levelAtTime: levelAtTime ?? this.levelAtTime,
        earnedAt: earnedAt ?? this.earnedAt,
      );
  XpTransaction copyWithCompanion(XpTransactionsCompanion data) {
    return XpTransaction(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      source: data.source.present ? data.source.value : this.source,
      referenceId:
          data.referenceId.present ? data.referenceId.value : this.referenceId,
      levelAtTime:
          data.levelAtTime.present ? data.levelAtTime.value : this.levelAtTime,
      earnedAt: data.earnedAt.present ? data.earnedAt.value : this.earnedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('XpTransaction(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('source: $source, ')
          ..write('referenceId: $referenceId, ')
          ..write('levelAtTime: $levelAtTime, ')
          ..write('earnedAt: $earnedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, amount, source, referenceId, levelAtTime, earnedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is XpTransaction &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.source == this.source &&
          other.referenceId == this.referenceId &&
          other.levelAtTime == this.levelAtTime &&
          other.earnedAt == this.earnedAt);
}

class XpTransactionsCompanion extends UpdateCompanion<XpTransaction> {
  final Value<int> id;
  final Value<int> amount;
  final Value<String> source;
  final Value<String?> referenceId;
  final Value<int> levelAtTime;
  final Value<DateTime> earnedAt;
  const XpTransactionsCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.source = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.levelAtTime = const Value.absent(),
    this.earnedAt = const Value.absent(),
  });
  XpTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int amount,
    required String source,
    this.referenceId = const Value.absent(),
    required int levelAtTime,
    this.earnedAt = const Value.absent(),
  })  : amount = Value(amount),
        source = Value(source),
        levelAtTime = Value(levelAtTime);
  static Insertable<XpTransaction> custom({
    Expression<int>? id,
    Expression<int>? amount,
    Expression<String>? source,
    Expression<String>? referenceId,
    Expression<int>? levelAtTime,
    Expression<DateTime>? earnedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (source != null) 'source': source,
      if (referenceId != null) 'reference_id': referenceId,
      if (levelAtTime != null) 'level_at_time': levelAtTime,
      if (earnedAt != null) 'earned_at': earnedAt,
    });
  }

  XpTransactionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? amount,
      Value<String>? source,
      Value<String?>? referenceId,
      Value<int>? levelAtTime,
      Value<DateTime>? earnedAt}) {
    return XpTransactionsCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      source: source ?? this.source,
      referenceId: referenceId ?? this.referenceId,
      levelAtTime: levelAtTime ?? this.levelAtTime,
      earnedAt: earnedAt ?? this.earnedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (levelAtTime.present) {
      map['level_at_time'] = Variable<int>(levelAtTime.value);
    }
    if (earnedAt.present) {
      map['earned_at'] = Variable<DateTime>(earnedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('XpTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('source: $source, ')
          ..write('referenceId: $referenceId, ')
          ..write('levelAtTime: $levelAtTime, ')
          ..write('earnedAt: $earnedAt')
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
  late final $VocabularyItemsTable vocabularyItems =
      $VocabularyItemsTable(this);
  late final $UserLevelProgressTable userLevelProgress =
      $UserLevelProgressTable(this);
  late final $XpTransactionsTable xpTransactions = $XpTransactionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        alarms,
        quizProgress,
        alarmHistory,
        vocabularyItems,
        userLevelProgress,
        xpTransactions
      ];
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
typedef $$VocabularyItemsTableCreateCompanionBuilder = VocabularyItemsCompanion
    Function({
  Value<int> id,
  required String questionId,
  required String type,
  required String category,
  required String difficulty,
  required String question,
  required String questionKo,
  required String options,
  required String correctAnswer,
  Value<String?> hint,
  Value<String?> explanation,
  Value<String?> explanationKo,
  Value<String?> source,
  Value<String?> sourceUrl,
  Value<String?> sourceLabel,
  Value<int> timesPresented,
  Value<int> timesCorrectFirstAttempt,
  Value<int> timesIncorrect,
  Value<bool> isMastered,
  Value<DateTime?> lastPresentedAt,
  Value<DateTime?> masteredAt,
  Value<bool> isFree,
  Value<int> unlockLevel,
  Value<DateTime> createdAt,
});
typedef $$VocabularyItemsTableUpdateCompanionBuilder = VocabularyItemsCompanion
    Function({
  Value<int> id,
  Value<String> questionId,
  Value<String> type,
  Value<String> category,
  Value<String> difficulty,
  Value<String> question,
  Value<String> questionKo,
  Value<String> options,
  Value<String> correctAnswer,
  Value<String?> hint,
  Value<String?> explanation,
  Value<String?> explanationKo,
  Value<String?> source,
  Value<String?> sourceUrl,
  Value<String?> sourceLabel,
  Value<int> timesPresented,
  Value<int> timesCorrectFirstAttempt,
  Value<int> timesIncorrect,
  Value<bool> isMastered,
  Value<DateTime?> lastPresentedAt,
  Value<DateTime?> masteredAt,
  Value<bool> isFree,
  Value<int> unlockLevel,
  Value<DateTime> createdAt,
});

class $$VocabularyItemsTableFilterComposer
    extends Composer<_$AppDatabase, $VocabularyItemsTable> {
  $$VocabularyItemsTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get question => $composableBuilder(
      column: $table.question, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get questionKo => $composableBuilder(
      column: $table.questionKo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get options => $composableBuilder(
      column: $table.options, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get correctAnswer => $composableBuilder(
      column: $table.correctAnswer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hint => $composableBuilder(
      column: $table.hint, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get explanationKo => $composableBuilder(
      column: $table.explanationKo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceUrl => $composableBuilder(
      column: $table.sourceUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceLabel => $composableBuilder(
      column: $table.sourceLabel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timesPresented => $composableBuilder(
      column: $table.timesPresented,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timesCorrectFirstAttempt => $composableBuilder(
      column: $table.timesCorrectFirstAttempt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timesIncorrect => $composableBuilder(
      column: $table.timesIncorrect,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isMastered => $composableBuilder(
      column: $table.isMastered, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastPresentedAt => $composableBuilder(
      column: $table.lastPresentedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get masteredAt => $composableBuilder(
      column: $table.masteredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFree => $composableBuilder(
      column: $table.isFree, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get unlockLevel => $composableBuilder(
      column: $table.unlockLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$VocabularyItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabularyItemsTable> {
  $$VocabularyItemsTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get question => $composableBuilder(
      column: $table.question, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get questionKo => $composableBuilder(
      column: $table.questionKo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get options => $composableBuilder(
      column: $table.options, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get correctAnswer => $composableBuilder(
      column: $table.correctAnswer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hint => $composableBuilder(
      column: $table.hint, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get explanationKo => $composableBuilder(
      column: $table.explanationKo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceUrl => $composableBuilder(
      column: $table.sourceUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceLabel => $composableBuilder(
      column: $table.sourceLabel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timesPresented => $composableBuilder(
      column: $table.timesPresented,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timesCorrectFirstAttempt => $composableBuilder(
      column: $table.timesCorrectFirstAttempt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timesIncorrect => $composableBuilder(
      column: $table.timesIncorrect,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isMastered => $composableBuilder(
      column: $table.isMastered, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastPresentedAt => $composableBuilder(
      column: $table.lastPresentedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get masteredAt => $composableBuilder(
      column: $table.masteredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFree => $composableBuilder(
      column: $table.isFree, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unlockLevel => $composableBuilder(
      column: $table.unlockLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$VocabularyItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabularyItemsTable> {
  $$VocabularyItemsTableAnnotationComposer({
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

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<String> get question =>
      $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<String> get questionKo => $composableBuilder(
      column: $table.questionKo, builder: (column) => column);

  GeneratedColumn<String> get options =>
      $composableBuilder(column: $table.options, builder: (column) => column);

  GeneratedColumn<String> get correctAnswer => $composableBuilder(
      column: $table.correctAnswer, builder: (column) => column);

  GeneratedColumn<String> get hint =>
      $composableBuilder(column: $table.hint, builder: (column) => column);

  GeneratedColumn<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => column);

  GeneratedColumn<String> get explanationKo => $composableBuilder(
      column: $table.explanationKo, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceUrl =>
      $composableBuilder(column: $table.sourceUrl, builder: (column) => column);

  GeneratedColumn<String> get sourceLabel => $composableBuilder(
      column: $table.sourceLabel, builder: (column) => column);

  GeneratedColumn<int> get timesPresented => $composableBuilder(
      column: $table.timesPresented, builder: (column) => column);

  GeneratedColumn<int> get timesCorrectFirstAttempt => $composableBuilder(
      column: $table.timesCorrectFirstAttempt, builder: (column) => column);

  GeneratedColumn<int> get timesIncorrect => $composableBuilder(
      column: $table.timesIncorrect, builder: (column) => column);

  GeneratedColumn<bool> get isMastered => $composableBuilder(
      column: $table.isMastered, builder: (column) => column);

  GeneratedColumn<DateTime> get lastPresentedAt => $composableBuilder(
      column: $table.lastPresentedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get masteredAt => $composableBuilder(
      column: $table.masteredAt, builder: (column) => column);

  GeneratedColumn<bool> get isFree =>
      $composableBuilder(column: $table.isFree, builder: (column) => column);

  GeneratedColumn<int> get unlockLevel => $composableBuilder(
      column: $table.unlockLevel, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$VocabularyItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VocabularyItemsTable,
    VocabularyItem,
    $$VocabularyItemsTableFilterComposer,
    $$VocabularyItemsTableOrderingComposer,
    $$VocabularyItemsTableAnnotationComposer,
    $$VocabularyItemsTableCreateCompanionBuilder,
    $$VocabularyItemsTableUpdateCompanionBuilder,
    (
      VocabularyItem,
      BaseReferences<_$AppDatabase, $VocabularyItemsTable, VocabularyItem>
    ),
    VocabularyItem,
    PrefetchHooks Function()> {
  $$VocabularyItemsTableTableManager(
      _$AppDatabase db, $VocabularyItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VocabularyItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VocabularyItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VocabularyItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> questionId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> difficulty = const Value.absent(),
            Value<String> question = const Value.absent(),
            Value<String> questionKo = const Value.absent(),
            Value<String> options = const Value.absent(),
            Value<String> correctAnswer = const Value.absent(),
            Value<String?> hint = const Value.absent(),
            Value<String?> explanation = const Value.absent(),
            Value<String?> explanationKo = const Value.absent(),
            Value<String?> source = const Value.absent(),
            Value<String?> sourceUrl = const Value.absent(),
            Value<String?> sourceLabel = const Value.absent(),
            Value<int> timesPresented = const Value.absent(),
            Value<int> timesCorrectFirstAttempt = const Value.absent(),
            Value<int> timesIncorrect = const Value.absent(),
            Value<bool> isMastered = const Value.absent(),
            Value<DateTime?> lastPresentedAt = const Value.absent(),
            Value<DateTime?> masteredAt = const Value.absent(),
            Value<bool> isFree = const Value.absent(),
            Value<int> unlockLevel = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              VocabularyItemsCompanion(
            id: id,
            questionId: questionId,
            type: type,
            category: category,
            difficulty: difficulty,
            question: question,
            questionKo: questionKo,
            options: options,
            correctAnswer: correctAnswer,
            hint: hint,
            explanation: explanation,
            explanationKo: explanationKo,
            source: source,
            sourceUrl: sourceUrl,
            sourceLabel: sourceLabel,
            timesPresented: timesPresented,
            timesCorrectFirstAttempt: timesCorrectFirstAttempt,
            timesIncorrect: timesIncorrect,
            isMastered: isMastered,
            lastPresentedAt: lastPresentedAt,
            masteredAt: masteredAt,
            isFree: isFree,
            unlockLevel: unlockLevel,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String questionId,
            required String type,
            required String category,
            required String difficulty,
            required String question,
            required String questionKo,
            required String options,
            required String correctAnswer,
            Value<String?> hint = const Value.absent(),
            Value<String?> explanation = const Value.absent(),
            Value<String?> explanationKo = const Value.absent(),
            Value<String?> source = const Value.absent(),
            Value<String?> sourceUrl = const Value.absent(),
            Value<String?> sourceLabel = const Value.absent(),
            Value<int> timesPresented = const Value.absent(),
            Value<int> timesCorrectFirstAttempt = const Value.absent(),
            Value<int> timesIncorrect = const Value.absent(),
            Value<bool> isMastered = const Value.absent(),
            Value<DateTime?> lastPresentedAt = const Value.absent(),
            Value<DateTime?> masteredAt = const Value.absent(),
            Value<bool> isFree = const Value.absent(),
            Value<int> unlockLevel = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              VocabularyItemsCompanion.insert(
            id: id,
            questionId: questionId,
            type: type,
            category: category,
            difficulty: difficulty,
            question: question,
            questionKo: questionKo,
            options: options,
            correctAnswer: correctAnswer,
            hint: hint,
            explanation: explanation,
            explanationKo: explanationKo,
            source: source,
            sourceUrl: sourceUrl,
            sourceLabel: sourceLabel,
            timesPresented: timesPresented,
            timesCorrectFirstAttempt: timesCorrectFirstAttempt,
            timesIncorrect: timesIncorrect,
            isMastered: isMastered,
            lastPresentedAt: lastPresentedAt,
            masteredAt: masteredAt,
            isFree: isFree,
            unlockLevel: unlockLevel,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$VocabularyItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VocabularyItemsTable,
    VocabularyItem,
    $$VocabularyItemsTableFilterComposer,
    $$VocabularyItemsTableOrderingComposer,
    $$VocabularyItemsTableAnnotationComposer,
    $$VocabularyItemsTableCreateCompanionBuilder,
    $$VocabularyItemsTableUpdateCompanionBuilder,
    (
      VocabularyItem,
      BaseReferences<_$AppDatabase, $VocabularyItemsTable, VocabularyItem>
    ),
    VocabularyItem,
    PrefetchHooks Function()>;
typedef $$UserLevelProgressTableCreateCompanionBuilder
    = UserLevelProgressCompanion Function({
  Value<int> id,
  Value<int> currentLevel,
  Value<int> totalXp,
  Value<int> dailyXp,
  Value<DateTime?> lastXpDate,
  Value<int> totalQuizzesCompleted,
  Value<int> totalCorrectAnswers,
  Value<int> totalItemsMastered,
  Value<DateTime> updatedAt,
});
typedef $$UserLevelProgressTableUpdateCompanionBuilder
    = UserLevelProgressCompanion Function({
  Value<int> id,
  Value<int> currentLevel,
  Value<int> totalXp,
  Value<int> dailyXp,
  Value<DateTime?> lastXpDate,
  Value<int> totalQuizzesCompleted,
  Value<int> totalCorrectAnswers,
  Value<int> totalItemsMastered,
  Value<DateTime> updatedAt,
});

class $$UserLevelProgressTableFilterComposer
    extends Composer<_$AppDatabase, $UserLevelProgressTable> {
  $$UserLevelProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentLevel => $composableBuilder(
      column: $table.currentLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalXp => $composableBuilder(
      column: $table.totalXp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dailyXp => $composableBuilder(
      column: $table.dailyXp, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastXpDate => $composableBuilder(
      column: $table.lastXpDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalQuizzesCompleted => $composableBuilder(
      column: $table.totalQuizzesCompleted,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalCorrectAnswers => $composableBuilder(
      column: $table.totalCorrectAnswers,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalItemsMastered => $composableBuilder(
      column: $table.totalItemsMastered,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$UserLevelProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $UserLevelProgressTable> {
  $$UserLevelProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentLevel => $composableBuilder(
      column: $table.currentLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalXp => $composableBuilder(
      column: $table.totalXp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dailyXp => $composableBuilder(
      column: $table.dailyXp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastXpDate => $composableBuilder(
      column: $table.lastXpDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalQuizzesCompleted => $composableBuilder(
      column: $table.totalQuizzesCompleted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalCorrectAnswers => $composableBuilder(
      column: $table.totalCorrectAnswers,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalItemsMastered => $composableBuilder(
      column: $table.totalItemsMastered,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UserLevelProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserLevelProgressTable> {
  $$UserLevelProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get currentLevel => $composableBuilder(
      column: $table.currentLevel, builder: (column) => column);

  GeneratedColumn<int> get totalXp =>
      $composableBuilder(column: $table.totalXp, builder: (column) => column);

  GeneratedColumn<int> get dailyXp =>
      $composableBuilder(column: $table.dailyXp, builder: (column) => column);

  GeneratedColumn<DateTime> get lastXpDate => $composableBuilder(
      column: $table.lastXpDate, builder: (column) => column);

  GeneratedColumn<int> get totalQuizzesCompleted => $composableBuilder(
      column: $table.totalQuizzesCompleted, builder: (column) => column);

  GeneratedColumn<int> get totalCorrectAnswers => $composableBuilder(
      column: $table.totalCorrectAnswers, builder: (column) => column);

  GeneratedColumn<int> get totalItemsMastered => $composableBuilder(
      column: $table.totalItemsMastered, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserLevelProgressTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserLevelProgressTable,
    UserLevelProgressData,
    $$UserLevelProgressTableFilterComposer,
    $$UserLevelProgressTableOrderingComposer,
    $$UserLevelProgressTableAnnotationComposer,
    $$UserLevelProgressTableCreateCompanionBuilder,
    $$UserLevelProgressTableUpdateCompanionBuilder,
    (
      UserLevelProgressData,
      BaseReferences<_$AppDatabase, $UserLevelProgressTable,
          UserLevelProgressData>
    ),
    UserLevelProgressData,
    PrefetchHooks Function()> {
  $$UserLevelProgressTableTableManager(
      _$AppDatabase db, $UserLevelProgressTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserLevelProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserLevelProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserLevelProgressTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> currentLevel = const Value.absent(),
            Value<int> totalXp = const Value.absent(),
            Value<int> dailyXp = const Value.absent(),
            Value<DateTime?> lastXpDate = const Value.absent(),
            Value<int> totalQuizzesCompleted = const Value.absent(),
            Value<int> totalCorrectAnswers = const Value.absent(),
            Value<int> totalItemsMastered = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UserLevelProgressCompanion(
            id: id,
            currentLevel: currentLevel,
            totalXp: totalXp,
            dailyXp: dailyXp,
            lastXpDate: lastXpDate,
            totalQuizzesCompleted: totalQuizzesCompleted,
            totalCorrectAnswers: totalCorrectAnswers,
            totalItemsMastered: totalItemsMastered,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> currentLevel = const Value.absent(),
            Value<int> totalXp = const Value.absent(),
            Value<int> dailyXp = const Value.absent(),
            Value<DateTime?> lastXpDate = const Value.absent(),
            Value<int> totalQuizzesCompleted = const Value.absent(),
            Value<int> totalCorrectAnswers = const Value.absent(),
            Value<int> totalItemsMastered = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UserLevelProgressCompanion.insert(
            id: id,
            currentLevel: currentLevel,
            totalXp: totalXp,
            dailyXp: dailyXp,
            lastXpDate: lastXpDate,
            totalQuizzesCompleted: totalQuizzesCompleted,
            totalCorrectAnswers: totalCorrectAnswers,
            totalItemsMastered: totalItemsMastered,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserLevelProgressTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserLevelProgressTable,
    UserLevelProgressData,
    $$UserLevelProgressTableFilterComposer,
    $$UserLevelProgressTableOrderingComposer,
    $$UserLevelProgressTableAnnotationComposer,
    $$UserLevelProgressTableCreateCompanionBuilder,
    $$UserLevelProgressTableUpdateCompanionBuilder,
    (
      UserLevelProgressData,
      BaseReferences<_$AppDatabase, $UserLevelProgressTable,
          UserLevelProgressData>
    ),
    UserLevelProgressData,
    PrefetchHooks Function()>;
typedef $$XpTransactionsTableCreateCompanionBuilder = XpTransactionsCompanion
    Function({
  Value<int> id,
  required int amount,
  required String source,
  Value<String?> referenceId,
  required int levelAtTime,
  Value<DateTime> earnedAt,
});
typedef $$XpTransactionsTableUpdateCompanionBuilder = XpTransactionsCompanion
    Function({
  Value<int> id,
  Value<int> amount,
  Value<String> source,
  Value<String?> referenceId,
  Value<int> levelAtTime,
  Value<DateTime> earnedAt,
});

class $$XpTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $XpTransactionsTable> {
  $$XpTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get referenceId => $composableBuilder(
      column: $table.referenceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get levelAtTime => $composableBuilder(
      column: $table.levelAtTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get earnedAt => $composableBuilder(
      column: $table.earnedAt, builder: (column) => ColumnFilters(column));
}

class $$XpTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $XpTransactionsTable> {
  $$XpTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get referenceId => $composableBuilder(
      column: $table.referenceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get levelAtTime => $composableBuilder(
      column: $table.levelAtTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get earnedAt => $composableBuilder(
      column: $table.earnedAt, builder: (column) => ColumnOrderings(column));
}

class $$XpTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $XpTransactionsTable> {
  $$XpTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get referenceId => $composableBuilder(
      column: $table.referenceId, builder: (column) => column);

  GeneratedColumn<int> get levelAtTime => $composableBuilder(
      column: $table.levelAtTime, builder: (column) => column);

  GeneratedColumn<DateTime> get earnedAt =>
      $composableBuilder(column: $table.earnedAt, builder: (column) => column);
}

class $$XpTransactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $XpTransactionsTable,
    XpTransaction,
    $$XpTransactionsTableFilterComposer,
    $$XpTransactionsTableOrderingComposer,
    $$XpTransactionsTableAnnotationComposer,
    $$XpTransactionsTableCreateCompanionBuilder,
    $$XpTransactionsTableUpdateCompanionBuilder,
    (
      XpTransaction,
      BaseReferences<_$AppDatabase, $XpTransactionsTable, XpTransaction>
    ),
    XpTransaction,
    PrefetchHooks Function()> {
  $$XpTransactionsTableTableManager(
      _$AppDatabase db, $XpTransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$XpTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$XpTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$XpTransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> referenceId = const Value.absent(),
            Value<int> levelAtTime = const Value.absent(),
            Value<DateTime> earnedAt = const Value.absent(),
          }) =>
              XpTransactionsCompanion(
            id: id,
            amount: amount,
            source: source,
            referenceId: referenceId,
            levelAtTime: levelAtTime,
            earnedAt: earnedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int amount,
            required String source,
            Value<String?> referenceId = const Value.absent(),
            required int levelAtTime,
            Value<DateTime> earnedAt = const Value.absent(),
          }) =>
              XpTransactionsCompanion.insert(
            id: id,
            amount: amount,
            source: source,
            referenceId: referenceId,
            levelAtTime: levelAtTime,
            earnedAt: earnedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$XpTransactionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $XpTransactionsTable,
    XpTransaction,
    $$XpTransactionsTableFilterComposer,
    $$XpTransactionsTableOrderingComposer,
    $$XpTransactionsTableAnnotationComposer,
    $$XpTransactionsTableCreateCompanionBuilder,
    $$XpTransactionsTableUpdateCompanionBuilder,
    (
      XpTransaction,
      BaseReferences<_$AppDatabase, $XpTransactionsTable, XpTransaction>
    ),
    XpTransaction,
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
  $$VocabularyItemsTableTableManager get vocabularyItems =>
      $$VocabularyItemsTableTableManager(_db, _db.vocabularyItems);
  $$UserLevelProgressTableTableManager get userLevelProgress =>
      $$UserLevelProgressTableTableManager(_db, _db.userLevelProgress);
  $$XpTransactionsTableTableManager get xpTransactions =>
      $$XpTransactionsTableTableManager(_db, _db.xpTransactions);
}
