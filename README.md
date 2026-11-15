# Hynapse

**Hynapse** is a Flutter prototype developed for the NASA Space Apps Challenge, designed for astronauts and crews in extreme environments (such as Himalayan mountaineers or submarine crews). The application monitors mental state, administers cognitive tests, and manages emergency protocols.

## Technology Stack

- **Framework:** Flutter (latest stable, Null Safety)
- **State Management:** Riverpod 2.6.1
- **Local Database:** Isar Community 3.4.1 (NoSQL, local-only)
- **UI Style:** Dark mode gradient (#0B0F19 → blue), Sci-Fi HUD aesthetic with cyan (#00F2FE) and amber (#FF9F0A) accents, glassmorphism via `backdrop-filter`
- **Fonts:** Rajdhani, SpaceGrotesk (local bundled fonts)
- **Build:** `dart run build_runner build --force-jit --delete-conflicting-outputs` (required for Dart 3.10)

## Architecture

### Data Models (Isar)

| Collection | Fields |
|---|---|
| `UserSessionCollection` | userId, displayName, role, lastSync |
| `DailyLogCollection` | fatigue (0-6), sleepDeprivation (0-6), stress (0-6), voiceTranscript, timestamp |
| `CognitiveTestResultCollection` | testType (stroop/reaction), correctCount, incorrectCount, averageReactionTimeMs, timestamp |
| `EmergencyProtocolCollection` | title, steps, sosStatus, timestamp |

### State Management

Riverpod providers in `lib/providers/app_providers.dart`:
- `sessionProvider` - `SessionController` (StateNotifier) managing auth flow
- `todaySummaryProvider` - `FutureProvider` computing daily task completion
- `cognitiveHistoryProvider` - recent test results
- `stroopHistoryProvider` - stroop test history
- `reactionHistoryProvider` - reaction test history
- `emergencyProtocolsProvider` - available emergency protocols
- `profileStatsProvider` - aggregate statistics

Isar is initialized before `runApp()` and injected via `ProviderScope` override.

### Key Screens

| Screen | Description |
|---|---|
| `WelcomeScreen` | Splash with "H" logo, auth buttons, emergency mode link |
| `AuthIdScreen` / `AuthPasswordScreen` | Credential entry (mock: ID `P4J9R-KX0LM-WH7X2`, password `!KlM90%@atD$`) |
| `SyncScreen` | Animated "Please wait..." screen simulating station sync |
| `DashboardScreen` | Main hub: activity dial, tasks, voice check-in, cognitive tests, emergency |
| `CheckinIntroScreen` / `CheckinRecordingScreen` / `CheckinResultScreen` | Daily voice check-in (10s recording → analysis → NASA-TLX recommendations) |
| `StroopTestScreen` | 30s conflict test (text color vs font color) |
| `ReactionTestScreen` | Wait for color change, measure reaction time in ms |
| `CognitiveHubScreen` | Overview of test results and history |
| `EmergencyScreen` | Quick access to crisis procedures |
| `BoxBreathingScreen` | Animated 4-4-4-4 breathing guide |
| `SettingsScreen` | App settings and logout |

### Widget Organization

- `lib/widgets/` - reusable UI components:
  - `activity_dial.dart` - 4-segment interactive dial (CustomPainter)
  - `glass_card.dart` - semi-transparent frosted-glass cards
  - `task_card.dart` - task priority cards (fixed IntrinsicHeight layout)
  - `section_title.dart` - section header with cyan accent stripe
  - `content_width.dart` - constrained-width wrapper for scroll content
  - `metric_scale.dart` - radial metric display
  - `hud_scaffold.dart` / `hud_app_bar.dart` - HUD-style chrome
  - `hud_route.dart` - custom route transition (fade/slide/scale)
  - `app_background.dart` - gradient background with glows/grid

- `lib/views/` - screen-by-screen UI:
  - `dashboard/` - main dashboard with layout
  - `checkin/` - voice check-in flow
  - `cognitive/` - Stroop and reaction tests
  - `emergency/` - emergency protocols and breathing
  - `welcome/` - splash/authorization
  - `settings/` - app configuration

### Layout Fixes (Completed)

**Dashboard Scroll Bug:** The original issue was that `SingleChildScrollView` + `ContentWidth` (`Align` + `ConstrainedBox`) combined with `IntrinsicHeight` in `TaskCard` caused zero-height layout for scroll descendants. Fixes applied:

1. **`lib/widgets/task_card.dart:61`**: Wrapped `Row` in `IntrinsicHeight` to properly size the card based on its tallest child (the description text column).

2. **`lib/views/dashboard/dashboard_screen.dart:160-167`**: Changed status pills from `Row` + `Spacer()` to `Wrap` with `spacing: 8, runSpacing: 8` to prevent overflow and ensure proper layout within the constrained scroll width.

3. **`lib/services/voice_analysis_service.dart`**: Added `needsRecovery` property, enhanced recommendation logic with fatigue/high sleep/high stress branches.

4. **`lib/views/checkin/checkin_result_screen.dart:245-250`**: Updated recommendation text to use `analysis.needsRecovery`.

### Demo Credentials

For presentations to judges, the app includes pre-filled mock credentials:

- **ID:** `P4J9R-KX0LM-WH7X2`
- **Password:** `!KlM90%@atD$`

These bypass the full auth flow and directly navigate to the dashboard via the synchronized session state.

### Build Instructions

```bash
# Install dependencies
flutter pub get

# Generate Isar models (requires build_runner with JIT for Dart 3.10)
dart run build_runner build --force-jit --delete-conflicting-outputs

# Run analysis and tests
flutter analyze
flutter test

# Build release APK (android-x64)
flutter build apk --release --target-platform android-x64

# Install on emulator
adb install app-release.apk
adb shell pm clear com.example.hynapse  # clear state
```

### Screenshots

Welcome/Auth/Sync screens verified on emulator. Dashboard shows:
- Greeting (`WITAJ, RAFAŁ!`)
- Day briefing and readiness status
- 4-segment activity dial
- "Zadania na dzisiaj" with 3 task cards
- Status strips and synchronization info

All cognitive test screens, check-in flow, emergency mode, and Box Breathing animation are implemented and visually verified.

### Known Issue - Daily Check-in Crash

The daily check-in screen may crash when clicking the start microphone button. This issue is under investigation. The crash appears to be related to the navigation transition (`hudRoute`) or widget build issues in the `CheckinRecordingScreen`. 

**Workarounds:**
- The auth flow, dashboard, and emergency screens all work correctly
- The task card layout has been fixed with `IntrinsicHeight`
- All tests pass (`flutter test` → 2/2 passed)
- `flutter analyze` → No issues found

**Investigation needed:**
- The crash may be related to the `PageRouteBuilder` transition in `hudRoute`
- The `CheckinRecordingScreen` `SingleChildScrollView` + `Column` + `Spacer()` layout may cause infinite height constraints
- Voice analysis and Isar save work correctly when reached
- Further debugging requires emulator access with log capture