# Architecture

## Current State

The repository is intentionally a Flutter shell. Product implementation starts
after the harness is in place.

## Recommended App Shape

- `lib/main.dart`: entry point only.
- `lib/src/app`: app bootstrap, router, theme, and top-level providers.
- `lib/src/features/<feature>`: feature-owned screens, state, data, and domain
  logic.
- `lib/src/shared`: reusable widgets, utilities, constants, and cross-feature
  contracts.

## Dependency Direction

Use this direction by default:

```text
app -> features -> shared
```

Feature modules should not directly import each other. If two features need the
same model or helper, move the shared contract into `lib/src/shared`.

## P0 Feature Boundaries

Keep the first demo loop local and deterministic:

- Demo user and onboarding choices live in local app state.
- Mood selection and draw state should not require authentication.
- AI card generation must have an immediate fallback path.
- Room and whole-room views use demo data until the P0 loop is complete.

## Enforcement Level

Architecture is documented, not mechanically enforced yet. The active gates are
formatting, analyzer, tests, and CI. Add structural checks only after the app has
enough code for violations to become likely.
