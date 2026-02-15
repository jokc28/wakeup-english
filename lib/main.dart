import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/services/alarm_service.dart';
import 'core/services/subscription_service.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize alarm service (catch errors so app still launches)
  try {
    await AlarmService.initialize();
  } catch (e) {
    debugPrint('[AlarmService] Failed to initialize: $e');
  }

  // Initialize RevenueCat subscription service
  try {
    await SubscriptionService.initialize();
  } catch (e) {
    debugPrint('[SubscriptionService] Failed to initialize: $e');
  }

  // Run app with Riverpod
  runApp(
    const ProviderScope(
      child: WakeUpEnglishApp(),
    ),
  );
}
