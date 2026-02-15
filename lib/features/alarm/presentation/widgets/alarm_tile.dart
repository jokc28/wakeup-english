import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/alarm.dart';
import '../providers/alarm_provider.dart';

/// A tile widget displaying alarm information
class AlarmTile extends ConsumerWidget {
  final AlarmEntity alarm;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const AlarmTile({
    super.key,
    required this.alarm,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isEnabled = alarm.isEnabled;

    return Dismissible(
      key: Key('alarm_${alarm.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: AppColors.error,
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 28,
        ),
      ),
      confirmDismiss: (direction) async {
        return await _showDeleteConfirmation(context);
      },
      onDismissed: (direction) {
        onDelete?.call();
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Time display
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Time
                      Text(
                        alarm.timeDisplay,
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isEnabled
                              ? theme.colorScheme.onSurface
                              : theme.colorScheme.onSurface.withValues(alpha:0.4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Label and repeat days
                      Row(
                        children: [
                          if (alarm.label.isNotEmpty) ...[
                            Flexible(
                              child: Text(
                                alarm.label,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: isEnabled
                                      ? theme.colorScheme.onSurfaceVariant
                                      : theme.colorScheme.onSurfaceVariant
                                          .withValues(alpha:0.4),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '•',
                              style: TextStyle(
                                color: theme.colorScheme.onSurfaceVariant
                                    .withValues(alpha:0.4),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            alarm.repeatDaysDisplay,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isEnabled
                                  ? theme.colorScheme.onSurfaceVariant
                                  : theme.colorScheme.onSurfaceVariant
                                      .withValues(alpha:0.4),
                            ),
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
                                : AppColors.primary.withValues(alpha:0.4),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${alarm.quizCount} ${alarm.quizDifficulty.displayName} questions',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isEnabled
                                  ? AppColors.primary
                                  : AppColors.primary.withValues(alpha:0.4),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Toggle switch
                Switch.adaptive(
                  value: isEnabled,
                  onChanged: (value) {
                    ref
                        .read(alarmOperationsProvider.notifier)
                        .toggleAlarm(alarm.id!, value);
                  },
                  activeColor: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Alarm'),
            content: Text(
              alarm.label.isNotEmpty
                  ? 'Delete alarm "${alarm.label}"?'
                  : 'Delete alarm at ${alarm.timeDisplay}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.error,
                ),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
