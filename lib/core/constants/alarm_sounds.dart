class AlarmSound {
  final String assetPath;
  final String displayName;
  final String displayNameKo;
  final bool isFree;

  const AlarmSound({
    required this.assetPath,
    required this.displayName,
    required this.displayNameKo,
    required this.isFree,
  });
}

abstract class AlarmSounds {
  static const List<AlarmSound> all = [
    AlarmSound(
      assetPath: 'assets/sounds/default_alarm.mp3',
      displayName: 'Classic Alarm',
      displayNameKo: '기본 알람',
      isFree: true,
    ),
    AlarmSound(
      assetPath: 'assets/sounds/gentle_morning.mp3',
      displayName: 'Gentle Morning',
      displayNameKo: '부드러운 아침',
      isFree: true,
    ),
    AlarmSound(
      assetPath: 'assets/sounds/birds_chirping.mp3',
      displayName: 'Birds Chirping',
      displayNameKo: '새소리',
      isFree: true,
    ),
    AlarmSound(
      assetPath: 'assets/sounds/ocean_waves.mp3',
      displayName: 'Ocean Waves',
      displayNameKo: '파도 소리',
      isFree: false,
    ),
    AlarmSound(
      assetPath: 'assets/sounds/piano_melody.mp3',
      displayName: 'Piano Melody',
      displayNameKo: '피아노 멜로디',
      isFree: false,
    ),
    AlarmSound(
      assetPath: 'assets/sounds/digital_beep.mp3',
      displayName: 'Digital Beep',
      displayNameKo: '디지털 비프',
      isFree: false,
    ),
    AlarmSound(
      assetPath: 'assets/sounds/wind_chimes.mp3',
      displayName: 'Wind Chimes',
      displayNameKo: '풍경 소리',
      isFree: false,
    ),
    AlarmSound(
      assetPath: 'assets/sounds/jazz_morning.mp3',
      displayName: 'Jazz Morning',
      displayNameKo: '재즈 모닝',
      isFree: false,
    ),
    AlarmSound(
      assetPath: 'assets/sounds/nature_stream.mp3',
      displayName: 'Nature Stream',
      displayNameKo: '시냇물 소리',
      isFree: false,
    ),
    AlarmSound(
      assetPath: 'assets/sounds/energetic_wake.mp3',
      displayName: 'Energetic Wake',
      displayNameKo: '활기찬 기상',
      isFree: false,
    ),
  ];

  static AlarmSound? getByPath(String path) {
    try {
      return all.firstWhere((s) => s.assetPath == path);
    } catch (_) {
      return null;
    }
  }

  static List<AlarmSound> getAvailable(bool hasFullAccess) {
    if (hasFullAccess) return all;
    return all.where((s) => s.isFree).toList();
  }
}
