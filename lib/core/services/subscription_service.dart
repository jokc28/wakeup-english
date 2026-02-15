import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/iap_constants.dart';

class SubscriptionService {
  static bool _initialized = false;

  static bool _hasValidApiKey = false;

  static Future<void> initialize() async {
    if (_initialized) return;

    final apiKey = Platform.isIOS
        ? IapConstants.revenueCatApiKeyIOS
        : IapConstants.revenueCatApiKeyAndroid;

    // Skip RevenueCat if using placeholder API keys
    if (apiKey.contains('YOUR_') || apiKey.isEmpty) {
      debugPrint('[SubscriptionService] Skipping RevenueCat (placeholder key)');
      _hasValidApiKey = false;
      _initialized = true;
      return;
    }

    try {
      final configuration = PurchasesConfiguration(apiKey);
      await Purchases.configure(configuration);
      _hasValidApiKey = true;
    } catch (e) {
      debugPrint('[SubscriptionService] Configure error: $e');
      _hasValidApiKey = false;
    }
    _initialized = true;
  }

  Future<bool> isPremium() async {
    if (!_hasValidApiKey) return false;
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return customerInfo.entitlements.all[IapConstants.premiumEntitlementId]
              ?.isActive ??
          false;
    } catch (e) {
      debugPrint('[SubscriptionService] Error checking premium: $e');
      return false;
    }
  }

  Future<bool> isTrialActive() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final trialStartStr = prefs.getString(IapConstants.prefTrialStartDate);
      if (trialStartStr == null) return false;

      final trialStart = DateTime.parse(trialStartStr);
      final trialEnd = trialStart.add(
        const Duration(days: IapConstants.trialDurationDays),
      );
      return DateTime.now().isBefore(trialEnd);
    } catch (e) {
      debugPrint('[SubscriptionService] Error checking trial: $e');
      return false;
    }
  }

  Future<bool> get hasFullAccess async {
    final premium = await isPremium();
    if (premium) return true;
    return isTrialActive();
  }

  Future<int> get trialDaysRemaining async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final trialStartStr = prefs.getString(IapConstants.prefTrialStartDate);
      if (trialStartStr == null) return 0;

      final trialStart = DateTime.parse(trialStartStr);
      final trialEnd = trialStart.add(
        const Duration(days: IapConstants.trialDurationDays),
      );
      final remaining = trialEnd.difference(DateTime.now()).inDays;
      return remaining > 0 ? remaining : 0;
    } catch (_) {
      return 0;
    }
  }

  Future<Offerings?> getOfferings() async {
    if (!_hasValidApiKey) return null;
    try {
      return await Purchases.getOfferings();
    } catch (e) {
      debugPrint('[SubscriptionService] Error getting offerings: $e');
      return null;
    }
  }

  Future<bool> purchasePackage(Package package) async {
    if (!_hasValidApiKey) return false;
    try {
      final customerInfo = await Purchases.purchasePackage(package);
      return customerInfo.entitlements.all[IapConstants.premiumEntitlementId]
              ?.isActive ??
          false;
    } catch (e) {
      debugPrint('[SubscriptionService] Error purchasing: $e');
      return false;
    }
  }

  Future<bool> restorePurchases() async {
    if (!_hasValidApiKey) return false;
    try {
      final customerInfo = await Purchases.restorePurchases();
      return customerInfo.entitlements.all[IapConstants.premiumEntitlementId]
              ?.isActive ??
          false;
    } catch (e) {
      debugPrint('[SubscriptionService] Error restoring: $e');
      return false;
    }
  }

  void addCustomerInfoUpdateListener(void Function(CustomerInfo) listener) {
    if (!_hasValidApiKey) return;
    Purchases.addCustomerInfoUpdateListener(listener);
  }

  static Future<void> recordTrialStart() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(IapConstants.prefTrialStartDate);
    if (existing == null) {
      await prefs.setString(
        IapConstants.prefTrialStartDate,
        DateTime.now().toIso8601String(),
      );
    }
  }

  /// Record install date on first launch
  static Future<void> recordInstallDate() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString('install_date');
    if (existing == null) {
      await prefs.setString(
        'install_date',
        DateTime.now().toIso8601String(),
      );
    }
  }

  /// Check if the 7-day free trial has expired based on install_date
  static Future<bool> isTrialExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final installDateStr = prefs.getString('install_date');
    if (installDateStr == null) return false;

    final installDate = DateTime.parse(installDateStr);
    final expiryDate = installDate.add(
      const Duration(days: IapConstants.trialDurationDays),
    );
    return DateTime.now().isAfter(expiryDate);
  }

  /// Get the number of trial days remaining based on install_date
  static Future<int> getTrialDaysRemaining() async {
    final prefs = await SharedPreferences.getInstance();
    final installDateStr = prefs.getString('install_date');
    if (installDateStr == null) return IapConstants.trialDurationDays;

    final installDate = DateTime.parse(installDateStr);
    final expiryDate = installDate.add(
      const Duration(days: IapConstants.trialDurationDays),
    );
    final remaining = expiryDate.difference(DateTime.now()).inDays;
    return remaining > 0 ? remaining : 0;
  }
}
