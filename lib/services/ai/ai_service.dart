import 'ai_models.dart';

abstract interface class AIService {
  Future<AIChatResponse> generateResponse(AIChatRequest request);
  Future<MemoryAnalysis> analyzeMemory(MemoryAnalysisRequest request);
  Future<MindMapGenerationResult> generateMindMap(
    MindMapGenerationRequest request,
  );
  Future<List<SemanticSearchResult>> assistSearch(
    SemanticSearchRequest request,
  );
  Future<ConversationSummary> summarizeConversation(
    ConversationSummaryRequest request,
  );
  Future<List<MemoryConnection>> findMemoryConnections(
    MemoryConnectionRequest request,
  );
  Future<DigestResult> generateWeeklyDigest(DigestRequest request);
  Future<UsageEstimate> estimateCost(AIChatRequest request);
}
