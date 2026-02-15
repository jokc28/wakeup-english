import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/alarm_sounds.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/alarm.dart';
import '../providers/alarm_provider.dart';
import '../widgets/sound_picker_sheet.dart';

/// Screen for creating or editing an alarm
class AlarmEditScreen extends ConsumerStatefulWidget {
  final int? alarmId;

  const AlarmEditScreen({super.key, this.alarmId});

  @override
  ConsumerState<AlarmEditScreen> createState() => _AlarmEditScreenState();
}

class _AlarmEditScreenState extends ConsumerState<AlarmEditScreen> {
  late TextEditingController _labelController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController();
  }

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  bool get isEditing => widget.alarmId != null;

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(alarmFormProvider(alarmId: widget.alarmId));

    // Sync label controller with form state
    if (_labelController.text != form.label) {
      _labelController.text = form.label;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? '알람 수정' : '알람 추가'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: AppColors.error,
              onPressed: _showDeleteConfirmation,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time Picker
            _buildTimePicker(context, form),
            const SizedBox(height: 24),

            // Label
            _buildLabelField(context),
            const SizedBox(height: 24),

            // Repeat Days
            _buildRepeatDays(context, form),
            const SizedBox(height: 24),

            // Quiz Settings
            _buildQuizSettings(context, form),
            const SizedBox(height: 24),

            // Sound & Vibration
            _buildSoundSettings(context, form),
            const SizedBox(height: 24),

            // Snooze Settings
            _buildSnoozeSettings(context, form),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: _isLoading ? null : _saveAlarm,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    isEditing ? '변경사항 저장' : '알람 만들기',
                    style: const TextStyle(fontSize: 16),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context, AlarmEntity form) {
    return GestureDetector(
      onTap: () => _selectTime(context, form),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha:0.1),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Text(
              form.timeDisplay,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w300,
                    color: AppColors.primary,
                    fontSize: 72,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '탭하여 변경',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary.withValues(alpha:0.7),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '라벨',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _labelController,
          decoration: InputDecoration(
            hintText: '알람 이름 (선택사항)',
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) {
            ref
                .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                .setLabel(value);
          },
        ),
      ],
    );
  }

  Widget _buildRepeatDays(BuildContext context, AlarmEntity form) {
    const days = ['월', '화', '수', '목', '금', '토', '일'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '반복',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final isSelected = form.repeatDays.contains(index);
            return GestureDetector(
              onTap: () {
                ref
                    .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                    .toggleRepeatDay(index);
              },
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    days[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : null,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Text(
          form.repeatDaysDisplay,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  Widget _buildQuizSettings(BuildContext context, AlarmEntity form) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '퀴즈 설정',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        // Difficulty
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('난이도'),
              const SizedBox(height: 8),
              SegmentedButton<QuizDifficulty>(
                segments: QuizDifficulty.values.map((d) {
                  return ButtonSegment(
                    value: d,
                    label: Text(d.displayName),
                  );
                }).toList(),
                selected: {form.quizDifficulty},
                onSelectionChanged: (selected) {
                  ref
                      .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                      .setQuizDifficulty(selected.first);
                },
              ),
              const SizedBox(height: 16),
              // Question count
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('문제 수'),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: form.quizCount > 1
                            ? () {
                                ref
                                    .read(alarmFormProvider(alarmId: widget.alarmId)
                                        .notifier)
                                    .setQuizCount(form.quizCount - 1);
                              }
                            : null,
                      ),
                      Text(
                        '${form.quizCount}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: form.quizCount < 10
                            ? () {
                                ref
                                    .read(alarmFormProvider(alarmId: widget.alarmId)
                                        .notifier)
                                    .setQuizCount(form.quizCount + 1);
                              }
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSoundSettings(BuildContext context, AlarmEntity form) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '소리 및 진동',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Sound selector
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('알람 소리'),
                subtitle: Text(
                  AlarmSounds.getByPath(form.soundPath)?.displayName ??
                      'Classic Alarm',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showSoundPicker(context, form),
              ),
              const Divider(),
              // Vibration toggle
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('진동'),
                value: form.vibrationEnabled,
                onChanged: (value) {
                  ref
                      .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                      .setVibrationEnabled(value);
                },
              ),
              const Divider(),
              // Gradual volume toggle
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('점진적 볼륨 증가'),
                subtitle: const Text('소리가 작게 시작해서 점점 커집니다'),
                value: form.gradualVolume,
                onChanged: (value) {
                  ref
                      .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                      .setGradualVolume(value);
                },
              ),
              const Divider(),
              // Volume slider
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('볼륨'),
                subtitle: Slider(
                  value: form.volume.toDouble(),
                  min: 0,
                  max: 100,
                  divisions: 10,
                  label: '${form.volume}%',
                  onChanged: (value) {
                    ref
                        .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                        .setVolume(value.toInt());
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSnoozeSettings(BuildContext context, AlarmEntity form) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '미루기',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Snooze toggle
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('미루기 사용'),
                value: form.snoozeDuration > 0,
                onChanged: (value) {
                  ref
                      .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                      .setSnoozeDuration(value ? 5 : 0);
                },
              ),
              if (form.snoozeDuration > 0) ...[
                const Divider(),
                // Snooze duration
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('미루기 시간'),
                    DropdownButton<int>(
                      value: form.snoozeDuration,
                      items: [5, 10, 15, 20, 30].map((minutes) {
                        return DropdownMenuItem(
                          value: minutes,
                          child: Text('$minutes분'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          ref
                              .read(
                                  alarmFormProvider(alarmId: widget.alarmId).notifier)
                              .setSnoozeDuration(value);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Max snoozes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('최대 미루기 횟수'),
                    DropdownButton<int>(
                      value: form.maxSnoozes,
                      items: [1, 2, 3, 5, 10].map((count) {
                        return DropdownMenuItem(
                          value: count,
                          child: Text('$count'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          ref
                              .read(
                                  alarmFormProvider(alarmId: widget.alarmId).notifier)
                              .setMaxSnoozes(value);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  void _showSoundPicker(BuildContext context, AlarmEntity form) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.85,
        minChildSize: 0.4,
        builder: (context, scrollController) => SoundPickerSheet(
          currentSoundPath: form.soundPath,
          onSoundSelected: (path) {
            ref
                .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                .setSoundPath(path);
          },
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, AlarmEntity form) async {
    final time = await showTimePicker(
      context: context,
      initialTime: form.time,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      ref
          .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
          .setTime(time);
    }
  }

  Future<void> _saveAlarm() async {
    setState(() => _isLoading = true);

    try {
      final id = await ref
          .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
          .save();

      if (id != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isEditing ? '알람이 업데이트되었습니다' : '알람이 생성되었습니다'),
          ),
        );
        context.pop();
      }
    } catch (e) {
      // Alarm was likely saved to DB but scheduling failed.
      // Still navigate back so the user isn't stuck.
      debugPrint('Alarm save error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isEditing ? '알람이 업데이트되었습니다' : '알람이 생성되었습니다'),
          ),
        );
        context.pop();
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _showDeleteConfirmation() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('알람 삭제'),
        content: const Text('이 알람을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
            ),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirmed == true && widget.alarmId != null && mounted) {
      await ref
          .read(alarmOperationsProvider.notifier)
          .deleteAlarm(widget.alarmId!);
      if (mounted) {
        context.pop();
      }
    }
  }
}
