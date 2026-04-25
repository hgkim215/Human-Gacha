import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/models/draw_result.dart';
import '../../shared/models/room_post.dart';
import '../demo_mode/demo_state.dart';
import '../draw/draw_animation_screen.dart';
import 'dummy_feed_data.dart';
import 'friend_feed_tile.dart';
import 'whole_room_summary.dart';

class RoomScreen extends ConsumerStatefulWidget {
  const RoomScreen({super.key});

  @override
  ConsumerState<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends ConsumerState<RoomScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(drawResultProvider);
    final demo = ref.watch(demoStateProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D14),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          color: Colors.white,
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          '인간방',
          style: GoogleFonts.notoSansKr(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        bottom: TabBar(
          controller: _tab,
          tabs: const [
            Tab(text: '친구방'),
            Tab(text: '전체방'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [_buildFriendRoom(result, demo), const WholeRoomSummary()],
      ),
    );
  }

  Widget _buildFriendRoom(DrawResult? result, DemoConfig demo) {
    // 내 결과 포스트 생성
    final myPost = result != null
        ? RoomPost(
            id: 'my_post',
            nickname: demo.user.nickname,
            grade: result.grade,
            gradeTitle: result.card.gradeTitle,
            status: _statusString(result.status),
            badgeTitle: result.status == DrawStatus.success
                ? result.card.successBadge
                : null,
            failureTitle: result.status == DrawStatus.failure
                ? result.card.failureTitle
                : null,
            reactions: const {'인정': 0, '지켜본다': 0},
            isMe: true,
          )
        : null;

    final posts = myPost != null
        ? DummyFeedData.withMyPost(myPost)
        : DummyFeedData.friendPosts;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (myPost == null) ...[
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF3A3A5C)),
            ),
            child: Row(
              children: [
                const Text('🎲', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '오늘 아직 뽑지 않았어요. 뽑고 나면 내 결과가 여기에 표시됩니다.',
                    style: GoogleFonts.notoSansKr(
                      fontSize: 13,
                      color: const Color(0xFF8080A0),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => context.go('/home'),
                  child: Text(
                    '뽑기',
                    style: GoogleFonts.notoSansKr(
                      fontSize: 13,
                      color: const Color(0xFF9D8BFF),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        ...posts.map((post) => FriendFeedTile(post: post)),
      ],
    );
  }

  String _statusString(DrawStatus status) {
    switch (status) {
      case DrawStatus.success:
        return 'success';
      case DrawStatus.failure:
        return 'failure';
      case DrawStatus.inProgress:
        return 'candidate';
    }
  }
}
