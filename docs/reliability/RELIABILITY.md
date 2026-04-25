# Reliability

## Demo Reliability Principle

The P0 demo must complete even if authentication, network, AI generation, or
remote persistence is unavailable.

## Required P0 Safeguards

- Demo mode entry that does not require login.
- Fixed demo user profile: `현기 / 취준 인간`.
- Fixed default mood selection: `잠 부족`, `카페인 필요`, `코테 준비 중`.
- Forced grade selection for demo scenarios, with `SR` or `SSR` as the default.
- Fallback human card shown immediately when AI fails, times out, or returns
  invalid JSON.
- Dummy friend-room and whole-room data embedded locally.

## Failure Handling Rules

- AI generation should never block the result screen beyond the demo timeout.
- Empty or oversized generated text should be normalized client-side.
- Mission success and mission failure must both lead to a visible reward screen.
- Demo data should be clearly treated as demo data in implementation and docs.

## Out of Scope for P0

- Real Google authentication.
- Firestore persistence.
- Real friend invites.
- Real global statistics.
- Photo verification.
- Push notifications.
