import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/constants/app_colors.dart';
import 'core/database/app_database.dart';
import 'core/l10n/app_localizations.dart';
import 'core/router/app_router.dart';
import 'core/services/alarm_service.dart';
import 'core/services/locale_provider.dart';
import 'core/services/subscription_provider.dart';
import 'core/services/subscription_service.dart';

/// Main app widget
class OkMorningApp extends ConsumerStatefulWidget {
  const OkMorningApp({super.key});

  @override
  ConsumerState<OkMorningApp> createState() => _OkMorningAppState();
}

class _OkMorningAppState extends ConsumerState<OkMorningApp> {
  @override
  void initState() {
    super.initState();
    _setupAlarmListener();
    _recordTrialStart();
    _syncAlarmsOnStartup();
  }

  Future<void> _recordTrialStart() async {
    try {
      await SubscriptionService.recordTrialStart();
    } catch (e) {
      debugPrint('[App] Failed to record trial start: $e');
    }
  }

  Future<void> _syncAlarmsOnStartup() async {
    try {
      final alarmService = ref.read(alarmServiceProvider);
      final hasFullAccess = ref.read(hasFullAccessProvider);
      final activeAlarms = await alarmService.getActiveAlarms();
      final activeIds = activeAlarms.map((a) => a.id).toSet();

      final db = ref.read(databaseProvider);
      final enabledAlarms = await db.getEnabledAlarms();

      for (final alarm in enabledAlarms) {
        if (!activeIds.contains(alarm.id)) {
          try {
            await alarmService.setAlarm(
              alarm,
              hasFullAccess: hasFullAccess,
            );
          } catch (e) {
            debugPrint('[App] Failed to reschedule alarm ${alarm.id}: $e');
          }
        }
      }
    } catch (e) {
      debugPrint('[App] Alarm sync failed: $e');
    }
  }

  void _setupAlarmListener() {
    try {
      final alarmService = ref.read(alarmServiceProvider);
      alarmService.onAlarmRing.listen((alarmSettings) async {
        try {
          await alarmService.handleAlarmRing(alarmSettings.id);
        } catch (e) {
          debugPrint(
            '[App] Failed to record alarm ring ${alarmSettings.id}: $e',
          );
        }
        AppRouter.navigateToQuizLock(alarmSettings.id);
      });
    } catch (e) {
      debugPrint('[App] Failed to setup alarm listener: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(localeProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'OK-Morning',
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: _buildLightTheme(),
          darkTheme: _buildDarkTheme(),
          themeMode: ThemeMode.system,
        );
      },
    );
  }

  // --- Premium Typography with Jua for headings ---
  // Safe wrapper: returns Jua TextStyle, falls back to system font on failure
  static TextStyle _jua({
    required double fontSize,
    required Color color,
    FontWeight fontWeight = FontWeight.w400,
    double? letterSpacing,
    double? height,
  }) {
    try {
      return GoogleFonts.jua(
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
        color: color,
      );
    } catch (e) {
      debugPrint('[App] GoogleFonts.jua() failed, using fallback: $e');
      return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
        color: color,
      );
    }
  }

  /// Returns a Pretendard TextStyle. Pretendard is bundled locally so no
  /// runtime network fetch is needed — safe for offline and CI.
  static TextStyle _pretendard({
    required double fontSize,
    required Color color,
    FontWeight fontWeight = FontWeight.w500,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'Pretendard',
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
      color: color,
    );
  }

  static TextTheme _buildTextTheme(Brightness brightness) {
    final base = brightness == Brightness.light
        ? AppColors.textPrimaryLight
        : AppColors.textPrimaryDark;
    final muted = brightness == Brightness.light
        ? AppColors.textSecondaryLight
        : AppColors.textSecondaryDark;

    return TextTheme(
      // Display / large numerals — Jua for warmth
      displayLarge: _jua(fontSize: 64, height: 1.1, color: base),
      displayMedium: _jua(fontSize: 48, height: 1.15, color: base),
      displaySmall: _jua(fontSize: 36, height: 1.2, color: base),

      // Headlines — Pretendard ExtraBold for assertive Korean text
      headlineLarge: _pretendard(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: base,
        letterSpacing: -0.4,
      ),
      headlineMedium: _pretendard(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: base,
        letterSpacing: -0.3,
      ),
      headlineSmall: _pretendard(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: base,
        letterSpacing: -0.2,
      ),

      // Titles — SemiBold/Bold
      titleLarge: _pretendard(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: base,
        letterSpacing: -0.2,
      ),
      titleMedium: _pretendard(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: base,
        letterSpacing: -0.1,
      ),
      titleSmall: _pretendard(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: base,
      ),

      // Body — Medium
      bodyLarge: _pretendard(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: base,
        height: 1.45,
      ),
      bodyMedium: _pretendard(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: base,
        height: 1.45,
      ),
      bodySmall: _pretendard(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: muted,
        height: 1.4,
      ),

      // Labels — for chips and buttons
      labelLarge: _pretendard(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: base,
        letterSpacing: -0.1,
      ),
      labelMedium: _pretendard(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: base,
        letterSpacing: -0.1,
      ),
      labelSmall: _pretendard(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: muted,
        letterSpacing: 0.2,
      ),
    );
  }

  ThemeData _buildLightTheme() {
    final textTheme = _buildTextTheme(Brightness.light);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      textTheme: textTheme,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        surface: AppColors.backgroundLight,
        primary: AppColors.primary,
        secondary: AppColors.action,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimaryLight,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: AppColors.surfaceLight,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.quizOption,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.action,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.action,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.action,
        foregroundColor: Colors.white,
        elevation: 4,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.action;
          }
          return AppColors.alarmInactive.withValues(alpha: 0.3);
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          return Colors.transparent;
        }),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        thumbColor: AppColors.primary,
        inactiveTrackColor: AppColors.primary.withValues(alpha: 0.15),
        overlayColor: AppColors.primary.withValues(alpha: 0.08),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return AppColors.quizOption;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            }
            return AppColors.textPrimaryLight;
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.primarySurface,
        linearMinHeight: 8,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    final textTheme = _buildTextTheme(Brightness.dark);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      textTheme: textTheme,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        surface: AppColors.backgroundDark,
        primary: AppColors.primaryLight,
        secondary: AppColors.action,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimaryDark,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: AppColors.surfaceDark,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.action,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.action,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.action,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.action;
          }
          return AppColors.alarmInactive.withValues(alpha: 0.3);
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          return Colors.transparent;
        }),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primaryLight,
        thumbColor: AppColors.primaryLight,
        inactiveTrackColor: AppColors.primaryLight.withValues(alpha: 0.15),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return AppColors.surfaceDark;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            }
            return AppColors.textPrimaryDark;
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primaryLight,
        linearTrackColor: AppColors.primary.withValues(alpha: 0.2),
        linearMinHeight: 8,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
