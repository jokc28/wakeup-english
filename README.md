# WakeUp English

A mission alarm clock app where users must solve English quizzes to dismiss alarms. Inspired by Alarmy.

## Features

- **Mission Alarms**: Set alarms that require solving English quizzes to dismiss
- **Quiz Types**: Multiple choice, fill-in-the-blank, and translation questions
- **Difficulty Levels**: Easy, Medium, and Hard quiz difficulties
- **Repeat Alarms**: Support for daily, weekday, weekend, or custom day schedules
- **Snooze Control**: Configurable snooze duration and maximum snoozes
- **Bilingual Support**: English and Korean localization
- **Learning Progress**: Tracks quiz performance to prioritize weak areas

## Tech Stack

- **Flutter** 3.x
- **State Management**: Riverpod with code generation
- **Database**: Drift (SQLite)
- **Routing**: go_router
- **Alarms**: alarm package
- **Architecture**: Feature-first Clean Architecture

## Getting Started

### Prerequisites

- Flutter SDK 3.2.0 or higher
- Dart 3.2.0 or higher
- Android Studio / Xcode for mobile development

### Installation

1. Clone the repository:
   ```bash
   cd wakeup_english
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Generate code (Drift database and Riverpod providers):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                 # Entry point
├── app.dart                  # App widget with theme and routing
├── core/
│   ├── constants/           # Colors and strings
│   ├── database/            # Drift database setup
│   ├── router/              # go_router configuration
│   ├── services/            # AlarmService
│   ├── utils/               # Extensions and helpers
│   └── l10n/               # Localization files (ARB)
├── features/
│   ├── alarm/               # Alarm feature
│   │   ├── data/           # Models and repositories
│   │   ├── domain/         # Entities
│   │   └── presentation/   # Providers, screens, widgets
│   ├── quiz/               # Quiz feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── settings/           # Settings feature
└── shared/
    └── widgets/            # Common widgets
```

## Platform Setup

### Android

The AndroidManifest.xml includes all necessary permissions for:
- Exact alarms (SCHEDULE_EXACT_ALARM)
- Full-screen intents
- Boot completed receiver
- Foreground service
- Wake lock

Minimum SDK: API 26 (Android 8.0)

### iOS

The Info.plist configures:
- Background audio mode
- Background fetch
- Notification permissions

Minimum iOS: 14.0

## Adding Quiz Questions

Quiz questions are stored in `assets/data/quiz_questions.json`. Each question has:

```json
{
  "id": "unique_id",
  "type": "multiple_choice",
  "category": "vocabulary",
  "difficulty": "easy",
  "question": "Question text in English",
  "question_ko": "한국어 번역",
  "options": ["A", "B", "C", "D"],
  "correct_answer": "A",
  "explanation": "Why A is correct",
  "explanation_ko": "설명 한국어 번역"
}
```

## Building for Release

### Android
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## License

MIT License
