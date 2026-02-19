import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/services/streak_provider.dart';
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
              color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha:0.3),
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
                        .withValues(alpha:0.7),
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakCard(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final streak = ref.watch(streakProvider);

    if (streak.currentStreak < 1) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.quizStreak.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.quizStreak.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          const Text('🔥', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.streakDays(streak.currentStreak),
                  style: GoogleFonts.jua(
                    fontSize: 18,
                    color: AppColors.primaryDark,
                  ),
                ),
                if (streak.completedToday)
                  Text(
                    l10n.completedToday,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            l10n.streakRecord(streak.maxStreak),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondaryLight,
            ),
          ),
        ],
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
        _buildStreakCard(context, ref),
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
                  onTap: () => context.push('${AppStrings.alarmEditRoute}/${alarm.id}'),
                  onDelete: () {
                    ref.read(alarmOperationsProvider.notifier).deleteAlarm(alarm.id!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          alarm.label.isNotEmpty
                              ? l10n.alarmDeletedMessage(alarm.label)
                              : l10n.alarmDeletedGeneric,
                        ),
                        action: SnackBarAction(
                          label: l10n.undoAction,
                          onPressed: () {
                            // TODO: Implement undo
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
}
