import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../domain/entities/alarm.dart';
import '../providers/alarm_provider.dart';
import '../utils/alarm_display_helpers.dart';

/// A tile widget displaying alarm information
class AlarmTile extends ConsumerWidget {
  final AlarmEntity alarm;
  final VoidCallback? onTap;
  final Future<void> Function()? onDelete;

  const AlarmTile({
    required this.alarm,
    super.key,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isEnabled = alarm.isEnabled;

    return Dismissible(
      key: Key('alarm_${alarm.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 28,
        ),
      ),
      confirmDismiss: (direction) async {
        return _showDeleteConfirmation(context);
      },
      onDismissed: (direction) {
        final delete = onDelete;
        if (delete != null) {
          unawaited(delete());
        }
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isEnabled
                  ? AppColors.surfaceLight
                  : AppColors.surfaceSoftLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isEnabled
                    ? AppColors.primary.withValues(alpha: 0.28)
                    : AppColors.outlineLight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowWarm.withValues(alpha: 0.08),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isEnabled
                        ? AppColors.primary.withValues(alpha: 0.12)
                        : AppColors.alarmInactive.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isEnabled
                        ? Icons.alarm_on_rounded
                        : Icons.alarm_off_rounded,
                    color:
                        isEnabled ? AppColors.primary : AppColors.alarmInactive,
                  ),
                ),
                const SizedBox(width: 14),
                // Time display
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Time
                      Text(
                        alarm.timeDisplay,
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: isEnabled
                              ? theme.colorScheme.onSurface
                              : theme.colorScheme.onSurface
                                  .withValues(alpha: 0.4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Label and repeat days
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          if (alarm.label.isNotEmpty) ...[
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 150),
                              child: _MetaText(
                                text: alarm.label,
                                isEnabled: isEnabled,
                              ),
                            ),
                          ],
                          _MetaText(
                            text: localizedRepeatDaysDisplay(l10n, alarm),
                            isEnabled: isEnabled,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Quiz info
                      Row(
                        children: [
                          Icon(
                            Icons.quiz_outlined,
                            size: 16,
                            color: isEnabled
                                ? AppColors.primary
                                : AppColors.primary.withValues(alpha: 0.4),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            l10n.quizInfoFormat(
                                localizedDifficultyName(
                                    l10n, alarm.quizDifficulty),
                                alarm.quizCount),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isEnabled
                                  ? AppColors.primary
                                  : AppColors.primary.withValues(alpha: 0.4),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Toggle switch
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _StatusPill(isEnabled: isEnabled, l10n: l10n),
                    const SizedBox(height: 8),
                    Switch.adaptive(
                      value: isEnabled,
                      onChanged: (value) {
                        HapticFeedback.lightImpact();
                        ref
                            .read(alarmOperationsProvider.notifier)
                            .toggleAlarm(alarm.id!, value);
                      },
                      activeThumbColor: AppColors.action,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.deleteAlarm),
            content: Text(
              alarm.label.isNotEmpty
                  ? l10n.confirmDeleteAlarmWithLabel(alarm.label)
                  : l10n.confirmDeleteAlarmWithTime(alarm.timeDisplay),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(l10n.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.error,
                ),
                child: Text(l10n.deleteButton),
              ),
            ],
          ),
        ) ??
        false;
  }
}

class _MetaText extends StatelessWidget {
  final String text;
  final bool isEnabled;

  const _MetaText({
    required this.text,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isEnabled ? color : color.withValues(alpha: 0.45),
          ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final bool isEnabled;
  final AppLocalizations l10n;

  const _StatusPill({
    required this.isEnabled,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final color = isEnabled ? AppColors.action : AppColors.alarmInactive;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isEnabled ? l10n.alarmEnabled : l10n.alarmDisabled,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
