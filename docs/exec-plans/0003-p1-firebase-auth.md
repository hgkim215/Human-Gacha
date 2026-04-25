# 0003 P1 인증 및 영구 저장소 연동 계획 (Firebase)

상태: in-progress

## 목표

현재 메모리 기반으로 동작하는 `Human-Gacha` 데모 앱을 P1 제품 MVP 수준으로 고도화한다. Google 로그인과 Firebase Firestore를 연결하여 사용자 데이터를 기기 재시작 후에도 영구 보존한다.

이 계획의 완료 기준:
- [ ] 앱 실행 시 로그인 상태를 확인하고, 미가입 시 Google 로그인 및 온보딩 화면으로 이동
- [ ] 로그인된 사용자의 정보(자아 파편, 스트릭, 최근 뽑기 결과 등)가 Firestore에 저장 및 실시간 동기화
- [ ] `AuthRepository` 및 `UserRepository` 인터페이스를 구현하여 비즈니스 로직과 데이터베이스 결합도 낮춤
- [ ] 1일 1회 가챠 제한 로직 추가 (자아 파편을 사용해 추가 뽑기 가능하도록 확장 여지)

## 주요 작업 내역

### 1. Firebase 및 초기 설정
- [ ] `firebase_core`, `firebase_auth`, `cloud_firestore`, `google_sign_in` 패키지 추가 완료
- [ ] **(사용자 수행 필요)** Firebase Console에서 프로젝트 생성 및 `flutterfire configure` 실행
- [ ] `lib/main.dart`에서 `Firebase.initializeApp()` 호출 적용

### 2. 로그인 및 인증 플로우 (Auth)
- [ ] `lib/src/shared/repositories/auth_repository.dart` 정의
- [ ] `lib/src/features/auth/login_screen.dart` 화면 추가 (Google Sign In 버튼)
- [ ] `go_router` 리다이렉션 로직 수정: `User` 객체 유무에 따라 `/login` 또는 `/`으로 자동 라우팅

### 3. 사용자 정보 영구 저장 (Firestore)
- [ ] `lib/src/shared/repositories/user_repository.dart` 정의
- [ ] 사용자가 가입/로그인 시 Firestore `users/{uid}` 문서 확인 및 생성
  - **Schema 예시**: `uid`, `nickname`, `persona`, `fragments`(파편), `streak`(연속), `lastDrawDate`
- [ ] `UserProfile` 모델을 Firestore 직렬화/역직렬화(JSON) 가능하도록 `fromJson`, `toJson` 추가

### 4. 뽑기 및 미션 상태 보존
- [ ] 기존 `DemoState`와 글로벌 프로바이더 대신, `UserRepository`에서 스트림으로 유저 상태를 받아오도록 Riverpod 상태 모델링 개편
- [ ] 가챠를 돌렸을 때(Draw) Firestore의 `users/{uid}/daily_draw` 콜렉션에 기록
- [ ] 미션 완료/실패 시 `fragments` 및 `streak` 업데이트를 트랜잭션으로 처리

### 5. Fallback 전략 유지
- [ ] Firebase 네트워크 단절 시나리오를 대비하여 기존 로컬 캐싱(Shared Preferences 고려)이나 P0 때 작성한 인메모리/더미 모드(`demo_state`)를 폴백으로 사용할 수 있도록 유지

## 다음 단계
1. Firebase 프로젝트 설정 (`flutterfire configure` 및 Google 로그인 활성화)
2. `AuthRepository`와 `UserRepository` 인터페이스 및 Firebase 구현체 작성
3. `LoginScreen` 구현 및 `app_router.dart` 라우팅 수정
