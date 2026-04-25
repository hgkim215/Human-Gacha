import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/splash/splash_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/home/home_screen.dart';
import '../features/draw/mood_select_screen.dart';
import '../features/draw/draw_animation_screen.dart';
import '../features/result_card/draw_result_screen.dart';
import '../features/mission/mission_detail_screen.dart';
import '../features/mission/badge_reward_screen.dart';
import '../features/mission/failure_reward_screen.dart';
import '../features/social_feed/room_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => _fade(state, const SplashScreen()),
    ),
    GoRoute(
      path: '/onboarding',
      pageBuilder: (context, state) => _slide(state, const OnboardingScreen()),
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => _fade(state, const HomeScreen()),
    ),
    GoRoute(
      path: '/mood',
      pageBuilder: (context, state) => _slide(state, const MoodSelectScreen()),
    ),
    GoRoute(
      path: '/draw',
      pageBuilder: (context, state) =>
          _fade(state, const DrawAnimationScreen()),
    ),
    GoRoute(
      path: '/result',
      pageBuilder: (context, state) => _slide(state, const DrawResultScreen()),
    ),
    GoRoute(
      path: '/mission',
      pageBuilder: (context, state) =>
          _slide(state, const MissionDetailScreen()),
    ),
    GoRoute(
      path: '/reward/success',
      pageBuilder: (context, state) => _slide(state, const BadgeRewardScreen()),
    ),
    GoRoute(
      path: '/reward/failure',
      pageBuilder: (context, state) =>
          _slide(state, const FailureRewardScreen()),
    ),
    GoRoute(
      path: '/room',
      pageBuilder: (context, state) => _slide(state, const RoomScreen()),
    ),
  ],
);

CustomTransitionPage<void> _fade(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: (context, animation, secondaryAnimation, c) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
        child: c,
      );
    },
  );
}

CustomTransitionPage<void> _slide(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 280),
    transitionsBuilder: (context, animation, secondaryAnimation, c) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
        child: c,
      );
    },
  );
}
