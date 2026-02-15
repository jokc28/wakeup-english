# WakeUp English - Developer Handoff Guide

## Quick Start

```bash
# 1. Install dependencies
flutter pub get

# 2. Generate Drift database & Riverpod code
dart run build_runner build --delete-conflicting-outputs

# 3. Run on iOS Simulator
flutter run -d iphone

# 4. Run on Android Emulator
flutter run -d emulator

# 5. Run static analysis
flutter analyze

# 6. Run integration tests
flutter test integration_test/app_flow_test.dart
```

## Project Overview

WakeUp English is a mission alarm clock app (Alarmy-inspired) where users must solve English quizzes to dismiss alarms. Built with Flutter using feature-first Clean Architecture.

### Tech Stack

| Layer           | Technology                                |
|-----------------|-------------------------------------------|
| Framework       | Flutter 3.x (Dart SDK >=3.2.0)            |
| State Mgmt     | Riverpod + code generation                |
| Database        | Drift (type-safe SQLite)                  |
| Routing         | go_router                                 |
| Alarm Engine    | `alarm` package (v4.1.0)                  |
| Permissions     | permission_handler                        |
| UI Scaling      | flutter_screenutil                        |
| i18n            | flutter_localizations + intl              |

### Architecture

```
lib/
  core/           # Shared infrastructure (DB, router, services, constants)
  features/       # Feature-first modules
    alarm/        # Alarm CRUD, scheduling, list/edit screens
    quiz/         # Quiz engine, lock screen, answer widgets
    settings/     # App settings screen
  shared/         # Reusable widgets (CommonButton, etc.)
```

Each feature follows `data/ -> domain/ -> presentation/` layers.

---

## App Identity

| Field                  | Value                                      | File Location                                        |
|------------------------|--------------------------------------------|------------------------------------------------------|
| App Name (Display)     | WakeUp English                             | `ios/Runner/Info.plist` (CFBundleDisplayName)        |
| App Name (Internal)    | wakeup_english                             | `pubspec.yaml` (name)                                |
| Android Package ID     | com.wakeup.english.wakeup_english          | `android/app/build.gradle.kts` (applicationId)       |
| iOS Bundle ID          | com.wakeup.english.wakeupEnglish           | `ios/Runner.xcodeproj/project.pbxproj` (PRODUCT_BUNDLE_IDENTIFIER) |
| Version                | 1.0.0+1                                   | `pubspec.yaml` (version)                             |
| Min Android SDK        | Flutter default (API 21)                   | `android/app/build.gradle.kts` (minSdk)              |
| Min iOS Version        | 14.0                                       | `ios/Podfile`, `ios/Runner/Info.plist`                |

### Changing App Identity

To rename the app or change bundle IDs:
1. **Android**: Update `applicationId` in `android/app/build.gradle.kts` and `package` in `AndroidManifest.xml`
2. **iOS**: Search-replace `PRODUCT_BUNDLE_IDENTIFIER` in `project.pbxproj`
3. **Display Name**: Update `CFBundleDisplayName` in `ios/Runner/Info.plist` and `android:label` in `AndroidManifest.xml`

---

## Signing & Keys Checklist

### Android Release Signing

The release build currently uses **debug keys** (`signingConfig = signingConfigs.getByName("debug")`).

Before publishing to Google Play:

1. **Generate a keystore:**
   ```bash
   keytool -genkey -v -keystore ~/upload-keystore.jks \
     -keyalg RSA -keysize 2048 -validity 10000 \
     -alias upload
   ```

2. **Create `android/key.properties`** (DO NOT commit this file):
   ```properties
   storePassword=<password>
   keyPassword=<password>
   keyAlias=upload
   storeFile=<path-to>/upload-keystore.jks
   ```

3. **Update `android/app/build.gradle.kts`:**
   ```kotlin
   // Add above android {} block:
   val keystoreProperties = Properties()
   val keystorePropertiesFile = rootProject.file("key.properties")
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(FileInputStream(keystorePropertiesFile))
   }

   // Inside android.buildTypes.release:
   signingConfig = signingConfigs.create("release") {
       keyAlias = keystoreProperties["keyAlias"] as String
       keyPassword = keystoreProperties["keyPassword"] as String
       storeFile = file(keystoreProperties["storeFile"] as String)
       storePassword = keystoreProperties["storePassword"] as String
   }
   ```

4. **Add to `.gitignore`:**
   ```
   android/key.properties
   *.jks
   *.keystore
   ```

### iOS Release Signing

1. **Apple Developer Account** required (https://developer.apple.com)
2. Open `ios/Runner.xcworkspace` in Xcode
3. Select Runner target > Signing & Capabilities
4. Choose your Team and let Xcode manage signing
5. For distribution: create an App Store Connect record with the Bundle ID

---

## Launcher Icon

Currently using the default Flutter icon. To replace:

1. Add your icon to `assets/icon/app_icon.png` (1024x1024, no transparency for iOS)
2. Add the `flutter_launcher_icons` package:
   ```yaml
   # pubspec.yaml dev_dependencies
   flutter_launcher_icons: ^0.14.3
   ```
3. Add configuration to `pubspec.yaml`:
   ```yaml
   flutter_launcher_icons:
     android: true
     ios: true
     image_path: "assets/icon/app_icon.png"
     adaptive_icon_background: "#4A56E2"
     adaptive_icon_foreground: "assets/icon/app_icon_foreground.png"
   ```
4. Run: `dart run flutter_launcher_icons`

---

## Platform Permissions

### Android (`android/app/src/main/AndroidManifest.xml`)

| Permission                     | Purpose                              |
|--------------------------------|--------------------------------------|
| RECEIVE_BOOT_COMPLETED         | Reschedule alarms after device reboot|
| VIBRATE                        | Alarm vibration                      |
| USE_FULL_SCREEN_INTENT         | Show alarm over lock screen          |
| SCHEDULE_EXACT_ALARM           | Precise alarm timing (Android 12+)  |
| USE_EXACT_ALARM                | Exact alarm (Android 14+)           |
| FOREGROUND_SERVICE             | Keep alarm alive in background       |
| WAKE_LOCK                      | Wake device screen                   |
| DISABLE_KEYGUARD               | Show over lock screen                |
| POST_NOTIFICATIONS             | Notification channel (Android 13+)  |

### iOS (`ios/Runner/Info.plist`)

| Key                               | Value               | Purpose                  |
|-----------------------------------|----------------------|--------------------------|
| UIBackgroundModes                 | audio, fetch, processing | Alarm in background   |
| BGTaskSchedulerPermittedIdentifiers | com.wakeup.wakeup_english.alarm | Background task ID |
| NSUserNotificationUsageDescription | (set)               | Notification permission  |

---

## Key Flows

### Alarm -> Quiz Flow
```
AlarmService.onAlarmRing (stream)
  -> app.dart listener
    -> AppRouter.navigateToQuizLock(alarmId)
      -> QuizLockScreen (PopScope canPop: false)
        -> Quiz session (N questions)
          -> All correct -> "Stop Alarm" button
            -> AlarmService.stopAlarm()
              -> Navigate to AlarmListScreen
```

### Quiz Types
- **multipleChoice**: 4 options, auto-submit on tap
- **fillInTheBlank**: Text input with typo tolerance (Levenshtein distance)
- **translation**: Text input, Korean->English
- **listening**: TODO (falls back to multipleChoice)

---

## Database

Drift SQLite with 3 tables:
- `alarms` - Alarm configuration (time, repeat days, quiz settings, sound)
- `quiz_progress` - Per-question performance tracking for adaptive selection
- `alarm_history` - Log of alarm fires and quiz results

Generated files: `app_database.g.dart` (run `build_runner` after schema changes)

---

## Known Issues / TODOs

- [ ] Listening quiz type not implemented (falls back to multipleChoice)
- [ ] Undo for alarm deletion not wired up
- [ ] Custom alarm sound selection UI not built (uses default_alarm.mp3)
- [ ] Custom fonts commented out in pubspec.yaml (Pretendard ready to add)
- [ ] No onboarding / first-launch flow
- [ ] No analytics or crash reporting
- [ ] Release signing not configured (using debug keys)
- [ ] Launcher icon is still Flutter default

---

## Build Commands

```bash
# Debug build
flutter run

# Release APK
flutter build apk --release

# Release iOS (requires signing)
flutter build ios --release

# App Bundle for Google Play
flutter build appbundle --release

# Clean build
flutter clean && flutter pub get && dart run build_runner build --delete-conflicting-outputs
```
