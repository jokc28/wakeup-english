import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/alarm_sounds.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/alarm.dart';
import '../providers/alarm_provider.dart';
import '../widgets/sound_picker_sheet.dart';

// --- Design constants ---
const _kCardColor = Color(0xFFF5F5F5);
const _kCardRadius = 20.0;
const _kTextDark = Color(0xFF333333);
const _kTextHint = Color(0xFF999999);
const _kHorizontalPadding = 24.0;

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

    if (_labelController.text != form.label) {
      _labelController.text = form.label;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          isEditing ? '알람 수정' : '알람 추가',
          style: const TextStyle(
            color: _kTextDark,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: TextButton(
          onPressed: () => context.pop(),
          child: const Text(
            '취소',
            style: TextStyle(color: _kTextHint, fontSize: 16),
          ),
        ),
        leadingWidth: 80,
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 22),
              color: AppColors.error.withValues(alpha: 0.7),
              onPressed: _showDeleteConfirmation,
            ),
          TextButton(
            onPressed: _isLoading ? null : _saveAlarm,
            child: _isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    '저장',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: _kHorizontalPadding),
        child: Column(
          children: [
            const SizedBox(height: 8),
            _buildTimePicker(context, form),
            const SizedBox(height: 28),
            _buildLabelCard(context),
            const SizedBox(height: 16),
            _buildRepeatCard(context, form),
            const SizedBox(height: 16),
            _buildMissionCard(context, form),
            const SizedBox(height: 16),
            _buildSoundCard(context, form),
            const SizedBox(height: 16),
            _buildSnoozeCard(context, form),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ─── Time Display ───────────────────────────────────────────

  Widget _buildTimePicker(BuildContext context, AlarmEntity form) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _selectTime(context, form);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(
              form.timeDisplay,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w300,
                    color: AppColors.primary,
                    fontSize: 72,
                    letterSpacing: -2,
                  ),
            ),
            const SizedBox(height: 4),
            const Text(
              '탭하여 시간 변경',
              style: TextStyle(color: _kTextHint, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Label Card ─────────────────────────────────────────────

  Widget _buildLabelCard(BuildContext context) {
    return _SettingsCard(
      children: [
        _SettingsRow(
          icon: Icons.label_outline,
          label: '알람 이름',
          child: Expanded(
            child: TextField(
              controller: _labelController,
              textAlign: TextAlign.right,
              style: const TextStyle(color: _kTextDark, fontSize: 15),
              decoration: const InputDecoration(
                hintText: '선택사항',
                hintStyle: TextStyle(color: _kTextHint, fontSize: 15),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (value) {
                ref
                    .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                    .setLabel(value);
              },
            ),
          ),
        ),
      ],
    );
  }

  // ─── Repeat Card ────────────────────────────────────────────

  Widget _buildRepeatCard(BuildContext context, AlarmEntity form) {
    const days = ['월', '화', '수', '목', '금', '토', '일'];

    return _SettingsCard(
      children: [
        const _SectionHeader(icon: Icons.repeat, label: '반복'),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final isSelected = form.repeatDays.contains(index);
            return GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                ref
                    .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                    .toggleRepeatDay(index);
              },
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  shape: BoxShape.circle,
                  border: isSelected
                      ? null
                      : Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: Center(
                  child: Text(
                    days[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : _kTextDark,
                      fontSize: 13,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        Text(
          form.repeatDaysDisplay,
          style: const TextStyle(color: _kTextHint, fontSize: 13),
        ),
      ],
    );
  }

  // ─── Mission (Quiz) Card ────────────────────────────────────

  Widget _buildMissionCard(BuildContext context, AlarmEntity form) {
    return _SettingsCard(
      children: [
        const _SectionHeader(icon: Icons.extension_outlined, label: '기상 미션'),
        const SizedBox(height: 14),
        // Difficulty
        Row(
          children: [
            const Text('난이도', style: TextStyle(color: _kTextDark, fontSize: 15)),
            const Spacer(),
            _MiniSegment<QuizDifficulty>(
              values: QuizDifficulty.values,
              selected: form.quizDifficulty,
              labelOf: (d) => d.displayName,
              onChanged: (d) {
                HapticFeedback.lightImpact();
                ref
                    .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                    .setQuizDifficulty(d);
              },
            ),
          ],
        ),
        const _ThinDivider(),
        // Question count
        Row(
          children: [
            const Text('문제 수', style: TextStyle(color: _kTextDark, fontSize: 15)),
            const Spacer(),
            _StepperControl(
              value: form.quizCount,
              min: 1,
              max: 10,
              onChanged: (v) {
                HapticFeedback.lightImpact();
                ref
                    .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                    .setQuizCount(v);
              },
            ),
          ],
        ),
      ],
    );
  }

  // ─── Sound Card ─────────────────────────────────────────────

  Widget _buildSoundCard(BuildContext context, AlarmEntity form) {
    return _SettingsCard(
      children: [
        const _SectionHeader(icon: Icons.music_note_outlined, label: '알람음'),
        const _ThinDivider(),
        // Sound selector
        _SettingsRow(
          label: '소리',
          onTap: () => _showSoundPicker(context, form),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AlarmSounds.getByPath(form.soundPath)?.displayName ??
                    'Classic Alarm',
                style: TextStyle(color: AppColors.primary, fontSize: 15),
              ),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right, size: 20, color: _kTextHint),
            ],
          ),
        ),
        const _ThinDivider(),
        // Vibration
        _ToggleRow(
          label: '진동',
          value: form.vibrationEnabled,
          onChanged: (v) {
            ref
                .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                .setVibrationEnabled(v);
          },
        ),
        const _ThinDivider(),
        // Gradual volume
        _ToggleRow(
          label: '점진적 볼륨',
          value: form.gradualVolume,
          onChanged: (v) {
            ref
                .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                .setGradualVolume(v);
          },
        ),
        const _ThinDivider(),
        // Volume slider
        Row(
          children: [
            const Text('볼륨', style: TextStyle(color: _kTextDark, fontSize: 15)),
            const SizedBox(width: 16),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: const Color(0xFFE0E0E0),
                  thumbColor: AppColors.primary,
                  overlayColor: AppColors.primary.withValues(alpha: 0.1),
                  trackHeight: 3,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                ),
                child: Slider(
                  value: form.volume.toDouble(),
                  min: 0,
                  max: 100,
                  divisions: 10,
                  onChanged: (value) {
                    ref
                        .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                        .setVolume(value.toInt());
                  },
                ),
              ),
            ),
            SizedBox(
              width: 38,
              child: Text(
                '${form.volume}%',
                style: const TextStyle(color: _kTextHint, fontSize: 13),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─── Snooze Card ────────────────────────────────────────────

  Widget _buildSnoozeCard(BuildContext context, AlarmEntity form) {
    final snoozeEnabled = form.snoozeDuration > 0;

    return _SettingsCard(
      children: [
        _ToggleRow(
          icon: Icons.snooze_outlined,
          label: '다시 알림',
          value: snoozeEnabled,
          onChanged: (v) {
            ref
                .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                .setSnoozeDuration(v ? 5 : 0);
          },
        ),
        if (snoozeEnabled) ...[
          const _ThinDivider(),
          _SettingsRow(
            label: '간격',
            child: _PillSelector<int>(
              values: const [5, 10, 15, 20, 30],
              selected: form.snoozeDuration,
              labelOf: (v) => '$v분',
              onChanged: (v) {
                HapticFeedback.lightImpact();
                ref
                    .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                    .setSnoozeDuration(v);
              },
            ),
          ),
          const _ThinDivider(),
          _SettingsRow(
            label: '최대 횟수',
            child: _PillSelector<int>(
              values: const [1, 2, 3, 5, 10],
              selected: form.maxSnoozes,
              labelOf: (v) => '$v회',
              onChanged: (v) {
                HapticFeedback.lightImpact();
                ref
                    .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                    .setMaxSnoozes(v);
              },
            ),
          ),
        ],
      ],
    );
  }

  // ─── Actions ────────────────────────────────────────────────

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

  void _selectTime(BuildContext context, AlarmEntity form) {
    var selectedTime = DateTime(
      2026, 1, 1,
      form.time.hour,
      form.time.minute,
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          height: 340,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Toolbar
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withValues(alpha: 0.15),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(sheetContext),
                      child: const Text(
                        '취소',
                        style: TextStyle(color: _kTextHint, fontSize: 16),
                      ),
                    ),
                    const Text(
                      '알람 시간 설정',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _kTextDark,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        ref
                            .read(alarmFormProvider(alarmId: widget.alarmId)
                                .notifier)
                            .setTime(TimeOfDay(
                              hour: selectedTime.hour,
                              minute: selectedTime.minute,
                            ));
                        Navigator.pop(sheetContext);
                      },
                      child: Text(
                        '완료',
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
              // Cupertino Picker with Korean locale
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
            content:
                Text(isEditing ? '알람이 업데이트되었습니다' : '알람이 생성되었습니다'),
          ),
        );
        context.pop();
      }
    } catch (e) {
      debugPrint('Alarm save error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(isEditing ? '알람이 업데이트되었습니다' : '알람이 생성되었습니다'),
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
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
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

// ═══════════════════════════════════════════════════════════════
// Reusable building blocks (private to this file)
// ═══════════════════════════════════════════════════════════════

/// Rounded card container for a settings group.
class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: _kCardColor,
        borderRadius: BorderRadius.circular(_kCardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}

/// Section header with icon and label.
class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SectionHeader({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: _kTextDark,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

/// A single row inside a settings card: label on left, child on right.
class _SettingsRow extends StatelessWidget {
  final IconData? icon;
  final String label;
  final Widget child;
  final VoidCallback? onTap;

  const _SettingsRow({
    this.icon,
    required this.label,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 8),
        ],
        Text(label, style: const TextStyle(color: _kTextDark, fontSize: 15)),
        const Spacer(),
        child,
      ],
    );

    if (onTap != null) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: content,
      );
    }
    return content;
  }
}

/// A toggle (switch) row.
class _ToggleRow extends StatelessWidget {
  final IconData? icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 8),
        ],
        Text(label, style: const TextStyle(color: _kTextDark, fontSize: 15)),
        const Spacer(),
        SizedBox(
          height: 28,
          child: CupertinoSwitch(
            value: value,
            activeTrackColor: AppColors.primary,
            onChanged: (v) {
              HapticFeedback.lightImpact();
              onChanged(v);
            },
          ),
        ),
      ],
    );
  }
}

/// Thin divider inside cards.
class _ThinDivider extends StatelessWidget {
  const _ThinDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Divider(height: 1, color: Colors.grey.withValues(alpha: 0.15)),
    );
  }
}

/// Compact segmented control (pill-shaped).
class _MiniSegment<T> extends StatelessWidget {
  final List<T> values;
  final T selected;
  final String Function(T) labelOf;
  final ValueChanged<T> onChanged;

  const _MiniSegment({
    required this.values,
    required this.selected,
    required this.labelOf,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: values.map((v) {
          final isActive = v == selected;
          return GestureDetector(
            onTap: () => onChanged(v),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                labelOf(v),
                style: TextStyle(
                  color: isActive ? Colors.white : _kTextHint,
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// A + / – stepper for numeric values.
class _StepperControl extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  const _StepperControl({
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stepButton(Icons.remove, value > min ? () => onChanged(value - 1) : null),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              '$value',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          _stepButton(Icons.add, value < max ? () => onChanged(value + 1) : null),
        ],
      ),
    );
  }

  Widget _stepButton(IconData icon, VoidCallback? onTap) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: enabled ? _kCardColor : const Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 16,
          color: enabled ? _kTextDark : const Color(0xFFCCCCCC),
        ),
      ),
    );
  }
}

/// Horizontal scrollable pill selector.
class _PillSelector<T> extends StatelessWidget {
  final List<T> values;
  final T selected;
  final String Function(T) labelOf;
  final ValueChanged<T> onChanged;

  const _PillSelector({
    required this.values,
    required this.selected,
    required this.labelOf,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: values.map((v) {
        final isActive = v == selected;
        return Padding(
          padding: const EdgeInsets.only(left: 6),
          child: GestureDetector(
            onTap: () => onChanged(v),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                labelOf(v),
                style: TextStyle(
                  color: isActive ? Colors.white : _kTextHint,
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
