import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app.dart';
import 'core/services/alarm_service.dart';
import 'core/services/subscription_service.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Global error handler — prevents white screen on uncaught errors
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('[FlutterError] ${details.exceptionAsString()}');
    debugPrint('[FlutterError] ${details.stack}');
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('[PlatformError] $error');
    debugPrint('[PlatformError] $stack');
    return true;
  };

  // Allow GoogleFonts to fall back gracefully if font download fails
  GoogleFonts.config.allowRuntimeFetching = true;

  // In release mode, show a friendly error screen instead of white/grey screen
  if (kReleaseMode) {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return MaterialApp(
        home: Scaffold(
          backgroundColor: const Color(0xFFFFFDF5),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      size: 64, color: Color(0xFFFF8C00)),
                  const SizedBox(height: 16),
                  const Text(
                    'Please restart the app',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'A temporary error occurred.',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    };
  }

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
