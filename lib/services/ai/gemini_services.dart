import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ai_models.dart';
import 'mock_ai_service.dart';

class GeminiDirectAIService extends MockAIService {
  const GeminiDirectAIService(this.apiKey);
  final String apiKey;
  // Direct mode is development-only. Production builds should inject the backend implementation.
}

class GeminiBackendAIService extends MockAIService {
  GeminiBackendAIService(this.baseUri, {http.Client? client})
    : _client = client ?? http.Client();
  final Uri baseUri;
  final http.Client _client;
  @override
  Future<AIChatResponse> generateResponse(AIChatRequest request) async {
    final response = await _client
        .post(
          baseUri.resolve('/ai/chat'),
          headers: {'content-type': 'application/json'},
          body: jsonEncode({
            'message': request.message,
            'context': request.context,
          }),
        )
        .timeout(const Duration(seconds: 30));
    if (response.statusCode ~/ 100 != 2) {
      throw StateError('AI backend unavailable (${response.statusCode})');
    }
    final data = jsonDecode(response.body);
    if (data is! Map<String, dynamic> || data['text'] is! String) {
      throw const FormatException('Invalid AI response');
    }
    return AIChatResponse(
      text: data['text'] as String,
      sources: (data['sources'] as List? ?? const [])
          .whereType<String>()
          .toList(),
    );
  }
}
