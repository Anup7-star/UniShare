import 'chat_message.dart';

enum ConversationType { delivery, rental }

class Conversation {
  final String id;
  final ConversationType type;
  final String contextId;       // deliveryId or rentalListingId
  final String contextTitle;    // e.g. "Library → Hostel B" or "Scientific Calculator"
  final List<String> participantIds;
  final ChatMessage? lastMessage;
  final DateTime lastUpdated;
  final int unreadCount;

  const Conversation({
    required this.id,
    required this.type,
    required this.contextId,
    required this.contextTitle,
    required this.participantIds,
    this.lastMessage,
    required this.lastUpdated,
    this.unreadCount = 0,
  });

  Conversation copyWith({
    String? id,
    ConversationType? type,
    String? contextId,
    String? contextTitle,
    List<String>? participantIds,
    ChatMessage? lastMessage,
    DateTime? lastUpdated,
    int? unreadCount,
  }) {
    return Conversation(
      id: id ?? this.id,
      type: type ?? this.type,
      contextId: contextId ?? this.contextId,
      contextTitle: contextTitle ?? this.contextTitle,
      participantIds: participantIds ?? this.participantIds,
      lastMessage: lastMessage ?? this.lastMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  /// Returns the ID of the other participant given the current user's ID
  String otherParticipantId(String currentUserId) {
    return participantIds.firstWhere(
      (id) => id != currentUserId,
      orElse: () => participantIds.first,
    );
  }
}
