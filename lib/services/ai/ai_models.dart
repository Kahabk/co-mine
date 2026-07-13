class AIChatRequest {
  const AIChatRequest({required this.message, this.context = const []});
  final String message;
  final List<String> context;
}

class AIChatResponse {
  const AIChatResponse({required this.text, this.sources = const []});
  final String text;
  final List<String> sources;
}

class MemoryAnalysisRequest {
  const MemoryAnalysisRequest(this.content);
  final String content;
}

class MemoryAnalysis {
  const MemoryAnalysis({
    required this.title,
    required this.summary,
    this.topics = const [],
    this.tasks = const [],
  });
  final String title, summary;
  final List<String> topics, tasks;
}

class MindMapGenerationRequest {
  const MindMapGenerationRequest(this.memoryIds);
  final List<String> memoryIds;
}

class MindMapGenerationResult {
  const MindMapGenerationResult(this.labels);
  final List<String> labels;
}

class SemanticSearchRequest {
  const SemanticSearchRequest(this.query);
  final String query;
}

class SemanticSearchResult {
  const SemanticSearchResult(this.id, this.reason, this.score);
  final String id, reason;
  final double score;
}

class ConversationSummaryRequest {
  const ConversationSummaryRequest(this.messages);
  final List<String> messages;
}

class ConversationSummary {
  const ConversationSummary(this.text);
  final String text;
}

class MemoryConnectionRequest {
  const MemoryConnectionRequest(this.memoryId);
  final String memoryId;
}

class MemoryConnection {
  const MemoryConnection(this.targetId, this.reason, this.strength);
  final String targetId, reason;
  final double strength;
}

class DigestRequest {
  const DigestRequest(this.memoryIds);
  final List<String> memoryIds;
}

class DigestResult {
  const DigestResult(this.summary, this.openTasks);
  final String summary;
  final List<String> openTasks;
}

class UsageEstimate {
  const UsageEstimate({
    required this.inputTokens,
    required this.outputTokens,
    required this.estimatedCost,
  });
  final int inputTokens, outputTokens;
  final double estimatedCost;
}
