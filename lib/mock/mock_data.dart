import 'package:unishare/shared/models/models.dart';

import 'mock_users.dart';
import 'mock_campus.dart';
import 'mock_deliveries.dart';
import 'mock_rentals.dart';
import 'mock_notifications.dart';
import 'mock_messages.dart';

export 'mock_users.dart';
export 'mock_campus.dart';
export 'mock_deliveries.dart';
export 'mock_rentals.dart';
export 'mock_notifications.dart';
export 'mock_messages.dart';

class MockDataService {
  // Simulate network delay
  Future<void> _delay() async {
    await Future.delayed(const Duration(milliseconds: 400));
  }

  Future<UniUser> getCurrentUser() async {
    await _delay();
    return mockCurrentUser;
  }

  Future<List<UniUser>> getUsers() async {
    await _delay();
    return mockUsers;
  }

  Future<List<CampusLocation>> getLocations() async {
    await _delay();
    return mockLocations;
  }

  Future<List<CampusLocation>> getPickupLocations() async {
    await _delay();
    return pickupLocations;
  }

  Future<List<CampusLocation>> getDropLocations() async {
    await _delay();
    return dropLocations;
  }

  Future<List<CampusRoute>> getRoutes() async {
    await _delay();
    return mockRoutes;
  }

  Future<List<DeliveryRequest>> getDeliveryRequests() async {
    await _delay();
    return mockDeliveries;
  }

  Future<List<DeliveryRequest>> getNearbyDeliveries() async {
    await _delay();
    return mockDeliveries;
  }

  Future<List<RentalListing>> getRentalListings() async {
    await _delay();
    return mockRentals;
  }

  Future<List<RentalListing>> getPopularRentals() async {
    await _delay();
    return mockRentals;
  }

  Future<List<NotificationItem>> getNotifications() async {
    await _delay();
    return mockNotifications;
  }

  Future<List<Conversation>> getConversations() async {
    await _delay();
    return mockConversations;
  }

  Future<List<ChatMessage>> getMessages(String conversationId) async {
    await _delay();
    return List<ChatMessage>.from(
      mockMessagesByConversation[conversationId] ?? [],
    );
  }

  Future<void> sendMessage(String conversationId, ChatMessage message) async {
    await Future.delayed(const Duration(milliseconds: 100));
    mockMessagesByConversation.putIfAbsent(conversationId, () => []);
    mockMessagesByConversation[conversationId]!.add(message);
    // Update the last message in the conversation
    final idx = mockConversations.indexWhere((c) => c.id == conversationId);
    if (idx != -1) {
      mockConversations[idx] = mockConversations[idx].copyWith(
        lastMessage: message,
        lastUpdated: message.timestamp,
        unreadCount: 0,
      );
    }
  }

  Future<Conversation> getOrCreateConversation({
    required String otherUserId,
    required ConversationType type,
    String? contextId,
    String? contextTitle,
  }) async {
    // Look for existing conversation with this user and context
    for (final c in mockConversations) {
      if (c.participantIds.contains(otherUserId)) {
        if (contextId != null && c.contextId == contextId) {
          return c;
        }
      }
    }
    for (final c in mockConversations) {
      if (c.participantIds.contains(otherUserId) && c.type == type) {
        return c;
      }
    }

    final newId = 'conv_${DateTime.now().millisecondsSinceEpoch}';
    final otherUser = await getUserById(otherUserId);
    final title = contextTitle ?? (otherUser?.name ?? 'Direct Chat');

    final newConv = Conversation(
      id: newId,
      type: type,
      contextId: contextId ?? '',
      contextTitle: title,
      participantIds: [mockCurrentUser.id, otherUserId],
      lastMessage: null,
      lastUpdated: DateTime.now(),
      unreadCount: 0,
    );

    mockConversations.insert(0, newConv);
    mockMessagesByConversation[newId] = [];
    return newConv;
  }

  Future<UniUser?> getUserById(String id) async {
    await _delay();
    try {
      return mockUsers.firstWhere((u) => u.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<CampusLocation?> getLocationById(String id) async {
    await _delay();
    try {
      return mockLocations.firstWhere((loc) => loc.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> addDeliveryRequest(DeliveryRequest request) async {
    await _delay();
    mockDeliveries.insert(0, request);
  }

  Future<void> acceptDeliveryRequest(String deliveryId, String courierId) async {
    await _delay();
    final index = mockDeliveries.indexWhere((d) => d.id == deliveryId);
    if (index != -1) {
      final old = mockDeliveries[index];
      mockDeliveries[index] = DeliveryRequest(
        id: old.id,
        requesterId: old.requesterId,
        courierId: courierId,
        pickupLocationId: old.pickupLocationId,
        destinationId: old.destinationId,
        packageType: old.packageType,
        packageSize: old.packageSize,
        note: old.note,
        reward: old.reward,
        priceCeiling: old.priceCeiling,
        preferredTime: old.preferredTime,
        urgency: old.urgency,
        status: DeliveryStatus.matched,
        createdAt: old.createdAt,
      );
    }
  }
}

