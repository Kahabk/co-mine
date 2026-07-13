import 'ai_models.dart';
import 'ai_service.dart';

class MockAIService implements AIService {
  const MockAIService();
  @override
  Future<MemoryAnalysis> analyzeMemory(MemoryAnalysisRequest r) async =>
      MemoryAnalysis(
        title: r.content.split(RegExp(r'\s+')).take(6).join(' '),
        summary: 'Saved locally and ready for review.',
        topics: const ['brain dump'],
      );
  @override
  Future<UsageEstimate> estimateCost(AIChatRequest r) async => UsageEstimate(
    inputTokens: (r.message.length / 4).ceil(),
    outputTokens: 300,
    estimatedCost: .001,
  );
  @override
  Future<List<SemanticSearchResult>> assistSearch(
    SemanticSearchRequest r,
  ) async => const [];
  @override
  Future<List<MemoryConnection>> findMemoryConnections(
    MemoryConnectionRequest r,
  ) async => const [];
  @override
  Future<AIChatResponse> generateResponse(AIChatRequest request) async =>
      const AIChatResponse(
        text: 'Mock mode is active. Your request stays on this device.',
      );
  @override
  Future<MindMapGenerationResult> generateMindMap(
    MindMapGenerationRequest r,
  ) async => const MindMapGenerationResult(['Ideas', 'Decisions', 'Projects']);
  @override
  Future<DigestResult> generateWeeklyDigest(DigestRequest r) async =>
      const DigestResult(
        'You captured several connected product decisions this week.',
        ['Review architecture'],
      );
  @override
  Future<ConversationSummary> summarizeConversation(
    ConversationSummaryRequest r,
  ) async => const ConversationSummary('Conversation summary');
}
