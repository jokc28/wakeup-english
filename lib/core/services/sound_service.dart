import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

/// Lightweight sound-effect player for quiz feedback.
///
/// Each effect gets its own [AudioPlayer] so they can overlap (e.g. confetti
/// triggering "complete" while the last "correct" tone is still ringing out).
/// Players are lazily loaded on first use and kept alive for the session.
class SoundService {
  SoundService._();
  static final SoundService instance = SoundService._();

  final Map<SfxKind, AudioPlayer> _players = {};
  bool enabled = true;

  Future<void> play(SfxKind kind) async {
    if (!enabled) return;
    final player = _players.putIfAbsent(kind, AudioPlayer.new);
    try {
      await player.setAsset(kind.assetPath);
      await player.seek(Duration.zero);
      await player.play();
    } catch (e) {
      // Silent failure — SFX is non-critical.
      debugPrint('[SoundService] play($kind) failed: $e');
    }
  }

  Future<void> dispose() async {
    for (final p in _players.values) {
      await p.dispose();
    }
    _players.clear();
  }
}

enum SfxKind { correct, wrong, combo, complete }

extension on SfxKind {
  String get assetPath {
    switch (this) {
      case SfxKind.correct:
        return 'assets/sounds/sfx/correct.wav';
      case SfxKind.wrong:
        return 'assets/sounds/sfx/wrong.wav';
      case SfxKind.combo:
        return 'assets/sounds/sfx/combo.wav';
      case SfxKind.complete:
        return 'assets/sounds/sfx/complete.wav';
    }
  }
}
