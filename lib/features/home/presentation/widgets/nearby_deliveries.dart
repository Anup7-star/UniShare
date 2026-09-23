import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:unishare/core/theme/app_spacing.dart';
import 'package:unishare/shared/widgets/uni_card.dart';
import 'package:unishare/shared/widgets/uni_chip.dart';
import 'package:unishare/shared/models/models.dart';

class NearbyDeliveries extends StatelessWidget {
  final List<DeliveryRequest> deliveries;

  const NearbyDeliveries({super.key, required this.deliveries});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: deliveries.length,
        separatorBuilder: (context, index) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) {
          final delivery = deliveries[index];
          final isUrgent = delivery.urgency == UrgencyLevel.urgent || delivery.urgency == UrgencyLevel.high;

          return SizedBox(
            width: 220,
            child: GestureDetector(
              onTap: () => context.push('/delivery/detail/${delivery.id}'),
              child: UniCard(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${delivery.reward.toInt()}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isUrgent)
                        const UniChip(
                          label: 'Urgent',
                          backgroundColor: AppColors.error,
                          textColor: Colors.white,
                        ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: AppColors.textTertiary, size: 16),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          delivery.pickupLocationId,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward, color: AppColors.textTertiary, size: 16),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          delivery.destinationId,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Posted recently',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      ),
    );
  }
}
