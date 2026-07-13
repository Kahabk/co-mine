import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/mock_memory_repository.dart';
import '../domain/repositories/memory_repository.dart';
import '../services/ai/ai_service.dart';
import '../services/ai/gemini_services.dart';
import '../services/ai/mock_ai_service.dart';

final memoryRepositoryProvider = Provider<MemoryRepository>(
  (_) => MockMemoryRepository(),
);
final aiServiceProvider = Provider<AIService>((_) {
  const key = String.fromEnvironment('GEMINI_API_KEY');
  const backend = String.fromEnvironment('GEMINI_BACKEND_URL');
  if (backend.isNotEmpty) return GeminiBackendAIService(Uri.parse(backend));
  if (key.isNotEmpty) return const GeminiDirectAIService(key);
  return const MockAIService();
});
