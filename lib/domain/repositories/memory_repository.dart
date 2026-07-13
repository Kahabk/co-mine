import '../entities/models.dart';

abstract interface class MemoryRepository {
  Future<List<Memory>> list();
  Future<Memory?> find(String id);
  Future<void> save(Memory memory);
}
