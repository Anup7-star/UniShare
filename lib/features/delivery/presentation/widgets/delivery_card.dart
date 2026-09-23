import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unishare/shared/models/models.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:unishare/shared/widgets/uni_card.dart';
import 'package:unishare/shared/widgets/uni_chip.dart';
import 'package:intl/intl.dart';

class DeliveryCard extends StatelessWidget {
  final DeliveryRequest request;
  final VoidCallback onTap;
  final UniUser? requester;
  final CampusLocation? pickup;
  final CampusLocation? destination;

  const DeliveryCard({
    super.key,
    required this.request,
    required this.onTap,
    this.requester,
    this.pickup,
    this.destination,
  });

  Color _getUrgencyColor(UrgencyLevel level) {
    switch (level) {
      case UrgencyLevel.low:
        return const Color(0xFF8E8E93);
      case UrgencyLevel.medium:
        return const Color(0xFF007AFF);
      case UrgencyLevel.high:
        return const Color(0xFFFF9500);
      case UrgencyLevel.urgent:
        return const Color(0xFFFF3B30);
    }
  }

  @override
  Widget build(BuildContext context) {
    return UniCard(
      onTap: onTap,
      padding: 16,
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  pickup?.name ?? 'Unknown',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.arrow_forward_rounded, size: 16, color: AppColors.textTertiary),
              ),
              Expanded(
                child: Text(
                  destination?.name ?? 'Unknown',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              UniChip(
                label: request.packageType.name.toUpperCase(),
                isSelected: true,),
              const SizedBox(width: 8),
              UniChip(
                label: request.packageSize.name.toUpperCase(),
                isSelected: true,),
              const SizedBox(width: 8),
              UniChip(
                label: request.urgency.name.toUpperCase(),
                backgroundColor: _getUrgencyColor(request.urgency).withValues(alpha: 0.12),
                textColor: _getUrgencyColor(request.urgency),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${request.reward.toStringAsFixed(0)}',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 14, color: AppColors.textTertiary),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat.jm().format(request.preferredTime),
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  if (requester != null) ...[
                    const SizedBox(width: 12),
                    const Icon(Icons.star_rounded, size: 16, color: AppColors.warning),
                    const SizedBox(width: 4),
                    Text(
                      requester!.rating.toStringAsFixed(1),
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ]
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


