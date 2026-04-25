# 0001 Harness Bootstrap

Status: done

## Goal

Set up the repository so future Codex or human implementation work can proceed
from a stable, searchable, verifiable harness.

## Scope

- Add a short root `AGENTS.md` as the agent entry point.
- Move product and harness source references into version-controlled `docs/`.
- Add local verification commands through `Makefile`.
- Add GitHub Actions CI for Flutter formatting, analysis, and tests.

## Key Decisions

- Copy both the PRD and harness guide into the repository instead of relying on
  files outside the repo.
- Keep Flutter architecture rules lightweight and document-only at this stage.
- Do not implement PRD screens or state in this bootstrap step.
- Use `make check` as the default local verification command.

## Implementation Outline

- Create `docs/product`, `docs/references`, `docs/architecture`,
  `docs/exec-plans`, `docs/quality`, and `docs/reliability`.
- Add `AGENTS.md` with project goals, P0-first rules, overbuild warnings,
  verification commands, and documentation map.
- Add a Makefile that wraps Flutter dependency, formatting, analysis, and test
  commands.
- Add `.github/workflows/flutter-check.yml`.

## Verification

- `make check`
- `flutter test`
- Confirm `git status --short` shows only the intended harness files before
  committing.
