import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/human_card.dart';
import '../models/human_grade.dart';
import '../models/user_profile.dart';
import 'fallback_card_service.dart';

/// AI 카드 생성 서비스
/// - 5초 타임아웃 초과 또는 파싱 실패 시 즉시 fallback 반환
/// - aiMode가 'fallbackOnly'이면 API 호출 없이 fallback 반환
class AiCardService {
  AiCardService({this.apiKey = '', this.aiMode = 'fallbackAllowed'});

  final String apiKey;
  final String aiMode; // 'aiFirst' | 'fallbackAllowed' | 'fallbackOnly'

  static const _timeout = Duration(seconds: 5);

  Future<HumanCard> generateCard({
    required UserProfile profile,
    required List<String> todayMood,
    required HumanGrade grade,
  }) async {
    if (aiMode == 'fallbackOnly' || apiKey.isEmpty) {
      return FallbackCardService.getCard(grade);
    }

    try {
      final card = await _callGemini(
        profile: profile,
        todayMood: todayMood,
        grade: grade,
      ).timeout(_timeout);

      if (card != null && card.isValid) {
        return card;
      }
      return FallbackCardService.getCard(grade);
    } on TimeoutException {
      return FallbackCardService.getCard(grade);
    } catch (_) {
      return FallbackCardService.getCard(grade);
    }
  }

  Future<HumanCard?> _callGemini({
    required UserProfile profile,
    required List<String> todayMood,
    required HumanGrade grade,
  }) async {
    final prompt = _buildPrompt(profile, todayMood, grade);

    final uri = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey',
    );

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': prompt},
            ],
          },
        ],
        'generationConfig': {
          'temperature': 0.9,
          'maxOutputTokens': 512,
          'responseMimeType': 'application/json',
        },
      }),
    );

    if (response.statusCode != 200) return null;

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final text =
        body['candidates']?[0]?['content']?['parts']?[0]?['text'] as String?;
    if (text == null || text.isEmpty) return null;

    final jsonMap = jsonDecode(text) as Map<String, dynamic>;
    final card = HumanCard.fromJson(jsonMap, grade);
    return card.isValid ? card : null;
  }

  String _buildPrompt(
    UserProfile profile,
    List<String> todayMood,
    HumanGrade grade,
  ) {
    return '''
너는 B급 자기관리 가챠 앱 '인간 가챠'의 카드 생성기다.

사용자 정보:
- 닉네임: ${profile.nickname}
- 사용자 유형: ${profile.persona}
- 자주 실패하는 것: ${profile.mainStruggles.join(', ')}
- 미션 난이도: ${profile.difficulty}
- 말투 강도: ${profile.tone}
- 오늘 상태: ${todayMood.join(', ')}
- 뽑힌 등급: ${grade.label}

조건:
- 사용자가 오늘 안에 실제로 할 수 있는 짧은 미션을 만든다.
- 목표를 직접 쓰지 않아도 되는 선택형 자기관리 경험에 맞춘다.
- B급이고 웃기되, 사용자를 혐오하거나 심하게 비하하지 않는다.
- 우울, 자해, 질병, 외모, 신체, 성별, 인종, 장애, 가족사를 놀리지 않는다.
- 실패 문구는 죄책감이 아니라 가벼운 농담이어야 한다.
- 결과는 JSON 형식으로만 응답한다.
- 각 필드는 60자 이내를 우선한다.

출력 형식(JSON만):
{
  "gradeTitle": "",
  "description": "",
  "mission": "",
  "successBadge": "",
  "failureTitle": "",
  "failureMessage": "",
  "shareText": ""
}
''';
  }
}
