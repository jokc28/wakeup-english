import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/app_router.dart';
import '../../../alarm/data/repositories/alarm_repository.dart';
import '../../../alarm/domain/entities/alarm.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  bool _notificationGranted = false;
  bool _microphoneGranted = false;

  @override
  void initState() {
    super.initState();
    _checkExistingPermissions();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _checkExistingPermissions() async {
    final notif = await Permission.notification.isGranted;
    final mic = await Permission.microphone.isGranted;
    if (mounted) {
      setState(() {
        _notificationGranted = notif;
        _microphoneGranted = mic;
      });
    }
  }

  Future<void> _requestNotification() async {
    HapticFeedback.mediumImpact();
    final status = await Permission.notification.request();
    if (mounted) {
      setState(() => _notificationGranted = status.isGranted);
    }
  }

  Future<void> _requestMicrophone() async {
    HapticFeedback.mediumImpact();
    final status = await Permission.microphone.request();
    if (mounted) {
      setState(() => _microphoneGranted = status.isGranted);
    }
  }

  void _goToPage(int page) {
    HapticFeedback.lightImpact();
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppStrings.prefFirstLaunchComplete, true);
    // Flip the in-memory provider so GoRouter redirect allows /alarms
    ref.read(firstLaunchCompleteProvider.notifier).state = true;
  }

  Future<void> _finishAndGoHome() async {
    await _completeOnboarding();
    if (mounted) {
      AppRouter.navigateToAlarmList();
    }
  }

  Future<void> _showFirstAlarmPicker() async {
    HapticFeedback.mediumImpact();
    final l10n = AppLocalizations.of(context)!;
    DateTime selectedTime = DateTime.now().add(const Duration(hours: 8));
    // Round to nearest 5 min
    selectedTime = selectedTime.copyWith(
      minute: (selectedTime.minute / 5).round() * 5,
      second: 0,
      millisecond: 0,
    );

    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SizedBox(
          height: 340,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(sheetContext, false),
                      child: Text(l10n.cancel),
                    ),
                    Text(
                      l10n.setAlarmTimeTitle,
                      style: Theme.of(sheetContext)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(sheetContext, true),
                      child: Text(
                        l10n.doneButton,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Localizations.override(
                  context: sheetContext,
                  locale: const Locale('ko', 'KR'),
                  delegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: selectedTime,
                    use24hFormat: false,
                    onDateTimeChanged: (DateTime newTime) {
                      selectedTime = newTime;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (confirmed == true && mounted) {
      // Create the alarm with the selected time
      final alarmRepo = ref.read(alarmRepositoryProvider);

      await alarmRepo.createAlarm(
        AlarmEntity(
          time: TimeOfDay(
            hour: selectedTime.hour,
            minute: selectedTime.minute,
          ),
          label: 'OK-Morning',
          isEnabled: true,
        ),
      );

      await _completeOnboarding();
      if (mounted) {
        AppRouter.navigateToAlarmList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button (top-right)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, top: 8),
                child: TextButton(
                  onPressed: _finishAndGoHome,
                  child: Text(
                    l10n.onboardingSkip,
                    style: TextStyle(
                      color: AppColors.textSecondaryLight,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),

            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: [
                  _buildWelcomeSlide(l10n),
                  _buildValueSlide(l10n),
                  _buildPermissionsSlide(l10n),
                  _buildCtaSlide(l10n),
                ],
              ),
            ),

            // Page indicator + nav
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                children: [
                  // Dot indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (i) {
                      final isActive = i == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.primary
                              : AppColors.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),

                  // Navigation button
                  if (_currentPage < 3)
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FilledButton(
                        onPressed: () => _goToPage(_currentPage + 1),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          l10n.onboardingNext,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  if (_currentPage == 3)
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.gradientStart, AppColors.gradientEnd],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: FilledButton(
                          onPressed: _showFirstAlarmPicker,
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            l10n.onboardingCtaButton,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Slide 1: Welcome ───
  Widget _buildWelcomeSlide(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Duckling mascot
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.gradientStart, AppColors.gradientEnd],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Center(
              child: Text('🐥', style: TextStyle(fontSize: 64)),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            l10n.onboardingWelcomeTitle,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            l10n.onboardingWelcomeSubtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ─── Slide 2: Value Prop ───
  Widget _buildValueSlide(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Alarm + quiz visual
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text('⏰', style: TextStyle(fontSize: 64)),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            l10n.onboardingValueTitle,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            l10n.onboardingValueSubtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondaryLight,
                  height: 1.6,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          // Level-up badges
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBadge('Lv.1', AppColors.action),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.arrow_forward, color: AppColors.primary, size: 20),
              ),
              _buildBadge('Lv.10', AppColors.primary),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.arrow_forward, color: AppColors.primary, size: 20),
              ),
              _buildBadge('Lv.50', AppColors.secondary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    );
  }

  // ─── Slide 3: Permissions Gate ───
  Widget _buildPermissionsSlide(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text('🔔', style: TextStyle(fontSize: 64)),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            l10n.onboardingPermissionsTitle,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            l10n.onboardingPermissionsSubtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 36),

          // Notification permission button
          _buildPermissionButton(
            icon: Icons.notifications_active_rounded,
            label: l10n.onboardingNotificationBtn,
            granted: _notificationGranted,
            onTap: _requestNotification,
          ),
          const SizedBox(height: 16),

          // Microphone permission button
          _buildPermissionButton(
            icon: Icons.mic_rounded,
            label: l10n.onboardingMicrophoneBtn,
            granted: _microphoneGranted,
            onTap: _requestMicrophone,
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionButton({
    required IconData icon,
    required String label,
    required bool granted,
    required VoidCallback onTap,
  }) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: granted ? null : onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor:
              granted ? AppColors.action.withValues(alpha: 0.08) : null,
          side: BorderSide(
            color: granted ? AppColors.action : AppColors.primary,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              granted ? Icons.check_circle_rounded : icon,
              color: granted ? AppColors.action : AppColors.primary,
              size: 22,
            ),
            const SizedBox(width: 10),
            Text(
              granted ? l10n.onboardingPermissionGranted : label,
              style: TextStyle(
                color: granted ? AppColors.action : AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Slide 4: CTA ───
  Widget _buildCtaSlide(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Celebration visual
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.gradientStart, AppColors.gradientEnd],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Center(
              child: Text('🎉', style: TextStyle(fontSize: 64)),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            l10n.onboardingCtaTitle,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            l10n.onboardingCtaSubtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondaryLight,
                  height: 1.6,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
