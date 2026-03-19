# OK-Morning (옥모닝) — Technical Overview

> Updated: 2026-02-24

## Project Identity

| Field | Value |
|-------|-------|
| App Name | **OK-Morning** (옥모닝) |
| Platform | iOS (Flutter, single-codebase) |
| Value Prop | English-learning alarm clock with gamified Level 1-50 progression. Users solve word-scramble quizzes to dismiss their morning alarm, earning XP and mastering vocabulary along the way. |

---

## Tech Stack & Architecture

| Layer | Technology |
|-------|-----------|
| UI Framework | Flutter 3.x (Dart) |
| State Management | Riverpod (+ `riverpod_annotation` codegen) |
| Local Database | Drift 2.x (SQLite via `drift/native`) |
| Routing | GoRouter |
| In-App Purchases | RevenueCat (`purchases_flutter`) |
| Speech Recognition | `speech_to_text` |
| Animations | `flutter_animate`, `confetti` |
| i18n | ARB-based (`app_en.arb`, `app_ko.arb`) |

### Database Schema (v2)

Six tables managed by Drift:

| Table | Purpose |
|-------|---------|
| `Alarms` | User-created alarm definitions (time, repeat days, quiz config) |
| `AlarmHistory` | Trigger/dismiss audit log per alarm |
| `QuizProgress` | Legacy per-question answer stats (backward compat) |
| `VocabularyItems` | **Primary content table.** Every quiz item with mastery tracking, unlock level, free-tier flag |
| `UserLevelProgress` | Singleton row: current level, total XP, daily XP, quiz/mastery counts |
| `XpTransactions` | Append-only XP ledger (source, amount, level at time) |

---

## Core Domain Logic

### Alarm → Quiz → Dismiss Flow

```
Alarm fires → Lock screen (immersive) → User slides to start
  → Word-scramble quiz (N questions from VocabularyItems)
  → Quiz completes → XP award check → Completed phase → Dismiss
```

All quiz questions are fetched from `VocabularyRepository` (DB-backed), filtered by user level, subscription tier, and a 3-day cooldown window.

### Mastery Tracking

A vocabulary item becomes `is_mastered = true` when:

1. `times_presented >= 3` (seen at least 3 times), **AND**
2. `times_correct_first_attempt / times_presented >= 0.80` (80%+ first-attempt accuracy)

Once mastered, `mastered_at` timestamp is set. Mastery awards a 25 XP bonus per item.

### Leveling System (Levels 1–50)

**XP-to-next-level formula:**

```
XP_needed(n) = 100(n+1) + 10(n+1)²
```

Where `n` = current level. Examples:
- Level 1 → 2: `100(2) + 10(4) = 240 XP`
- Level 10 → 11: `100(11) + 10(121) = 2,310 XP`
- Level 49 → 50: `100(50) + 10(2500) = 30,000 XP`

**Session XP calculation:**

```
base       = 20 × questionCount
accuracy   = 15 × correctCount
perfect    = 50  (if 100% correct)
mastery    = 25 × newMasteryCount
subtotal   = base + accuracy + perfect + mastery
total      = subtotal × streakMultiplier
```

**Streak multipliers:** 3d → 1.1×, 7d → 1.2×, 14d → 1.3×, 30d → 1.5×

---

## Monetization & Subscription Logic

### 7-Day Free Trial

- On first launch, `install_date` is stored in `SharedPreferences`.
- Trial active = `now < install_date + 7 days`.
- Free-tier users see only items where `is_free = true` (levels ≤ 5).
- Premium users see all items up to their current unlock level.

### Paywall Hook (XP Interception)

The critical monetization gate lives in `quiz_lock_screen.dart`:

```
Quiz completes → _awardXpOnCompletion() checks trial status:
  IF premium / trial active:
    → Award XP, save streak, show full completion screen
  IF trial expired:
    → Set _trialExpiredOnComplete = true
    → Skip XP/streak/mastery saving
    → Show score (visual only) + "Progress Locked" indicator
    → Auto-present bottom sheet with subscribe CTA
    → User can still dismiss alarm (alarm functionality preserved)
```

Key principle: **the alarm always works** (the app stays useful). But XP, level progress, streak recording, and mastery tracking are all gated behind subscription. This creates FOMO without breaking the core alarm utility.

Additionally, `quiz_provider.dart` gates `recordAnswerWithMastery()` behind `hasFullAccessProvider` — expired users get no mastery updates written to the DB even during the quiz.

---

## Data Seeding Pipeline

### `DbSeeder` (`lib/core/database/utils/db_seeder.dart`)

Two entry points:

| Method | Use Case |
|--------|----------|
| `seedFromAsset(db)` | Called during DB migration (`onCreate` / `onUpgrade`). Reads `assets/data/level_vocabulary.json`. |
| `seedFromJsonString(db, json)` | Dev utility for bulk-loading external JSON. Used by the Settings "DEV: Force Seed DB" button. |

**Seed data format** (`level_vocabulary.json`):

```json
{
  "word": "BRUSH",
  "hint": "이를 닦을 때 사용하는 동작 (teeth ~)",
  "type": "definition",
  "difficulty_level": 1
}
```

The seeder maps `difficulty_level` ranges to difficulty labels (`1-15 → easy`, `16-35 → medium`, `36-50 → hard`), generates stable `questionId` values (`lv{level}_{word}`), and uses `InsertMode.insertOrIgnore` to safely skip duplicates on re-seed. Items at level ≤ 5 are automatically flagged `is_free = true`.

### Dev Tooling

In debug mode, `Settings → DEV: Force Seed DB` triggers `DbSeeder.seedFromAsset()` and displays the insert count via SnackBar.

---

## Directory Structure (Key Paths)

```
lib/
├── core/
│   ├── constants/          # AppColors, AppStrings, IapConstants
│   ├── database/
│   │   ├── app_database.dart       # Drift DB, migrations, CRUD ops
│   │   ├── tables/                 # Table definitions (6 tables)
│   │   └── utils/db_seeder.dart    # Seeding pipeline
│   ├── l10n/               # i18n (app_en.arb, app_ko.arb)
│   ├── router/             # GoRouter config
│   └── services/           # SubscriptionService, StreakService, AlarmService
├── features/
│   ├── alarm/              # Alarm CRUD, scheduling, repository
│   ├── quiz/
│   │   ├── data/repositories/
│   │   │   ├── quiz_repository.dart       # Legacy QuizProgress recording
│   │   │   └── vocabulary_repository.dart # PRIMARY: DB-backed question fetching
│   │   ├── domain/
│   │   │   ├── entities/quiz_question.dart
│   │   │   └── utils/xp_formula.dart      # XP math
│   │   └── presentation/
│   │       ├── providers/                 # QuizSession, LevelProgress
│   │       ├── screens/quiz_lock_screen.dart  # Lock screen + paywall hook
│   │       └── widgets/                   # WordScramble, MultipleChoice, etc.
│   ├── settings/           # Settings screen with dev tools
│   └── subscription/       # Paywall screen
└── assets/data/
    └── level_vocabulary.json  # Seed data (Level 1-50 word scramble items)
```
