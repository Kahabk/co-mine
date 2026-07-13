enum MemoryType {
  idea,
  project,
  person,
  file,
  conversation,
  task,
  goal,
  place,
  topic,
  decision,
  question,
  digest,
}

enum SyncState {
  savedLocally,
  waiting,
  processing,
  synced,
  failed,
  needsAttention,
}

class Memory {
  const Memory({
    required this.id,
    required this.title,
    required this.body,
    required this.summary,
    required this.createdAt,
    this.tags = const [],
    this.type = MemoryType.idea,
    this.includeInAi = true,
    this.syncState = SyncState.savedLocally,
  });
  final String id, title, body, summary;
  final DateTime createdAt;
  final List<String> tags;
  final MemoryType type;
  final bool includeInAi;
  final SyncState syncState;
}

class DigestEntry {
  const DigestEntry({
    required this.id,
    required this.title,
    required this.summary,
    required this.createdAt,
    this.openTasks = 0,
  });
  final String id, title, summary;
  final DateTime createdAt;
  final int openTasks;
}

class Ritual {
  const Ritual({
    required this.id,
    required this.name,
    required this.description,
    this.enabled = true,
  });
  final String id, name, description;
  final bool enabled;
}

class UsageRecord {
  const UsageRecord({
    required this.id,
    required this.feature,
    required this.estimatedCost,
    required this.inputTokens,
    required this.outputTokens,
    required this.createdAt,
  });
  final String id, feature;
  final double estimatedCost;
  final int inputTokens, outputTokens;
  final DateTime createdAt;
}

class ConflictRecord {
  const ConflictRecord({
    required this.id,
    required this.memoryId,
    required this.localBody,
    required this.remoteBody,
    required this.createdAt,
    this.resolved = false,
  });
  final String id, memoryId, localBody, remoteBody;
  final DateTime createdAt;
  final bool resolved;
}

class Project {
  const Project(this.id, this.name);
  final String id, name;
}

class Person {
  const Person(this.id, this.name);
  final String id, name;
}

class Tag {
  const Tag(this.id, this.name);
  final String id, name;
}

class Chat {
  const Chat(this.id, this.title);
  final String id, title;
}

class Message {
  const Message(this.id, this.content, this.isUser);
  final String id, content;
  final bool isUser;
}

class MindNode {
  const MindNode(this.id, this.label, this.type);
  final String id, label;
  final MemoryType type;
}

class MindEdge {
  const MindEdge(this.id, this.sourceId, this.targetId);
  final String id, sourceId, targetId;
}

class DesktopDevice {
  const DesktopDevice(this.id, this.name, this.online);
  final String id, name;
  final bool online;
}

class Attachment {
  const Attachment(this.id, this.name, this.path);
  final String id, name, path;
}
