# Quality

## Active Gates

Every code change should pass:

```sh
make check
```

This runs:

- `dart format --set-exit-if-changed .`
- `flutter analyze`
- `flutter test`

## Minimum Acceptance Standard

- No analyzer errors.
- Tests pass locally.
- Formatting is stable.
- Flutter app shell remains runnable.
- Documentation changes keep links and paths accurate.

## Product Quality Priorities

For the P0 demo, quality means the 90-second loop is reliable and legible:

- The concept is visible in the first screen.
- The draw result is screenshotable.
- AI failure cannot break the demo.
- Mission success and failure both produce a reward state.
- Room feed can show the current result without real social infrastructure.

## Future Gates

Add more gates only when the project has enough surface area to justify them:

- Layer dependency checks.
- Golden or screenshot tests for key demo moments.
- Integration tests for the P0 flow.
- Firebase or AI contract tests after P1 infrastructure is introduced.
