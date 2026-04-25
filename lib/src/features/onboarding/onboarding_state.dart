import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/models/user_profile.dart';

class OnboardingAnswers {
  const OnboardingAnswers({
    this.persona = '',
    this.mainStruggles = const [],
    this.difficulty = '',
    this.tone = '',
    this.nickname = '',
  });

  final String persona;
  final List<String> mainStruggles;
  final String difficulty;
  final String tone;
  final String nickname;

  OnboardingAnswers copyWith({
    String? persona,
    List<String>? mainStruggles,
    String? difficulty,
    String? tone,
    String? nickname,
  }) {
    return OnboardingAnswers(
      persona: persona ?? this.persona,
      mainStruggles: mainStruggles ?? this.mainStruggles,
      difficulty: difficulty ?? this.difficulty,
      tone: tone ?? this.tone,
      nickname: nickname ?? this.nickname,
    );
  }

  UserProfile toUserProfile() {
    return UserProfile(
      nickname: nickname.isEmpty ? '나' : nickname,
      persona: persona.isEmpty ? '그냥 생존 인간' : persona,
      mainStruggles: mainStruggles,
      difficulty: _mapDifficulty(difficulty),
      tone: _mapTone(tone),
      onboardingCompleted: true,
    );
  }

  static String _mapDifficulty(String d) {
    switch (d) {
      case '숨 쉬듯 가볍게':
        return 'easy';
      case '오늘은 갓생 맛보기':
        return 'hard';
      default:
        return 'normal';
    }
  }

  static String _mapTone(String t) {
    switch (t) {
      case '적당히 킹받게':
        return 'roast';
      case '친구방 공개 처형맛':
        return 'public';
      default:
        return 'gentle';
    }
  }
}

class OnboardingNotifier extends StateNotifier<OnboardingAnswers> {
  OnboardingNotifier() : super(const OnboardingAnswers());

  void setPersona(String v) => state = state.copyWith(persona: v);
  void setNickname(String v) => state = state.copyWith(nickname: v);
  void setDifficulty(String v) => state = state.copyWith(difficulty: v);
  void setTone(String v) => state = state.copyWith(tone: v);

  void toggleStruggle(String item) {
    final current = List<String>.from(state.mainStruggles);
    if (current.contains(item)) {
      current.remove(item);
    } else if (current.length < 3) {
      current.add(item);
    }
    state = state.copyWith(mainStruggles: current);
  }
}

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingAnswers>((ref) {
      return OnboardingNotifier();
    });
