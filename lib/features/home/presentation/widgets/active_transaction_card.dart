import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:unishare/core/theme/app_spacing.dart';
import 'package:unishare/core/utils/communication_helper.dart';
import 'package:unishare/shared/models/models.dart';
import 'package:unishare/shared/widgets/uni_card.dart';

class ActiveTransactionCard extends StatelessWidget {
  const ActiveTransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return GestureDetector(
      onTap: () => context.push('/delivery/transit/del_001'),
      child: UniCard(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
=======
    return UniCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
>>>>>>> 8e4b66c9723828a8c36c4fe511aa1dc54a1f1beb
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Delivery in Progress',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '15m remaining',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                const Icon(Icons.location_on, color: AppColors.textTertiary, size: 18),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'Library',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Icon(Icons.arrow_forward, color: AppColors.textTertiary, size: 18),
                const SizedBox(width: AppSpacing.sm),
                const Icon(Icons.home, color: AppColors.textTertiary, size: 18),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'Hostel B',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Divider(color: AppColors.divider),
            const SizedBox(height: AppSpacing.sm),
            Center(
              child: Text(
                'View Details',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.primary,
                ),
          const SizedBox(height: AppSpacing.sm),
          const Divider(color: AppColors.divider),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () => context.push('/delivery/transit/d1'),
                icon: const Icon(Icons.navigation_outlined, size: 16, color: AppColors.primary),
                label: Text(
                  'Track Delivery',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.phone_outlined, color: AppColors.primary, size: 20),
                    tooltip: 'Call Courier',
                    onPressed: () {
                      CommunicationHelper.showCallModal(
                        context,
                        userName: 'Priya Patel',
                        role: 'Courier (Library → Hostel B)',
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.chat_bubble_outline, color: AppColors.primary, size: 20),
                    tooltip: 'Chat with Courier',
                    onPressed: () {
                      CommunicationHelper.openChat(
                        context,
                        otherUserId: 'u2',
                        type: ConversationType.delivery,
                        contextId: 'd1',
                        contextTitle: 'Library → Hostel B',
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
