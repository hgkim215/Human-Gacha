# Human-Gacha Agent Guide

## Project Goal

Human-Gacha is a demo-first Flutter MVP for the Korean product concept
"인간 가챠": a B-grade self-management gacha app where users draw a daily
human grade, receive a mission, and share the result in a lightweight room feed.

The source of product truth is `docs/product/인간_가챠_PRD_v2_demo_first.md`.
Build P0 demo value before P1/P2 production features.

## Working Principles

- PRD first: tie product decisions back to the PRD before inventing behavior.
- P0 first: prioritize demo user entry, onboarding choices, mood selection,
  draw animation, AI/fallback card, mission reward, and dummy room feed.
- Demo stability first: keep demo mode, fixed seeds, forced grades, and fallback
  cards working even when network or AI calls fail.
- Keep implementation small and visible: prefer simple Flutter/Dart structures
  that an agent can read and debug locally.

## Do Not Overbuild Early

- Do not add Google login, Firebase, Firestore, real friend invites, payment,
  ranking, or photo verification until the P0 loop is complete.
- Do not make the first screen a landing page. The first useful screen should
  expose the gacha concept quickly.
- Do not hide demo data behind external services during P0.

## Verification Commands

- `make get`: install Flutter dependencies.
- `make format`: format Dart code.
- `make format-check`: fail if formatting would change files.
- `make analyze`: run static analysis.
- `make test`: run Flutter tests.
- `make check`: run format check, analysis, and tests.

Run `make check` before handing off implementation work unless the task is
documentation-only and no code paths changed.

## Documentation Map

- `docs/product/`: product requirements and demo scope.
- `docs/architecture/`: app layering and dependency direction.
- `docs/exec-plans/`: execution plans and decision logs.
- `docs/quality/`: quality gates and acceptance checks.
- `docs/reliability/`: demo stability, fallback, and failure-mode rules.
- `docs/references/`: source references used to shape this harness.
