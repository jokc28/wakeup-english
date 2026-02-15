import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/alarm/presentation/screens/alarm_list_screen.dart';
import '../../features/alarm/presentation/screens/alarm_edit_screen.dart';
import '../../features/quiz/presentation/screens/quiz_lock_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/subscription/presentation/screens/paywall_screen.dart';
import '../constants/app_strings.dart';

/// Provider for the app router
final appRouterProvider = Provider<GoRouter>((ref) {
  return AppRouter.router;
});

/// Navigation key for accessing navigator from anywhere
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// App router configuration using go_router
class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppStrings.alarmListRoute,
    debugLogDiagnostics: true,
    routes: [
      // Alarm List Screen (Home)
      GoRoute(
        path: AppStrings.alarmListRoute,
        name: 'alarmList',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AlarmListScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      // Add Alarm Screen
      GoRoute(
        path: AppStrings.alarmAddRoute,
        name: 'alarmAdd',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AlarmEditScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
        ),
      ),

      // Edit Alarm Screen
      GoRoute(
        path: '${AppStrings.alarmEditRoute}/:id',
        name: 'alarmEdit',
        pageBuilder: (context, state) {
          final alarmId = int.tryParse(state.pathParameters['id'] ?? '');
          return CustomTransitionPage(
            key: state.pageKey,
            child: AlarmEditScreen(alarmId: alarmId),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: child,
              );
            },
          );
        },
      ),

      // Quiz Lock Screen
      GoRoute(
        path: '${AppStrings.quizLockRoute}/:alarmId',
        name: 'quizLock',
        pageBuilder: (context, state) {
          final alarmId =
              int.tryParse(state.pathParameters['alarmId'] ?? '') ?? 0;
          return CustomTransitionPage(
            key: state.pageKey,
            child: QuizLockScreen(alarmId: alarmId),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          );
        },
      ),

      // Settings Screen
      GoRoute(
        path: AppStrings.settingsRoute,
        name: 'settings',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SettingsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
        ),
      ),

      // Paywall Screen
      GoRoute(
        path: AppStrings.paywallRoute,
        name: 'paywall',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const PaywallScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            );
          },
        ),
      ),
    ],

    // Error handling
    errorPageBuilder: (context, state) => MaterialPage(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Page not found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                state.uri.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go(AppStrings.alarmListRoute),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  /// Navigate to quiz lock screen when alarm fires
  static void navigateToQuizLock(int alarmId) {
    router.go('${AppStrings.quizLockRoute}/$alarmId');
  }

  /// Navigate to alarm edit screen
  static void navigateToAlarmEdit(int alarmId) {
    router.go('${AppStrings.alarmEditRoute}/$alarmId');
  }

  /// Navigate to add alarm screen
  static void navigateToAddAlarm() {
    router.go(AppStrings.alarmAddRoute);
  }

  /// Navigate to alarm list
  static void navigateToAlarmList() {
    router.go(AppStrings.alarmListRoute);
  }

  /// Navigate to settings
  static void navigateToSettings() {
    router.go(AppStrings.settingsRoute);
  }

  /// Navigate to paywall
  static void navigateToPaywall() {
    router.push(AppStrings.paywallRoute);
  }
}
