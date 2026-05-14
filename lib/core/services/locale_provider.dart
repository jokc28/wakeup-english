import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_strings.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('ko', 'KR')) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(AppStrings.prefLanguage) ?? 'ko';
    state = _localeForCode(languageCode);
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppStrings.prefLanguage, locale.languageCode);
    state = _localeForCode(locale.languageCode);
  }

  Locale _localeForCode(String languageCode) {
    switch (languageCode) {
      case 'en':
        return const Locale('en');
      case 'ko':
      default:
        return const Locale('ko', 'KR');
    }
  }
}
