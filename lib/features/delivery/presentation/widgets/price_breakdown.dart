import 'package:flutter/material.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PriceBreakdown extends StatelessWidget {
  final double suggestedPrice;
  final double maxPrice;
  final double currentPrice;
  final ValueChanged<double> onPriceChanged;

  const PriceBreakdown({
    Key? key,
    required this.suggestedPrice,
    required this.maxPrice,
    required this.currentPrice,
    required this.onPriceChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Suggested Reward',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            '₹${currentPrice.toStringAsFixed(0)}',
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(
            'Based on distance, package type, and urgency',
            style: GoogleFonts.inter(
              fontSize: 11,
              color: AppColors.textTertiary,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.primaryLight,
            thumbColor: AppColors.primaryDark,
            overlayColor: AppColors.primary.withOpacity(0.2),
            valueIndicatorColor: AppColors.primary,
          ),
          child: Slider(
            value: currentPrice,
            min: (suggestedPrice * 0.8).floorToDouble(),
            max: maxPrice,
            divisions: ((maxPrice - (suggestedPrice * 0.8)) / 5).ceil(),
            label: '₹${currentPrice.toStringAsFixed(0)}',
            onChanged: onPriceChanged,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '₹${(suggestedPrice * 0.8).floor()}',
              style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
            ),
            Text(
              'Max: ₹${maxPrice.floor()}',
              style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
            ),
          ],
        )
      ],
    );
  }
}
