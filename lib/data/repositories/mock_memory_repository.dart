import '../../domain/entities/models.dart';
import '../../domain/repositories/memory_repository.dart';

class MockMemoryRepository implements MemoryRepository {
  final List<Memory> _items = [
    Memory(
      id: '1',
      title: 'Private memory workspace',
      body: 'Build a calm private AI workspace.',
      summary: 'A local-first system for thoughts and decisions.',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      tags: const ['product', 'idea'],
    ),
    Memory(
      id: '2',
      title: 'Flutter architecture decision',
      body: 'Use Riverpod and GoRouter.',
      summary:
          'Keep UI, repositories, and AI services independently replaceable.',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      type: MemoryType.decision,
      tags: const ['flutter'],
    ),
  ];
  @override
  Future<List<Memory>> list() async => List.unmodifiable(_items);
  @override
  Future<Memory?> find(String id) async =>
      _items.where((e) => e.id == id).firstOrNull;
  @override
  Future<void> save(Memory memory) async => _items.insert(0, memory);
}
