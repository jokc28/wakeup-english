import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../domain/entities/alarm.dart';
import '../providers/alarm_provider.dart';
import '../widgets/alarm_tile.dart';

/// Main screen showing list of all alarms
class AlarmListScreen extends ConsumerWidget {
  const AlarmListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmsAsync = ref.watch(alarmsProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('영어 알람'),
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
                '알람 불러오기 오류',
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
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('알람 추가'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
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
              '설정된 알람 없음',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '아래 버튼을 눌러 영어 퀴즈 알람을 만들어 보세요',
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

  Widget _buildAlarmList(
    BuildContext context,
    WidgetRef ref,
    List<AlarmEntity> alarms,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
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
                        ? '"${alarm.label}" 삭제됨'
                        : '알람이 삭제되었습니다',
                  ),
                  action: SnackBarAction(
                    label: '되돌리기',
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
    );
  }
}
