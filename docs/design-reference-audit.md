# Design Reference Audit

## GitHub references checked

- `adeeteya/Awake-AlarmApp`: modern Flutter alarm app with repeat alarms, theme settings, vibration, volume, sound selection, snooze, and dismissal challenges. Useful reference for dense alarm-edit controls and wake-up challenge flow.
- `ollinmagno/duolingo-flutter`: Flutter Duolingo-style interface clone. Useful reference for friendly progression, high-contrast quiz feedback, and compact learning-status cards.
- GitHub `alarm-clock` topic: useful for validating that alarm apps generally prioritize fast scanning, large time display, repeat/snooze controls, and status clarity over decorative screens.

## Applied direction

- Keep the app as a daily utility first: the first screen now emphasizes next alarm time, level, XP, and streak status.
- Make repeated UI quieter: cards use tighter radius, lighter borders, and restrained shadows.
- Preserve the existing warm morning identity while reducing the beige/orange-only feel with soft green surfaces and clear action green.
- Replace emoji-led decoration with Material icons so the interface feels more app-native and consistent across platforms.

## Deferred major updates

- `alarm` 4 to 5, `riverpod` 2 to 3, `go_router` 14 to 17, and `purchases_flutter` 8 to 10 are available but require API migration and regression testing. They should be handled as a separate dependency migration task rather than mixed into visual cleanup.
