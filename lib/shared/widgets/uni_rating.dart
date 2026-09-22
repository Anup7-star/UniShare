import 'package:flutter/material.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:unishare/core/theme/app_spacing.dart';

class UniRating extends StatelessWidget {
  final double rating;
  final int maxRating;
  final double size;
  final bool showValue;

  const UniRating({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 16.0,
    this.showValue = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(maxRating, (index) {
            return _buildStar(index);
          }),
        ),
        if (showValue) ...[
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: size * 0.85,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1A1A),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStar(int index) {
    IconData iconData;
    Color color = const Color(0xFFFFD700);

    if (index >= rating) {
      iconData = Icons.star;
      color = const Color(0xFFE5E5EA);
    } else if (index > rating - 1 && index < rating) {
      iconData = Icons.star_half;
    } else {
      iconData = Icons.star;
    }

    return Icon(
      iconData,
      size: size,
      color: color,
    );
  }
}
