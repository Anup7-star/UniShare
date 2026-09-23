import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unishare/core/router/route_names.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:unishare/core/theme/app_spacing.dart';
import 'package:unishare/mock/mock_data.dart';
import 'package:unishare/shared/models/models.dart';
import 'widgets/conversation_tile.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen>
    with SingleTickerProviderStateMixin {
  final MockDataService _mockService = MockDataService();
  List<Conversation> _conversations = [];
  Map<String, UniUser> _userCache = {};
  bool _isLoading = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final conversations = await _mockService.getConversations();
    final users = await _mockService.getUsers();
    if (mounted) {
      setState(() {
        _conversations = conversations;
        _userCache = {for (final u in users) u.id: u};
        _isLoading = false;
      });
    }
  }

  List<Conversation> get _deliveryConversations =>
      _conversations.where((c) => c.type == ConversationType.delivery).toList();

  List<Conversation> get _rentalConversations =>
      _conversations.where((c) => c.type == ConversationType.rental).toList();

  int get _totalUnread =>
      _conversations.fold(0, (sum, c) => sum + c.unreadCount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Messages'),
            if (_totalUnread > 0) ...[
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Text(
                  '$_totalUnread',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ]
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          indicatorWeight: 2.5,
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.local_shipping_outlined, size: 16),
                  const SizedBox(width: 6),
                  const Text('Deliveries'),
                  if (_deliveryConversations.any((c) => c.unreadCount > 0)) ...[
                    const SizedBox(width: 5),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ]
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.inventory_2_outlined, size: 16),
                  const SizedBox(width: 6),
                  const Text('Rentals'),
                  if (_rentalConversations.any((c) => c.unreadCount > 0)) ...[
                    const SizedBox(width: 5),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : TabBarView(
              controller: _tabController,
              children: [
                _buildConversationList(_deliveryConversations, 'deliveries'),
                _buildConversationList(_rentalConversations, 'rentals'),
              ],
            ),
    );
  }

  Widget _buildConversationList(
      List<Conversation> conversations, String type) {
    if (conversations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              type == 'deliveries'
                  ? Icons.local_shipping_outlined
                  : Icons.inventory_2_outlined,
              size: 56,
              color: AppColors.divider,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No conversations yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              type == 'deliveries'
                  ? 'Start or accept a delivery to chat'
                  : 'Rent or list an item to start chatting',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textTertiary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: conversations.length,
      separatorBuilder: (_, _) =>
          const Divider(height: 1, color: AppColors.divider),
      itemBuilder: (context, index) {
        final conv = conversations[index];
        final otherId = conv.otherParticipantId(mockCurrentUser.id);
        final otherUser = _userCache[otherId];
        if (otherUser == null) return const SizedBox.shrink();

        return ConversationTile(
          conversation: conv,
          otherUser: otherUser,
          onTap: () {
            context.push(
              RouteNames.chat.replaceFirst(':id', conv.id),
            );
          },
        );
      },
    );
  }
}
