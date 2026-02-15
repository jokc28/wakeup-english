import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'subscription_service.dart';

final subscriptionServiceProvider = Provider<SubscriptionService>((ref) {
  return SubscriptionService();
});

class SubscriptionState {
  final bool isPremium;
  final bool isTrialActive;
  final int daysRemaining;

  const SubscriptionState({
    this.isPremium = false,
    this.isTrialActive = false,
    this.daysRemaining = 0,
  });

  bool get hasFullAccess => isPremium || isTrialActive;

  bool get hasTrialExpired => !isTrialActive && daysRemaining == 0;

  SubscriptionState copyWith({
    bool? isPremium,
    bool? isTrialActive,
    int? daysRemaining,
  }) {
    return SubscriptionState(
      isPremium: isPremium ?? this.isPremium,
      isTrialActive: isTrialActive ?? this.isTrialActive,
      daysRemaining: daysRemaining ?? this.daysRemaining,
    );
  }
}

final subscriptionProvider =
    StateNotifierProvider<SubscriptionNotifier, SubscriptionState>((ref) {
  final service = ref.watch(subscriptionServiceProvider);
  return SubscriptionNotifier(service);
});

class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  final SubscriptionService _service;

  SubscriptionNotifier(this._service) : super(const SubscriptionState()) {
    _init();
  }

  Future<void> _init() async {
    await refresh();
    try {
      _service.addCustomerInfoUpdateListener((_) {
        refresh();
      });
    } catch (e) {
      debugPrint('[SubscriptionNotifier] Listener error: $e');
    }
  }

  Future<void> refresh() async {
    final premium = await _service.isPremium();
    final trial = await _service.isTrialActive();
    final days = await _service.trialDaysRemaining;

    state = SubscriptionState(
      isPremium: premium,
      isTrialActive: trial,
      daysRemaining: days,
    );
  }
}

final hasFullAccessProvider = Provider<bool>((ref) {
  final sub = ref.watch(subscriptionProvider);
  return sub.hasFullAccess;
});
