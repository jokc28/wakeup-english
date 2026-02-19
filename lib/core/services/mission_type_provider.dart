import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_strings.dart';
import '../../features/quiz/domain/entities/quiz_question.dart';

/// Manages which mission (quiz) types are enabled for alarm quizzes.
/// Users can toggle wordScramble and speakingChallenge on/off in Settings.
/// multipleChoice, fillInTheBlank, translation are always included from JSON.
class MissionTypeState {
  final bool wordScrambleEnabled;
  final bool speakingChallengeEnabled;

  const MissionTypeState({
    this.wordScrambleEnabled = false,
    this.speakingChallengeEnabled = false,
  });

  MissionTypeState copyWith({
    bool? wordScrambleEnabled,
    bool? speakingChallengeEnabled,
  }) {
    return MissionTypeState(
      wordScrambleEnabled: wordScrambleEnabled ?? this.wordScrambleEnabled,
      speakingChallengeEnabled:
          speakingChallengeEnabled ?? this.speakingChallengeEnabled,
    );
  }
}

final missionTypeProvider =
    StateNotifierProvider<MissionTypeNotifier, MissionTypeState>((ref) {
  return MissionTypeNotifier();
});

class MissionTypeNotifier extends StateNotifier<MissionTypeState> {
  MissionTypeNotifier() : super(const MissionTypeState()) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final types =
        prefs.getStringList(AppStrings.prefEnabledMissionTypes) ?? [];
    state = MissionTypeState(
      wordScrambleEnabled: types.contains('wordScramble'),
      speakingChallengeEnabled: types.contains('speakingChallenge'),
    );
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final types = <String>[];
    if (state.wordScrambleEnabled) types.add('wordScramble');
    if (state.speakingChallengeEnabled) types.add('speakingChallenge');
    await prefs.setStringList(AppStrings.prefEnabledMissionTypes, types);
  }

  void toggleWordScramble(bool enabled) {
    state = state.copyWith(wordScrambleEnabled: enabled);
    _save();
  }

  void toggleSpeakingChallenge(bool enabled) {
    state = state.copyWith(speakingChallengeEnabled: enabled);
    _save();
  }
}

/// Converts some questions to new mission types based on enabled settings.
/// For wordScramble: takes vocabulary/phrase questions with short correctAnswers.
/// For speakingChallenge: takes questions with sentence-length correctAnswers.
List<QuizQuestion> applyMissionTypes(
  List<QuizQuestion> questions,
  MissionTypeState missionState,
) {
  if (!missionState.wordScrambleEnabled &&
      !missionState.speakingChallengeEnabled) {
    return questions;
  }

  final result = <QuizQuestion>[];
  int wordScrambleCount = 0;
  int speakingCount = 0;

  // Calculate how many to convert (roughly 30% each if enabled)
  final maxConvert = (questions.length * 0.3).ceil();

  for (final q in questions) {
    // Try to convert to wordScramble: short single-word answers work best
    if (missionState.wordScrambleEnabled &&
        wordScrambleCount < maxConvert &&
        q.type != QuizType.multipleChoice &&
        q.correctAnswer.split(' ').length == 1 &&
        q.correctAnswer.length >= 3 &&
        q.correctAnswer.length <= 12) {
      result.add(q.copyWith(
        type: QuizType.wordScramble,
        question: 'Unscramble the word',
        options: [],
      ));
      wordScrambleCount++;
      continue;
    }

    // Try to convert to speakingChallenge: sentence answers
    if (missionState.speakingChallengeEnabled &&
        speakingCount < maxConvert &&
        q.type == QuizType.translation &&
        q.correctAnswer.split(' ').length >= 2) {
      result.add(q.copyWith(
        type: QuizType.speakingChallenge,
        question: 'Speak the following sentence in English',
        options: [],
      ));
      speakingCount++;
      continue;
    }

    // Keep original
    result.add(q);
  }

  return result;
}
