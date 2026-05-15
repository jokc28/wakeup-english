import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/utils/db_seeder.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/services/app_settings_provider.dart';
import '../../../../core/services/locale_provider.dart';
import '../../../../core/services/mission_type_provider.dart';
import '../../../../core/services/streak_provider.dart';
import '../../../../core/services/subscription_provider.dart';
import '../../../../core/widgets/sunny.dart';
import '../../../alarm/domain/entities/alarm.dart';
import '../../../quiz/presentation/providers/level_progress_provider.dart';

/// Settings screen for app configuration
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final subState = ref.watch(subscriptionProvider);
    final missionState = ref.watch(missionTypeProvider);
    final appSettings = ref.watch(appSettingsProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Subscription Status Card
          _buildSubscriptionCard(context, subState),
          const SizedBox(height: 24),

          // Language Section
          _buildSectionHeader(context, l10n.language),
          _buildSettingsTile(
            context,
            icon: Icons.language,
            title: l10n.language,
            subtitle: locale.languageCode == 'en' ? l10n.english : l10n.korean,
            onTap: () => _showLanguageDialog(context, ref, locale),
          ),
          const SizedBox(height: 24),

          // Default Alarm Settings
          _buildSectionHeader(context, l10n.defaultAlarmSettings),
          _buildSettingsTile(
            context,
            icon: Icons.quiz_outlined,
            title: l10n.defaultQuizCount,
            subtitle: l10n.quizCountFormat(appSettings.defaultQuizCount),
            onTap: () => _showQuizCountDialog(
              context,
              ref,
              appSettings.defaultQuizCount,
            ),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.speed_outlined,
            title: l10n.defaultDifficulty,
            subtitle: _difficultyLabel(l10n, appSettings.defaultDifficulty),
            onTap: () => _showDifficultyDialog(
              context,
              ref,
              appSettings.defaultDifficulty,
            ),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.snooze_outlined,
            title: l10n.defaultSnoozeTime,
            subtitle: l10n.minutes(appSettings.defaultSnoozeMinutes),
            onTap: () => _showSnoozeDialog(
              context,
              ref,
              appSettings.defaultSnoozeMinutes,
            ),
          ),
          const SizedBox(height: 24),

          // Mission Type Selector
          _buildSectionHeader(context, l10n.missionTypeHeader),
          _buildSwitchTile(
            context,
            icon: Icons.shuffle,
            title: l10n.wordScrambleMission,
            subtitle: l10n.wordScrambleDescription,
            value: missionState.wordScrambleEnabled,
            onChanged: (value) {
              ref.read(missionTypeProvider.notifier).toggleWordScramble(value);
            },
          ),
          _buildSwitchTile(
            context,
            icon: Icons.mic,
            title: l10n.speakingChallengeMission,
            subtitle: l10n.speakingChallengeDescription,
            value: missionState.speakingChallengeEnabled,
            onChanged: (value) {
              ref
                  .read(missionTypeProvider.notifier)
                  .toggleSpeakingChallenge(value);
            },
          ),
          const SizedBox(height: 24),

          // Sound Settings
          _buildSectionHeader(context, l10n.soundVibrationHeader),
          _buildSwitchTile(
            context,
            icon: Icons.vibration,
            title: l10n.vibration,
            subtitle: l10n.vibrationDescription,
            value: appSettings.vibrationEnabled,
            onChanged: (value) {
              unawaited(
                ref
                    .read(appSettingsProvider.notifier)
                    .setVibrationEnabled(value),
              );
            },
          ),
          _buildSwitchTile(
            context,
            icon: Icons.volume_up_outlined,
            title: l10n.gradualVolumeLabel,
            subtitle: l10n.gradualVolumeDescription,
            value: appSettings.gradualVolumeEnabled,
            onChanged: (value) {
              unawaited(
                ref
                    .read(appSettingsProvider.notifier)
                    .setGradualVolumeEnabled(value),
              );
            },
          ),
          const SizedBox(height: 24),

          // Subscription Section
          _buildSectionHeader(context, l10n.subscriptionHeader),
          if (!subState.isPremium)
            _buildSettingsTile(
              context,
              icon: Icons.workspace_premium,
              title: l10n.upgradeToPremium,
              subtitle: l10n.unlockAllContent,
              onTap: AppRouter.navigateToPaywall,
            ),
          _buildSettingsTile(
            context,
            icon: Icons.restore,
            title: l10n.restorePurchasesLabel,
            subtitle: l10n.restorePurchasesDescription,
            onTap: () => _handleRestore(context, ref),
          ),
          if (kDebugMode)
            _buildSettingsTile(
              context,
              icon: subState.isPremium ? Icons.toggle_on : Icons.toggle_off,
              title: l10n.debugPremiumMode,
              subtitle: subState.isPremium
                  ? l10n.debugPremiumEnabled
                  : l10n.debugPremiumDisabled,
              titleColor: Colors.deepOrange,
              onTap: () {
                ref.read(subscriptionProvider.notifier).debugTogglePremium();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      subState.isPremium
                          ? l10n.debugPremiumDisabled
                          : l10n.debugPremiumEnabled,
                    ),
                  ),
                );
              },
            ),
          if (kDebugMode)
            _buildSettingsTile(
              context,
              icon: Icons.download_rounded,
              title: l10n.devForceSeedDb,
              subtitle: l10n.devForceSeedDbDesc,
              titleColor: Colors.deepOrange,
              onTap: () {
                unawaited(
                  () async {
                    final db = ref.read(databaseProvider);
                    final count = await DbSeeder.seedFromAsset(db);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.devSeedComplete(count))),
                      );
                    }
                  }(),
                );
              },
            ),
          const SizedBox(height: 24),

          // About Section
          _buildSectionHeader(context, l10n.aboutHeader),
          _buildSettingsTile(
            context,
            icon: Icons.info_outline,
            title: l10n.versionLabel,
            subtitle: '1.0.0',
            onTap: null,
          ),
          _buildSettingsTile(
            context,
            icon: Icons.description_outlined,
            title: l10n.licensesLabel,
            subtitle: l10n.licensesDescription,
            onTap: () => _showLicenses(context),
          ),
          const SizedBox(height: 24),

          // Danger Zone
          _buildSectionHeader(context, l10n.dataHeader),
          _buildSettingsTile(
            context,
            icon: Icons.delete_outline,
            title: l10n.clearProgressLabel,
            subtitle: l10n.clearProgressDescription,
            titleColor: AppColors.error,
            onTap: () => _showClearProgressDialog(context, ref),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Color? titleColor,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.outlineLight),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: titleColor ?? theme.colorScheme.onSurfaceVariant,
        ),
        title: Text(
          title,
          style: TextStyle(color: titleColor),
        ),
        subtitle: Text(subtitle),
        trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        secondary: Icon(
          icon,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(
      BuildContext context, SubscriptionState subState) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    String statusText;
    String subtitleText;
    Color statusColor;

    if (subState.isPremium) {
      statusText = l10n.premiumStatus;
      subtitleText = l10n.premiumAllContent;
      statusColor = AppColors.accent;
    } else if (subState.isTrialActive) {
      statusText = l10n.freeTrialStatus;
      subtitleText = l10n.trialDaysRemaining(subState.daysRemaining);
      statusColor = AppColors.warning;
    } else {
      statusText = l10n.freePlanStatus;
      subtitleText = l10n.freePlanLimits;
      statusColor = theme.colorScheme.onSurfaceVariant;
    }

    final heroExpression = subState.isPremium
        ? SunnyExpression.excited
        : (subState.isTrialActive
            ? SunnyExpression.smile
            : SunnyExpression.sleepy);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: statusColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      color: AppColors.primarySurface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Sunny(expression: heroExpression, size: 56),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statusText,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: statusColor,
                    ),
                  ),
                  Text(
                    subtitleText,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            if (!subState.isPremium)
              FilledButton(
                onPressed: AppRouter.navigateToPaywall,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.action,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  minimumSize: const Size(0, 36),
                ),
                child: Text(l10n.upgradeButton),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRestore(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final service = ref.read(subscriptionServiceProvider);
    final success = await service.restorePurchases();

    if (context.mounted) {
      if (success) {
        unawaited(ref.read(subscriptionProvider.notifier).refresh());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.purchasesRestoredSnackbar)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.noPurchasesToRestore)),
        );
      }
    }
  }

  void _showLanguageDialog(
    BuildContext context,
    WidgetRef ref,
    Locale selectedLocale,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.selectLanguageDialog),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text('🇺🇸'),
              title: const Text('English'),
              trailing: selectedLocale.languageCode == 'en'
                  ? const Icon(Icons.check, color: AppColors.action)
                  : null,
              onTap: () {
                unawaited(
                  ref
                      .read(localeProvider.notifier)
                      .setLocale(const Locale('en')),
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Text('🇰🇷'),
              title: Text(l10n.korean),
              trailing: selectedLocale.languageCode == 'ko'
                  ? const Icon(Icons.check, color: AppColors.action)
                  : null,
              onTap: () {
                unawaited(
                  ref
                      .read(localeProvider.notifier)
                      .setLocale(const Locale('ko', 'KR')),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  String _difficultyLabel(AppLocalizations l10n, QuizDifficulty difficulty) {
    switch (difficulty) {
      case QuizDifficulty.easy:
        return l10n.difficultyEasy;
      case QuizDifficulty.medium:
        return l10n.difficultyMedium;
      case QuizDifficulty.hard:
        return l10n.difficultyHard;
    }
  }

  void _showQuizCountDialog(
    BuildContext context,
    WidgetRef ref,
    int selectedCount,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.selectQuizCountDialog),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [1, 3, 5, 7, 10].map((count) {
            return ListTile(
              title: Text(l10n.quizCountFormat(count)),
              trailing: count == selectedCount
                  ? const Icon(Icons.check, color: AppColors.action)
                  : null,
              onTap: () {
                unawaited(
                  ref
                      .read(appSettingsProvider.notifier)
                      .setDefaultQuizCount(count),
                );
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showDifficultyDialog(
    BuildContext context,
    WidgetRef ref,
    QuizDifficulty selectedDifficulty,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.selectDifficultyDialog),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(l10n.difficultyEasy),
              trailing: selectedDifficulty == QuizDifficulty.easy
                  ? const Icon(Icons.check, color: AppColors.action)
                  : null,
              subtitle: Text(l10n.easyDifficultyDesc),
              onTap: () {
                unawaited(
                  ref
                      .read(appSettingsProvider.notifier)
                      .setDefaultDifficulty(QuizDifficulty.easy),
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(l10n.difficultyMedium),
              trailing: selectedDifficulty == QuizDifficulty.medium
                  ? const Icon(Icons.check, color: AppColors.action)
                  : null,
              subtitle: Text(l10n.mediumDifficultyDesc),
              onTap: () {
                unawaited(
                  ref
                      .read(appSettingsProvider.notifier)
                      .setDefaultDifficulty(QuizDifficulty.medium),
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(l10n.difficultyHard),
              trailing: selectedDifficulty == QuizDifficulty.hard
                  ? const Icon(Icons.check, color: AppColors.action)
                  : null,
              subtitle: Text(l10n.hardDifficultyDesc),
              onTap: () {
                unawaited(
                  ref
                      .read(appSettingsProvider.notifier)
                      .setDefaultDifficulty(QuizDifficulty.hard),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSnoozeDialog(
    BuildContext context,
    WidgetRef ref,
    int selectedMinutes,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.selectSnoozeDialog),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [5, 10, 15, 20, 30].map((minutes) {
            return ListTile(
              title: Text(l10n.minutes(minutes)),
              trailing: minutes == selectedMinutes
                  ? const Icon(Icons.check, color: AppColors.action)
                  : null,
              onTap: () {
                unawaited(
                  ref
                      .read(appSettingsProvider.notifier)
                      .setDefaultSnoozeMinutes(minutes),
                );
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showLicenses(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showLicensePage(
      context: context,
      applicationName: l10n.appTitle,
      applicationVersion: '1.0.0',
    );
  }

  void _showClearProgressDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.clearProgressDialog),
        content: Text(
          l10n.clearProgressWarning,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              unawaited(
                () async {
                  await ref.read(databaseProvider).clearLearningProgress();
                  await ref.read(streakProvider.notifier).clearStreak();
                  await ref.read(levelProgressProvider.notifier).refresh();

                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.progressClearedSnackbar)),
                  );
                }(),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.resetButton),
          ),
        ],
      ),
    );
  }
}
