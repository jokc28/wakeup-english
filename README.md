# 옥모닝 (OK-Morning)

An energetic English mission alarm for a successful morning. Solve English quizzes to dismiss alarms and start your day with learning!

## Features

- **Mission Alarms**: Set alarms that require solving English quizzes to dismiss
- **Quiz Types**: Multiple choice, fill-in-the-blank, translation, word scramble, and speaking challenge
- **Difficulty Levels**: Easy, Medium, and Hard quiz difficulties
- **Morning Streak**: Track your consecutive wake-up streak for motivation
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
│   ├── services/            # AlarmService, StreakService
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
│   ├── settings/           # Settings feature
│   └── subscription/       # Subscription/paywall feature
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

## Adding Quiz Content

Quiz content is seeded from verified Reel expression data in
`assets/data/reel_expressions.json`. Each item has:

```json
{
  "id": 1,
  "expression_en": "Put yourself out there",
  "expression_meaning_kr": "적극적으로 나서다",
  "situation_kr": "용기를 내서 사람 만날 때",
  "description_kr": "새로운 사람을 만나거나 기회를 잡을 때 쓰는 표현이에요.",
  "category": "일상대화",
  "difficulty": "intermediate",
  "reel_url": "https://www.instagram.com/reel/DX86xDZNS3X/",
  "source": "instagram_reel"
}
```

The seeder only accepts trusted Instagram Reel entries, generates multiple
choice options, and spreads unlock levels across levels 1-50.

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
