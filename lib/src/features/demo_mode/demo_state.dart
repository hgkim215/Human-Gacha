import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/models/human_grade.dart';
import '../../shared/models/user_profile.dart';

/// Demo Mode 설정
class DemoConfig {
  const DemoConfig({
    this.isDemoMode = true,
    this.forcedGrade = HumanGrade.sr,
    this.forcedOutcome = 'success', // 'success' | 'failure'
    this.aiMode =
        'fallbackAllowed', // 'aiFirst' | 'fallbackOnly' | 'fallbackAllowed'
    this.seed = 'human-gacha-demo-001',
    this.user = UserProfile.demo,
  });

  final bool isDemoMode;
  final HumanGrade forcedGrade;
  final String forcedOutcome;
  final String aiMode;
  final String seed;
  final UserProfile user;

  DemoConfig copyWith({
    bool? isDemoMode,
    HumanGrade? forcedGrade,
    String? forcedOutcome,
    String? aiMode,
    String? seed,
    UserProfile? user,
  }) {
    return DemoConfig(
      isDemoMode: isDemoMode ?? this.isDemoMode,
      forcedGrade: forcedGrade ?? this.forcedGrade,
      forcedOutcome: forcedOutcome ?? this.forcedOutcome,
      aiMode: aiMode ?? this.aiMode,
      seed: seed ?? this.seed,
      user: user ?? this.user,
    );
  }
}

/// Demo 설정 State Notifier
class DemoStateNotifier extends StateNotifier<DemoConfig> {
  DemoStateNotifier() : super(const DemoConfig());

  void setDemoMode(bool isDemoMode) {
    state = state.copyWith(isDemoMode: isDemoMode);
  }

  void setForcedGrade(HumanGrade grade) {
    state = state.copyWith(forcedGrade: grade);
  }

  void setForcedOutcome(String outcome) {
    state = state.copyWith(forcedOutcome: outcome);
  }

  void setAiMode(String mode) {
    state = state.copyWith(aiMode: mode);
  }

  void updateUser(UserProfile user) {
    state = state.copyWith(user: user);
  }

  /// SR 기본 데모 시나리오
  void applySrScenario() {
    state = state.copyWith(
      isDemoMode: true,
      forcedGrade: HumanGrade.sr,
      forcedOutcome: 'success',
      aiMode: 'fallbackAllowed',
    );
  }

  /// SSR 임팩트 시나리오
  void applySsrScenario() {
    state = state.copyWith(
      isDemoMode: true,
      forcedGrade: HumanGrade.ssr,
      forcedOutcome: 'success',
      aiMode: 'fallbackAllowed',
    );
  }

  /// 실패 보상 시나리오
  void applyFailureScenario() {
    state = state.copyWith(
      isDemoMode: true,
      forcedGrade: HumanGrade.sr,
      forcedOutcome: 'failure',
      aiMode: 'fallbackAllowed',
    );
  }
}

/// 전역 Demo State Provider
final demoStateProvider = StateNotifierProvider<DemoStateNotifier, DemoConfig>((
  ref,
) {
  return DemoStateNotifier();
});
