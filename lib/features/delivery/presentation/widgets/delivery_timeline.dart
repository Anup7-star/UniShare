import 'package:flutter/material.dart';
import 'package:unishare/shared/models/models.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DeliveryTimeline extends StatelessWidget {
  final DeliveryStatus currentStatus;
  final DateTime createdAt;

  const DeliveryTimeline({
    Key? key,
    required this.currentStatus,
    required this.createdAt,
  }) : super(key: key);

  List<DeliveryStatus> get _timelineSteps => [
    DeliveryStatus.open,
    DeliveryStatus.matched,
    DeliveryStatus.pickup,
    DeliveryStatus.inTransit,
    DeliveryStatus.delivered,
  ];

  String _getStatusName(DeliveryStatus status) {
    switch (status) {
      case DeliveryStatus.open: return 'Posted';
      case DeliveryStatus.matched: return 'Matched';
      case DeliveryStatus.pickup: return 'Pickup';
      case DeliveryStatus.inTransit: return 'In Transit';
      case DeliveryStatus.delivered: return 'Delivered';
      case DeliveryStatus.cancelled: return 'Cancelled';
      case DeliveryStatus.expired: return 'Expired';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _timelineSteps.indexOf(currentStatus);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(_timelineSteps.length, (index) {
        final step = _timelineSteps[index];
        final isCompleted = index <= currentIndex;
        final isCurrent = index == currentIndex;
        final isLast = index == _timelineSteps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? AppColors.primary : AppColors.surface,
                    border: Border.all(
                      color: isCompleted ? AppColors.primary : AppColors.divider,
                      width: 2,
                    ),
                  ),
                  child: isCompleted 
                    ? const Icon(Icons.check, size: 10, color: AppColors.scaffold)
                    : null,
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 30,
                    color: isCompleted ? AppColors.primary : AppColors.divider,
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getStatusName(step),
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                        color: isCompleted ? AppColors.textPrimary : AppColors.textTertiary,
                      ),
                    ),
                    if (index == 0)
                      Text(
                        DateFormat('MMM d, h:mm a').format(createdAt),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    if (!isLast) const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
