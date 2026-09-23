import 'package:flutter/material.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:unishare/core/theme/app_spacing.dart';
import 'package:unishare/shared/models/models.dart';
import 'package:unishare/shared/widgets/uni_avatar.dart';

class ConversationTile extends StatelessWidget {
  final Conversation conversation;
  final UniUser otherUser;
  final VoidCallback onTap;

  const ConversationTile({
    super.key,
    required this.conversation,
    required this.otherUser,
    required this.onTap,
  });

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    final hasUnread = conversation.unreadCount > 0;
    final lastMsg = conversation.lastMessage;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            // Avatar with type indicator
            Stack(
              clipBehavior: Clip.none,
              children: [
                UniAvatar(
                  imageUrl: otherUser.avatarUrl,
                  name: otherUser.name,
                  size: 52,
                  isVerified: otherUser.isVerified,
                ),
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: conversation.type == ConversationType.delivery
                          ? AppColors.info
                          : AppColors.warning,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Icon(
                      conversation.type == ConversationType.delivery
                          ? Icons.local_shipping
                          : Icons.inventory_2,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.md),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          otherUser.name,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontWeight: hasUnread
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (lastMsg != null)
                        Text(
                          _formatTime(lastMsg.timestamp),
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                fontSize: 11,
                                color: hasUnread
                                    ? AppColors.primary
                                    : AppColors.textTertiary,
                                fontWeight: hasUnread
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  // Context chip
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: conversation.type == ConversationType.delivery
                              ? AppColors.info.withValues(alpha: 0.12)
                              : AppColors.warning.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          conversation.contextTitle,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: conversation.type == ConversationType.delivery
                                ? AppColors.info
                                : AppColors.warning,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Last message
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          lastMsg?.text ?? 'No messages yet',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: hasUnread
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                                fontWeight: hasUnread
                                    ? FontWeight.w500
                                    : FontWeight.w400,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasUnread)
                        Container(
                          margin: const EdgeInsets.only(left: AppSpacing.sm),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${conversation.unreadCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
