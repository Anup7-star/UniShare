import 'package:flutter/material.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:unishare/core/theme/app_spacing.dart';
import 'package:unishare/shared/widgets/uni_avatar.dart';

class GreetingHeader extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const GreetingHeader({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good evening,',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              userName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none, color: AppColors.textPrimary),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.xs),
            UniAvatar(
              imageUrl: userAvatar,
              name: userName,
            ),
          ],
        )
      ],
    );
  }
}
