import 'package:unishare/shared/models/models.dart';

// ---------------------------------------------------------------------------
// Messages per conversation
// ---------------------------------------------------------------------------

final Map<String, List<ChatMessage>> mockMessagesByConversation = {
  'conv_d1': [
    ChatMessage(
      id: 'msg_d1_1',
      senderId: 'u2',
      text: 'Hi! I need this delivery ASAP, can you help?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
      isRead: true,
    ),
    ChatMessage(
      id: 'msg_d1_2',
      senderId: 'u1',
      text: 'Sure, I am near Masala Mix right now. Should take ~10 mins.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 22)),
      isRead: true,
    ),
    ChatMessage(
      id: 'msg_d1_3',
      senderId: 'u2',
      text: 'Great! Please handle carefully, it is hot food.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
      isRead: true,
    ),
    ChatMessage(
      id: 'msg_d1_4',
      senderId: 'u1',
      text: 'Picked up! On my way to Kumaon now.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 12)),
      isRead: true,
    ),
    ChatMessage(
      id: 'msg_d1_5',
      senderId: 'u2',
      text: 'Thank you so much!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
      isRead: false,
    ),
  ],
  'conv_d3': [
    ChatMessage(
      id: 'msg_d3_1',
      senderId: 'u5',
      text: 'Hey, the parcel at the gate is an electronics charger. Please be careful.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 18)),
      isRead: true,
    ),
    ChatMessage(
      id: 'msg_d3_2',
      senderId: 'u1',
      text: 'No problem! I will handle it safely.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      isRead: false,
    ),
  ],
  'conv_r1': [
    ChatMessage(
      id: 'msg_r1_1',
      senderId: 'u3',
      text: 'Hi Aditya, is the scientific calculator still available?',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: true,
    ),
    ChatMessage(
      id: 'msg_r1_2',
      senderId: 'u1',
      text: 'Yes it is! When do you need it?',
      timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 50)),
      isRead: true,
    ),
    ChatMessage(
      id: 'msg_r1_3',
      senderId: 'u3',
      text: 'I have an exam tomorrow morning, can I pick it up this evening?',
      timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 30)),
      isRead: true,
    ),
    ChatMessage(
      id: 'msg_r1_4',
      senderId: 'u1',
      text: 'Sure, come to Hostel Block VI around 7 PM.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true,
    ),
    ChatMessage(
      id: 'msg_r1_5',
      senderId: 'u3',
      text: 'Perfect, see you then!',
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
      isRead: false,
    ),
  ],
};

// ---------------------------------------------------------------------------
// Conversations
// ---------------------------------------------------------------------------

final List<Conversation> mockConversations = [
  Conversation(
    id: 'conv_d1',
    type: ConversationType.delivery,
    contextId: 'd1',
    contextTitle: 'Masala Mix → Kumaon',
    participantIds: ['u1', 'u2'],
    lastMessage: mockMessagesByConversation['conv_d1']!.last,
    lastUpdated: mockMessagesByConversation['conv_d1']!.last.timestamp,
    unreadCount: 1,
  ),
  Conversation(
    id: 'conv_d3',
    type: ConversationType.delivery,
    contextId: 'd3',
    contextTitle: 'Main Gate → Nilgiri',
    participantIds: ['u1', 'u5'],
    lastMessage: mockMessagesByConversation['conv_d3']!.last,
    lastUpdated: mockMessagesByConversation['conv_d3']!.last.timestamp,
    unreadCount: 0,
  ),
  Conversation(
    id: 'conv_r1',
    type: ConversationType.rental,
    contextId: 'r1',
    contextTitle: 'Scientific Calculator',
    participantIds: ['u1', 'u3'],
    lastMessage: mockMessagesByConversation['conv_r1']!.last,
    lastUpdated: mockMessagesByConversation['conv_r1']!.last.timestamp,
    unreadCount: 1,
  ),
];
