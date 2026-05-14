import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakeup_english/core/constants/app_strings.dart';
import 'package:wakeup_english/core/services/locale_provider.dart';

void main() {
  test('loads saved locale', () async {
    SharedPreferences.setMockInitialValues({
      AppStrings.prefLanguage: 'en',
    });

    final notifier = LocaleNotifier();
    await Future<void>.delayed(Duration.zero);

    expect(notifier.state.languageCode, 'en');
  });

  test('persists selected locale', () async {
    SharedPreferences.setMockInitialValues({});
    final notifier = LocaleNotifier();
    await Future<void>.delayed(Duration.zero);

    await notifier.setLocale(const Locale('en'));

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(AppStrings.prefLanguage), 'en');
    expect(notifier.state.languageCode, 'en');
  });
}
