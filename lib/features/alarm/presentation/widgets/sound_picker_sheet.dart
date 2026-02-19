import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../core/constants/alarm_sounds.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/services/subscription_provider.dart';

class SoundPickerSheet extends ConsumerStatefulWidget {
  final String currentSoundPath;
  final ValueChanged<String> onSoundSelected;

  const SoundPickerSheet({
    super.key,
    required this.currentSoundPath,
    required this.onSoundSelected,
  });

  @override
  ConsumerState<SoundPickerSheet> createState() => _SoundPickerSheetState();
}

class _SoundPickerSheetState extends ConsumerState<SoundPickerSheet> {
  String? _playingPath;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _stopPreview() async {
    await _audioPlayer.stop();
    if (mounted) {
      setState(() => _playingPath = null);
    }
  }

  Future<void> _playPreview(String assetPath) async {
    await _stopPreview();

    try {
      await _audioPlayer.setAsset(assetPath);
      await _audioPlayer.setVolume(0.5);
      await _audioPlayer.play();
      setState(() => _playingPath = assetPath);

      // Auto-stop after 4 seconds
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted && _playingPath == assetPath) {
          _stopPreview();
        }
      });
    } catch (e) {
      debugPrint('Sound preview error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final hasFullAccess = ref.watch(hasFullAccessProvider);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              l10n.alarmSoundTitle,
              style: theme.textTheme.titleLarge,
            ),
          ),
          const Divider(height: 1),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: AlarmSounds.all.length,
              itemBuilder: (context, index) {
                final sound = AlarmSounds.all[index];
                final isSelected = sound.assetPath == widget.currentSoundPath;
                final isLocked = !sound.isFree && !hasFullAccess;
                final isPlaying = _playingPath == sound.assetPath;

                return ListTile(
                  leading: Icon(
                    isPlaying ? Icons.pause_circle : Icons.play_circle_outline,
                    color: isLocked
                        ? theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4)
                        : AppColors.primary,
                  ),
                  title: Text(
                    sound.displayName,
                    style: TextStyle(
                      color: isLocked
                          ? theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5)
                          : null,
                    ),
                  ),
                  subtitle: Text(
                    sound.displayNameKo,
                    style: TextStyle(
                      color: isLocked
                          ? theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3)
                          : null,
                    ),
                  ),
                  trailing: isLocked
                      ? const Icon(Icons.lock, size: 20, color: AppColors.primary)
                      : isSelected
                          ? const Icon(Icons.check_circle, color: AppColors.action)
                          : null,
                  onTap: () {
                    if (isLocked) {
                      Navigator.pop(context);
                      AppRouter.navigateToPaywall();
                    } else {
                      if (isPlaying) {
                        _stopPreview();
                      } else {
                        _playPreview(sound.assetPath);
                      }
                    }
                  },
                  onLongPress: isLocked
                      ? null
                      : () {
                          _stopPreview();
                          widget.onSoundSelected(sound.assetPath);
                          Navigator.pop(context);
                        },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              l10n.soundPickerHint,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: const SizedBox(height: 8),
          ),
        ],
      ),
    );
  }
}
