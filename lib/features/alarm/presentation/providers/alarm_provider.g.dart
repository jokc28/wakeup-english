// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$alarmsHash() => r'704be6b5ec2bfc18035272063db101dea536e095';

/// Provider for watching all alarms
///
/// Copied from [alarms].
@ProviderFor(alarms)
final alarmsProvider = AutoDisposeStreamProvider<List<AlarmEntity>>.internal(
  alarms,
  name: r'alarmsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$alarmsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AlarmsRef = AutoDisposeStreamProviderRef<List<AlarmEntity>>;
String _$alarmByIdHash() => r'2b1ad0c43a0d708ef01f17f432b4849b7ad89ac5';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for getting a single alarm by ID
///
/// Copied from [alarmById].
@ProviderFor(alarmById)
const alarmByIdProvider = AlarmByIdFamily();

/// Provider for getting a single alarm by ID
///
/// Copied from [alarmById].
class AlarmByIdFamily extends Family<AsyncValue<AlarmEntity?>> {
  /// Provider for getting a single alarm by ID
  ///
  /// Copied from [alarmById].
  const AlarmByIdFamily();

  /// Provider for getting a single alarm by ID
  ///
  /// Copied from [alarmById].
  AlarmByIdProvider call(
    int id,
  ) {
    return AlarmByIdProvider(
      id,
    );
  }

  @override
  AlarmByIdProvider getProviderOverride(
    covariant AlarmByIdProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'alarmByIdProvider';
}

/// Provider for getting a single alarm by ID
///
/// Copied from [alarmById].
class AlarmByIdProvider extends AutoDisposeFutureProvider<AlarmEntity?> {
  /// Provider for getting a single alarm by ID
  ///
  /// Copied from [alarmById].
  AlarmByIdProvider(
    int id,
  ) : this._internal(
          (ref) => alarmById(
            ref as AlarmByIdRef,
            id,
          ),
          from: alarmByIdProvider,
          name: r'alarmByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$alarmByIdHash,
          dependencies: AlarmByIdFamily._dependencies,
          allTransitiveDependencies: AlarmByIdFamily._allTransitiveDependencies,
          id: id,
        );

  AlarmByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<AlarmEntity?> Function(AlarmByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AlarmByIdProvider._internal(
        (ref) => create(ref as AlarmByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AlarmEntity?> createElement() {
    return _AlarmByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AlarmByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AlarmByIdRef on AutoDisposeFutureProviderRef<AlarmEntity?> {
  /// The parameter `id` of this provider.
  int get id;
}

class _AlarmByIdProviderElement
    extends AutoDisposeFutureProviderElement<AlarmEntity?> with AlarmByIdRef {
  _AlarmByIdProviderElement(super.provider);

  @override
  int get id => (origin as AlarmByIdProvider).id;
}

String _$alarmFormHash() => r'e0ae7edd8e7f5dbc7f6b179ac63efed6d4c1881e';

abstract class _$AlarmForm extends BuildlessAutoDisposeNotifier<AlarmEntity> {
  late final int? alarmId;

  AlarmEntity build({
    int? alarmId,
  });
}

/// Provider for the alarm form state (for create/edit)
///
/// Copied from [AlarmForm].
@ProviderFor(AlarmForm)
const alarmFormProvider = AlarmFormFamily();

/// Provider for the alarm form state (for create/edit)
///
/// Copied from [AlarmForm].
class AlarmFormFamily extends Family<AlarmEntity> {
  /// Provider for the alarm form state (for create/edit)
  ///
  /// Copied from [AlarmForm].
  const AlarmFormFamily();

  /// Provider for the alarm form state (for create/edit)
  ///
  /// Copied from [AlarmForm].
  AlarmFormProvider call({
    int? alarmId,
  }) {
    return AlarmFormProvider(
      alarmId: alarmId,
    );
  }

  @override
  AlarmFormProvider getProviderOverride(
    covariant AlarmFormProvider provider,
  ) {
    return call(
      alarmId: provider.alarmId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'alarmFormProvider';
}

/// Provider for the alarm form state (for create/edit)
///
/// Copied from [AlarmForm].
class AlarmFormProvider
    extends AutoDisposeNotifierProviderImpl<AlarmForm, AlarmEntity> {
  /// Provider for the alarm form state (for create/edit)
  ///
  /// Copied from [AlarmForm].
  AlarmFormProvider({
    int? alarmId,
  }) : this._internal(
          () => AlarmForm()..alarmId = alarmId,
          from: alarmFormProvider,
          name: r'alarmFormProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$alarmFormHash,
          dependencies: AlarmFormFamily._dependencies,
          allTransitiveDependencies: AlarmFormFamily._allTransitiveDependencies,
          alarmId: alarmId,
        );

  AlarmFormProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.alarmId,
  }) : super.internal();

  final int? alarmId;

  @override
  AlarmEntity runNotifierBuild(
    covariant AlarmForm notifier,
  ) {
    return notifier.build(
      alarmId: alarmId,
    );
  }

  @override
  Override overrideWith(AlarmForm Function() create) {
    return ProviderOverride(
      origin: this,
      override: AlarmFormProvider._internal(
        () => create()..alarmId = alarmId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        alarmId: alarmId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<AlarmForm, AlarmEntity> createElement() {
    return _AlarmFormProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AlarmFormProvider && other.alarmId == alarmId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, alarmId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AlarmFormRef on AutoDisposeNotifierProviderRef<AlarmEntity> {
  /// The parameter `alarmId` of this provider.
  int? get alarmId;
}

class _AlarmFormProviderElement
    extends AutoDisposeNotifierProviderElement<AlarmForm, AlarmEntity>
    with AlarmFormRef {
  _AlarmFormProviderElement(super.provider);

  @override
  int? get alarmId => (origin as AlarmFormProvider).alarmId;
}

String _$alarmOperationsHash() => r'f5625d32df4c0ee8e45c395cdd40813236718ac0';

/// Provider for alarm operations (toggle, delete, etc.)
///
/// Copied from [AlarmOperations].
@ProviderFor(AlarmOperations)
final alarmOperationsProvider =
    AutoDisposeAsyncNotifierProvider<AlarmOperations, void>.internal(
  AlarmOperations.new,
  name: r'alarmOperationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$alarmOperationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AlarmOperations = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
