import '../../../../core/l10n/app_localizations.dart';
import '../../domain/entities/alarm.dart';

/// Localized display name for QuizDifficulty.
String localizedDifficultyName(AppLocalizations l10n, QuizDifficulty difficulty) {
  switch (difficulty) {
    case QuizDifficulty.easy:
      return l10n.difficultyEasy;
    case QuizDifficulty.medium:
      return l10n.difficultyMedium;
    case QuizDifficulty.hard:
      return l10n.difficultyHard;
  }
}

/// Localized repeat days display for an AlarmEntity.
String localizedRepeatDaysDisplay(AppLocalizations l10n, AlarmEntity alarm) {
  if (alarm.repeatDays.isEmpty) return l10n.repeatOnce;
  if (alarm.isDaily) return l10n.repeatDaily;
  if (alarm.isWeekdays) return l10n.repeatWeekdays;
  if (alarm.isWeekends) return l10n.repeatWeekends;

  final dayNames = [
    l10n.monday,
    l10n.tuesday,
    l10n.wednesday,
    l10n.thursday,
    l10n.friday,
    l10n.saturday,
    l10n.sunday,
  ];
  final sortedDays = List<int>.from(alarm.repeatDays)..sort();
  return sortedDays.map((d) => dayNames[d]).join(', ');
}
