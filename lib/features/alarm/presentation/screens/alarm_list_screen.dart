import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_shape.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/iap_constants.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/services/streak_provider.dart';
import '../../../../core/widgets/sunny.dart';
import '../../../quiz/presentation/providers/level_progress_provider.dart';
import '../../domain/entities/alarm.dart';
import '../providers/alarm_provider.dart';
import '../widgets/alarm_tile.dart';

/// Main screen showing list of all alarms
class AlarmListScreen extends ConsumerWidget {
  const AlarmListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmsAsync = ref.watch(alarmsProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.l, AppSpacing.s, AppSpacing.s, 0),
              child: Row(
                children: [
                  Text(
                    l10n.appTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined),
                    color: AppColors.textPrimaryLight,
                    onPressed: () => context.push(AppStrings.settingsRoute),
                  ),
                ],
              ),
            ),
            Expanded(
              child: alarmsAsync.when(
                data: (alarms) => Column(
                  children: [
                    _buildHomeHeader(context, ref, alarms),
                    Expanded(
                      child: alarms.isEmpty
                          ? _buildEmptyState(context)
                          : _buildAlarmList(context, ref, alarms),
                    ),
                  ],
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => _buildErrorState(context, l10n, error),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppStrings.alarmAddRoute),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text(l10n.addAlarm),
      ),
    );
  }

  Widget _buildErrorState(
      BuildContext context, AppLocalizations l10n, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppColors.error),
            const SizedBox(height: AppSpacing.m),
            Text(l10n.errorLoadingAlarms,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.s),
            Text(error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Sunny(expression: SunnyExpression.sleepy, size: 120),
            const SizedBox(height: AppSpacing.l),
            Text(
              l10n.noAlarms,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.s),
            Text(
              l10n.noAlarmsSubtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlarmList(
    BuildContext context,
    WidgetRef ref,
    List<AlarmEntity> alarms,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.m, AppSpacing.s, AppSpacing.m, 100),
      itemCount: alarms.length,
      itemBuilder: (context, index) {
        final alarm = alarms[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.s + 4),
          child: AlarmTile(
            alarm: alarm,
            onTap: () =>
                context.push('${AppStrings.alarmEditRoute}/${alarm.id}'),
            onDelete: () async {
              final messenger = ScaffoldMessenger.of(context);
              final operations = ref.read(alarmOperationsProvider.notifier);
              await operations.deleteAlarm(alarm.id!);
              messenger.showSnackBar(
                SnackBar(
                  content: Text(
                    alarm.label.isNotEmpty
                        ? l10n.alarmDeletedMessage(alarm.label)
                        : l10n.alarmDeletedGeneric,
                  ),
                  action: SnackBarAction(
                    label: l10n.undoAction,
                    onPressed: () {
                      unawaited(() async {
                        try {
                          await operations.restoreAlarm(alarm);
                        } catch (error) {
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text(error.toString()),
                              backgroundColor: AppColors.error,
                            ),
                          );
                        }
                      }());
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildHomeHeader(
    BuildContext context,
    WidgetRef ref,
    List<AlarmEntity> alarms,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final levelState = ref.watch(levelProgressProvider);
    final streak = ref.watch(streakProvider);
    final nextAlarm = _nextEnabledAlarm(alarms);
    const dailyGoal = IapConstants.dailyGoalXp;
    final dailyGoalDone = levelState.dailyXp >= dailyGoal;
    final dailyGoalProgress = (levelState.dailyXp / dailyGoal).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.m, AppSpacing.s, AppSpacing.m, AppSpacing.s),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryLight, AppColors.primary],
          ),
          borderRadius: BorderRadius.circular(AppShape.radiusXL),
          boxShadow: AppElevation.orange,
        ),
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.homeWelcome,
                        style:
                            Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.9),
                                ),
                      ),
                      const SizedBox(height: AppSpacing.xs + 2),
                      Text(
                        nextAlarm?.timeDisplay ?? l10n.noAlarms,
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ],
                  ),
                ),
                const Sunny(expression: SunnyExpression.smile, size: 72),
              ],
            ),
            const SizedBox(height: AppSpacing.m),
            Row(
              children: [
                Expanded(
                  child: _HeroChip(
                    icon: Icons.trending_up_rounded,
                    label: l10n.levelLabel(levelState.currentLevel),
                    value: l10n.totalXpLabel(levelState.totalXp),
                  ),
                ),
                const SizedBox(width: AppSpacing.s + 2),
                Expanded(
                  child: _HeroChip(
                    icon: Icons.local_fire_department_rounded,
                    label: l10n.morningStreak,
                    value: streak.currentStreak > 0
                        ? l10n.streakDays(streak.currentStreak)
                        : l10n.streakStart,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.m - 2),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.dailyGoalTitle,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                Text(
                  dailyGoalDone
                      ? l10n.dailyGoalDone
                      : l10n.dailyGoalProgress(
                          levelState.dailyXp, dailyGoal),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.95),
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: dailyGoalProgress,
                minHeight: 8,
                backgroundColor: Colors.white.withValues(alpha: 0.3),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AlarmEntity? _nextEnabledAlarm(List<AlarmEntity> alarms) {
    final enabled = alarms.where((alarm) => alarm.isEnabled).toList()
      ..sort((a, b) {
        final aMinutes = a.time.hour * 60 + a.time.minute;
        final bMinutes = b.time.hour * 60 + b.time.minute;
        return aMinutes.compareTo(bMinutes);
      });
    return enabled.isEmpty ? null : enabled.first;
  }
}

class _HeroChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _HeroChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s + 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(AppShape.radiusM),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
