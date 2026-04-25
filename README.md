# Human-Gacha

Human-Gacha is a demo-first Flutter MVP for the Korean product concept
`인간 가챠`.

Instead of asking users to write goals, the app lets them pick a few current
states and draws a "human grade" plus a short mission for today. The product is
designed around a 90-second presentation loop: pickup humans, draw animation,
AI/fallback result card, mission reward, and a dummy friend-room feed.

## Product Summary

- One-line pitch: 오늘의 상태를 몇 개 고르면 AI가 인간 등급과 오늘의 미션을 뽑아주는 B급 자기관리 가챠 앱
- Tone: light, goofy, B-grade self-management humor without insulting the user
- P0 priority: demo value, screenshotable moments, and presentation stability
- Reliability rule: even if AI, network, auth, or remote storage fails, the demo loop must still finish

The main product source of truth is
[`docs/product/인간_가챠_PRD_v2_demo_first.md`](docs/product/%EC%9D%B8%EA%B0%84_%EA%B0%80%EC%B1%A0_PRD_v2_demo_first.md).

## Current Scope

The current app is centered on the P0 demo loop.

- Splash with two entry paths: `데모로 시작하기` and onboarding
- Local onboarding and demo user setup
- Home screen with today's pickup humans, buff banners, humanity gauge, and draw CTA
- Mood selection with a 1-3 item limit
- Multi-step draw animation
- Result card generation with fallback safety path
- Mission success/failure reward flow
- Dummy friend room / whole room social stage
- Demo mode presets for stable SR / SSR / failure presentation

Planned but not yet completed as product infrastructure:

- Firebase Auth / Firestore persistence
- Real social graph, invitations, reactions sync
- Production-grade remote AI configuration and secret management

## Demo Flow

The intended presentation path matches the implemented screen structure:

1. Splash or demo entry
2. Home
3. Mood select
4. Draw animation
5. Result card
6. Mission detail
7. Success or failure reward
8. Friend room / whole room summary

Default demo assumptions:

- Demo user: `현기 / 취준 인간`
- Default moods: `잠 부족`, `카페인 필요`, `코테 준비 중`
- Primary showcase result: `SR` or `SSR`
- `LEGEND` is kept as a reserve impact card, not the default demo path

## Tech Stack

- Flutter
- Dart 3.11
- Riverpod for app state
- go_router for navigation
- http for AI API requests
- google_fonts for typography

The repository already includes Firebase-related packages in `pubspec.yaml`, but
the active P0 demo loop is still local-first and does not depend on Firebase to
run.

## Project Structure

```text
lib/
  main.dart
  src/
    app/              # app bootstrap, theme, router
    features/         # splash, onboarding, home, draw, result, mission, social
    shared/           # models, widgets, fallback/AI services
docs/
  product/            # PRD and design direction
  architecture/       # layer and dependency rules
  reliability/        # demo fallback and failure handling rules
  quality/            # quality gates
  exec-plans/         # implementation plans and decisions
test/
  unit/               # draw grade, fallback card, mood selection tests
```

## Getting Started

### Prerequisites

- Flutter SDK installed and available on your shell
- A macOS/iOS or Android Flutter development environment if you want to run the app locally

### Install Dependencies

```sh
make get
```

### Run The App

```sh
flutter run
```

If you want the fastest demo path, start with `데모로 시작하기` on the splash
screen.

## Quality Checks

Run the full local gate before shipping code changes:

```sh
make check
```

This runs:

- `make format-check`
- `make analyze`
- `make test`

## AI And Fallback Behavior

The app is intentionally safe for unstable demo environments.

- `AiCardService` has a 5-second timeout
- If the API key is missing, the request fails, or JSON parsing breaks, the app falls back immediately
- `FallbackCardService` returns deterministic local cards by grade
- Demo mode can force grade and success/failure outcome for repeatable presentations

At the moment, no runtime secret wiring is documented in this repo for live AI
usage. The current implementation is safe to run as a fallback-first demo.

## Key Docs

- [`docs/product/인간_가챠_PRD_v2_demo_first.md`](docs/product/%EC%9D%B8%EA%B0%84_%EA%B0%80%EC%B1%A0_PRD_v2_demo_first.md)
- [`docs/product/DESIGN.md`](docs/product/DESIGN.md)
- [`docs/architecture/ARCHITECTURE.md`](docs/architecture/ARCHITECTURE.md)
- [`docs/reliability/RELIABILITY.md`](docs/reliability/RELIABILITY.md)
- [`docs/quality/QUALITY.md`](docs/quality/QUALITY.md)
- [`docs/exec-plans/0002-p0-demo-loop.md`](docs/exec-plans/0002-p0-demo-loop.md)
- [`docs/exec-plans/0003-p1-firebase-auth.md`](docs/exec-plans/0003-p1-firebase-auth.md)

## Notes

- This repository is optimized for a demo-first MVP, not a production launch
- The first screen should communicate the product concept quickly rather than act as a marketing landing page
- Dummy social data is intentional in P0 and should not be presented as live production data
