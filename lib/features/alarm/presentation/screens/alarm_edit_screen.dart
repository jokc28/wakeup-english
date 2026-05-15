import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/constants/alarm_sounds.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/widgets/sunny.dart';
import '../../data/repositories/alarm_repository.dart';
import '../../domain/entities/alarm.dart';
import '../providers/alarm_provider.dart';
import '../utils/alarm_display_helpers.dart';
import '../widgets/sound_picker_sheet.dart';

// --- Design constants ---
const _kCardColor = AppColors.surfaceLight;
const _kCardRadius = 8.0;
const _kTextDark = AppColors.textPrimaryLight;
const _kTextHint = AppColors.textSecondaryLight;
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
  late FocusNode _labelFocusNode;
  bool _isLoading = false;
  bool _labelHasText = false;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController();
    _labelController.addListener(() {
      final hasText = _labelController.text.isNotEmpty;
      if (hasText != _labelHasText) {
        setState(() => _labelHasText = hasText);
      }
    });
    _labelFocusNode = FocusNode();
    _labelFocusNode.addListener(() {
      if (_labelFocusNode.hasFocus) {
        // Move cursor to end of text when focused
        _labelController.selection = TextSelection.fromPosition(
          TextPosition(offset: _labelController.text.length),
        );
      }
    });
  }

  @override
  void dispose() {
    _labelController.dispose();
    _labelFocusNode.dispose();
    super.dispose();
  }

  bool get isEditing => widget.alarmId != null;

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(alarmFormProvider(alarmId: widget.alarmId));
    final l10n = AppLocalizations.of(context)!;

    if (_labelController.text != form.label) {
      _labelController.text = form.label;
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          isEditing ? l10n.editAlarm : l10n.addAlarm,
          style: const TextStyle(
            color: _kTextDark,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: TextButton(
          onPressed: () => context.pop(),
          child: Text(
            l10n.cancel,
            style: const TextStyle(color: _kTextHint, fontSize: 16),
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
                    l10n.saveAlarm,
                    style: const TextStyle(
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
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _selectTime(context, form);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Text(
              form.timeDisplay,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppColors.primary,
                    fontSize: 88,
                    letterSpacing: -2,
                  ),
            ),
            const SizedBox(height: 8),
            const Sunny(expression: SunnyExpression.smile, size: 48),
            const SizedBox(height: 4),
            Text(
              l10n.timePickerTapHint,
              style: const TextStyle(color: _kTextHint, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Label Card ─────────────────────────────────────────────

  Widget _buildLabelCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _SettingsCard(
      children: [
        _SettingsRow(
          icon: Icons.label_outline,
          label: l10n.alarmNameLabel,
          child: TextField(
            controller: _labelController,
            focusNode: _labelFocusNode,
            textAlign: TextAlign.right,
            style: const TextStyle(color: _kTextDark, fontSize: 15),
            decoration: InputDecoration(
              hintText: l10n.optionalLabel,
              hintStyle: const TextStyle(color: _kTextHint, fontSize: 15),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
              suffixIcon: _labelHasText
                  ? GestureDetector(
                      onTap: () {
                        _labelController.clear();
                        ref
                            .read(alarmFormProvider(alarmId: widget.alarmId)
                                .notifier)
                            .setLabel('');
                      },
                      child: const Icon(
                        Icons.cancel,
                        size: 18,
                        color: _kTextHint,
                      ),
                    )
                  : null,
              suffixIconConstraints:
                  const BoxConstraints(minWidth: 24, minHeight: 24),
            ),
            onChanged: (value) {
              ref
                  .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
                  .setLabel(value);
            },
          ),
        ),
      ],
    );
  }

  // ─── Repeat Card ────────────────────────────────────────────

  Widget _buildRepeatCard(BuildContext context, AlarmEntity form) {
    final l10n = AppLocalizations.of(context)!;
    final days = [
      l10n.monday,
      l10n.tuesday,
      l10n.wednesday,
      l10n.thursday,
      l10n.friday,
      l10n.saturday,
      l10n.sunday
    ];

    return _SettingsCard(
      children: [
        _SectionHeader(icon: Icons.repeat, label: l10n.repeatDays),
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
          localizedRepeatDaysDisplay(l10n, form),
          style: const TextStyle(color: _kTextHint, fontSize: 13),
        ),
      ],
    );
  }

  // ─── Mission (Quiz) Card ────────────────────────────────────

  Widget _buildMissionCard(BuildContext context, AlarmEntity form) {
    final l10n = AppLocalizations.of(context)!;
    return _SettingsCard(
      children: [
        _SectionHeader(
            icon: Icons.extension_outlined, label: l10n.wakeMissionLabel),
        const SizedBox(height: 14),
        // Difficulty
        Row(
          children: [
            Text(l10n.difficultyLabel,
                style: const TextStyle(color: _kTextDark, fontSize: 15)),
            const Spacer(),
            _MiniSegment<QuizDifficulty>(
              values: QuizDifficulty.values,
              selected: form.quizDifficulty,
              labelOf: (d) => localizedDifficultyName(l10n, d),
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
            Text(l10n.quizCount,
                style: const TextStyle(color: _kTextDark, fontSize: 15)),
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
    final l10n = AppLocalizations.of(context)!;
    return _SettingsCard(
      children: [
        _SectionHeader(
            icon: Icons.music_note_outlined, label: l10n.alarmSoundLabel),
        const _ThinDivider(),
        // Sound selector
        _SettingsRow(
          label: l10n.soundLabel,
          onTap: () => _showSoundPicker(context, form),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AlarmSounds.getByPath(form.soundPath)?.displayName ??
                    'Classic Alarm',
                style: const TextStyle(color: AppColors.primary, fontSize: 15),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, size: 20, color: _kTextHint),
            ],
          ),
        ),
        const _ThinDivider(),
        // Vibration
        _ToggleRow(
          label: l10n.vibration,
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
          label: l10n.gradualVolumeLabel,
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
            Text(l10n.volumeLabel,
                style: const TextStyle(color: _kTextDark, fontSize: 15)),
            const SizedBox(width: 16),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: const Color(0xFFE0E0E0),
                  thumbColor: AppColors.primary,
                  overlayColor: AppColors.primary.withValues(alpha: 0.1),
                  trackHeight: 3,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 7),
                ),
                child: Slider(
                  value: form.volume.toDouble(),
                  min: 0,
                  max: 100,
                  divisions: 10,
                  onChanged: (value) {
                    ref
                        .read(
                            alarmFormProvider(alarmId: widget.alarmId).notifier)
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
    final l10n = AppLocalizations.of(context)!;
    final snoozeEnabled = form.snoozeDuration > 0;

    return _SettingsCard(
      children: [
        _ToggleRow(
          icon: Icons.snooze_outlined,
          label: l10n.snoozeLabel,
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
            label: l10n.snoozeIntervalLabel,
            child: _PillSelector<int>(
              values: const [5, 10, 15, 20, 30],
              selected: form.snoozeDuration,
              labelOf: l10n.minutes,
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
            label: l10n.maxSnoozesLabel,
            child: _PillSelector<int>(
              values: const [1, 2, 3, 5, 10],
              selected: form.maxSnoozes,
              labelOf: l10n.maxSnoozesFormat,
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
    showModalBottomSheet<void>(
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
    final l10n = AppLocalizations.of(context)!;
    var selectedTime = DateTime(
      2026,
      1,
      1,
      form.time.hour,
      form.time.minute,
    );

    showModalBottomSheet<void>(
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                      child: Text(
                        l10n.cancel,
                        style: const TextStyle(color: _kTextHint, fontSize: 16),
                      ),
                    ),
                    Text(
                      l10n.setAlarmTimeTitle,
                      style: const TextStyle(
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
                        l10n.doneButton,
                        style: const TextStyle(
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
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);

    try {
      final id = await ref
          .read(alarmFormProvider(alarmId: widget.alarmId).notifier)
          .save();

      if (id != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isEditing ? l10n.alarmUpdated : l10n.alarmCreated),
          ),
        );
        context.pop();
      }
    } catch (e) {
      debugPrint('Alarm save error: $e');
      if (mounted) {
        if (e is AlarmSchedulingException && e.canOpenSettings) {
          await _showAlarmPermissionDialog(e.message);
          if (!mounted) return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _showAlarmPermissionDialog(String message) async {
    final l10n = AppLocalizations.of(context)!;
    final openSettings = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('알림 권한 필요'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(l10n.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('설정 열기'),
              ),
            ],
          ),
        ) ??
        false;

    if (openSettings) {
      await openAppSettings();
    }
  }

  Future<void> _showDeleteConfirmation() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteAlarm),
        content: Text(l10n.confirmDeleteAlarm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.deleteButton),
          ),
        ],
      ),
    );

    if ((confirmed ?? false) && widget.alarmId != null && mounted) {
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
        border: Border.all(color: AppColors.outlineLight),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowWarm.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
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
    required this.label,
    required this.child,
    this.icon,
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
        const SizedBox(width: 12),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: child,
          ),
        ),
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
    required this.label,
    required this.value,
    required this.onChanged,
    this.icon,
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

  Color _colorFor(T value) {
    if (value is QuizDifficulty) {
      switch (value) {
        case QuizDifficulty.easy:
          return AppColors.action;
        case QuizDifficulty.medium:
          return AppColors.primary;
        case QuizDifficulty.hard:
          return AppColors.error;
      }
    }
    return AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: values.map((v) {
        final isActive = v == selected;
        final color = _colorFor(v);
        return Padding(
          padding: const EdgeInsets.only(left: 6),
          child: GestureDetector(
            onTap: () => onChanged(v),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: isActive ? color : color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isActive ? color : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Text(
                labelOf(v),
                style: TextStyle(
                  color: isActive ? Colors.white : color,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );
      }).toList(),
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
          _stepButton(
              Icons.remove, value > min ? () => onChanged(value - 1) : null),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              '$value',
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          _stepButton(
              Icons.add, value < max ? () => onChanged(value + 1) : null),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: values.map((v) {
          final isActive = v == selected;
          return Padding(
            padding: const EdgeInsets.only(left: 6),
            child: GestureDetector(
              onTap: () => onChanged(v),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
      ),
    );
  }
}
