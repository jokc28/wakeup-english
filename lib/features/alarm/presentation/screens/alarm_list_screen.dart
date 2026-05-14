import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/iap_constants.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/services/streak_provider.dart';
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(l10n.appTitle),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(AppStrings.settingsRoute),
          ),
        ],
      ),
      body: alarmsAsync.when(
        data: (alarms) {
          if (alarms.isEmpty) {
            return _buildEmptyState(context);
          }
          return _buildAlarmList(context, ref, alarms);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.error,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.errorLoadingAlarms,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppStrings.alarmAddRoute),
        backgroundColor: AppColors.action,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text(l10n.addAlarm),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.alarm_off_outlined,
              size: 100,
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withValues(alpha: 0.3),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.noAlarms,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.noAlarmsSubtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withValues(alpha: 0.7),
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
    return Column(
      children: [
        _buildHomeHeader(context, ref, alarms),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            itemCount: alarms.length,
            itemBuilder: (context, index) {
              final alarm = alarms[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AlarmTile(
                  alarm: alarm,
                  onTap: () =>
                      context.push('${AppStrings.alarmEditRoute}/${alarm.id}'),
                  onDelete: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    final operations =
                        ref.read(alarmOperationsProvider.notifier);
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
                            unawaited(
                              () async {
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
                              }(),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
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
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.surfaceWarmLight,
              AppColors.surfaceSoftLight,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.outlineLight),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowWarm.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
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
                                    color: AppColors.textSecondaryLight,
                                  ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          nextAlarm?.timeDisplay ?? l10n.noAlarms,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                color: AppColors.textPrimaryLight,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.78),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.alarm_on_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _MetricChip(
                      icon: Icons.trending_up_rounded,
                      label: l10n.levelLabel(levelState.currentLevel),
                      value: l10n.totalXpLabel(levelState.totalXp),
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _MetricChip(
                      icon: Icons.local_fire_department_rounded,
                      label: l10n.morningStreak,
                      value: streak.currentStreak > 0
                          ? l10n.streakDays(streak.currentStreak)
                          : l10n.streakStart,
                      color: AppColors.action,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.dailyGoalTitle,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.textPrimaryLight,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  Text(
                    dailyGoalDone
                        ? l10n.dailyGoalDone
                        : l10n.dailyGoalProgress(levelState.dailyXp, dailyGoal),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: dailyGoalDone
                              ? AppColors.action
                              : AppColors.textSecondaryLight,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: dailyGoalProgress,
                  minHeight: 8,
                  backgroundColor: Colors.white.withValues(alpha: 0.78),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    dailyGoalDone ? AppColors.action : AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
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

class _MetricChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _MetricChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 64),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.14)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.textPrimaryLight,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondaryLight,
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
