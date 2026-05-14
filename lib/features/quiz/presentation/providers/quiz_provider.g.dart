// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isQuizSolvedHash() => r'32955034a0ba42da76f15976705545d35f6dc93f';

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

/// Provider to check if quiz is solved (for alarm dismissal)
///
/// Copied from [isQuizSolved].
@ProviderFor(isQuizSolved)
const isQuizSolvedProvider = IsQuizSolvedFamily();

/// Provider to check if quiz is solved (for alarm dismissal)
///
/// Copied from [isQuizSolved].
class IsQuizSolvedFamily extends Family<bool> {
  /// Provider to check if quiz is solved (for alarm dismissal)
  ///
  /// Copied from [isQuizSolved].
  const IsQuizSolvedFamily();

  /// Provider to check if quiz is solved (for alarm dismissal)
  ///
  /// Copied from [isQuizSolved].
  IsQuizSolvedProvider call(
    int alarmId,
  ) {
    return IsQuizSolvedProvider(
      alarmId,
    );
  }

  @override
  IsQuizSolvedProvider getProviderOverride(
    covariant IsQuizSolvedProvider provider,
  ) {
    return call(
      provider.alarmId,
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
  String? get name => r'isQuizSolvedProvider';
}

/// Provider to check if quiz is solved (for alarm dismissal)
///
/// Copied from [isQuizSolved].
class IsQuizSolvedProvider extends AutoDisposeProvider<bool> {
  /// Provider to check if quiz is solved (for alarm dismissal)
  ///
  /// Copied from [isQuizSolved].
  IsQuizSolvedProvider(
    int alarmId,
  ) : this._internal(
          (ref) => isQuizSolved(
            ref as IsQuizSolvedRef,
            alarmId,
          ),
          from: isQuizSolvedProvider,
          name: r'isQuizSolvedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isQuizSolvedHash,
          dependencies: IsQuizSolvedFamily._dependencies,
          allTransitiveDependencies:
              IsQuizSolvedFamily._allTransitiveDependencies,
          alarmId: alarmId,
        );

  IsQuizSolvedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.alarmId,
  }) : super.internal();

  final int alarmId;

  @override
  Override overrideWith(
    bool Function(IsQuizSolvedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsQuizSolvedProvider._internal(
        (ref) => create(ref as IsQuizSolvedRef),
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
  AutoDisposeProviderElement<bool> createElement() {
    return _IsQuizSolvedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsQuizSolvedProvider && other.alarmId == alarmId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, alarmId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsQuizSolvedRef on AutoDisposeProviderRef<bool> {
  /// The parameter `alarmId` of this provider.
  int get alarmId;
}

class _IsQuizSolvedProviderElement extends AutoDisposeProviderElement<bool>
    with IsQuizSolvedRef {
  _IsQuizSolvedProviderElement(super.provider);

  @override
  int get alarmId => (origin as IsQuizSolvedProvider).alarmId;
}

String _$quizSessionHash() => r'f2d352fa3cf3e9fbfcfc036fe5b01070bd5f367c';

abstract class _$QuizSession
    extends BuildlessAutoDisposeNotifier<QuizSessionState> {
  late final int alarmId;

  QuizSessionState build(
    int alarmId,
  );
}

/// Provider for the quiz session
///
/// Copied from [QuizSession].
@ProviderFor(QuizSession)
const quizSessionProvider = QuizSessionFamily();

/// Provider for the quiz session
///
/// Copied from [QuizSession].
class QuizSessionFamily extends Family<QuizSessionState> {
  /// Provider for the quiz session
  ///
  /// Copied from [QuizSession].
  const QuizSessionFamily();

  /// Provider for the quiz session
  ///
  /// Copied from [QuizSession].
  QuizSessionProvider call(
    int alarmId,
  ) {
    return QuizSessionProvider(
      alarmId,
    );
  }

  @override
  QuizSessionProvider getProviderOverride(
    covariant QuizSessionProvider provider,
  ) {
    return call(
      provider.alarmId,
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
  String? get name => r'quizSessionProvider';
}

/// Provider for the quiz session
///
/// Copied from [QuizSession].
class QuizSessionProvider
    extends AutoDisposeNotifierProviderImpl<QuizSession, QuizSessionState> {
  /// Provider for the quiz session
  ///
  /// Copied from [QuizSession].
  QuizSessionProvider(
    int alarmId,
  ) : this._internal(
          () => QuizSession()..alarmId = alarmId,
          from: quizSessionProvider,
          name: r'quizSessionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$quizSessionHash,
          dependencies: QuizSessionFamily._dependencies,
          allTransitiveDependencies:
              QuizSessionFamily._allTransitiveDependencies,
          alarmId: alarmId,
        );

  QuizSessionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.alarmId,
  }) : super.internal();

  final int alarmId;

  @override
  QuizSessionState runNotifierBuild(
    covariant QuizSession notifier,
  ) {
    return notifier.build(
      alarmId,
    );
  }

  @override
  Override overrideWith(QuizSession Function() create) {
    return ProviderOverride(
      origin: this,
      override: QuizSessionProvider._internal(
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
  AutoDisposeNotifierProviderElement<QuizSession, QuizSessionState>
      createElement() {
    return _QuizSessionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuizSessionProvider && other.alarmId == alarmId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, alarmId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin QuizSessionRef on AutoDisposeNotifierProviderRef<QuizSessionState> {
  /// The parameter `alarmId` of this provider.
  int get alarmId;
}

class _QuizSessionProviderElement
    extends AutoDisposeNotifierProviderElement<QuizSession, QuizSessionState>
    with QuizSessionRef {
  _QuizSessionProviderElement(super.provider);

  @override
  int get alarmId => (origin as QuizSessionProvider).alarmId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
