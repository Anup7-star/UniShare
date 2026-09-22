import 'package:flutter/material.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:unishare/core/theme/app_spacing.dart';
import 'package:unishare/shared/widgets/uni_card.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What would you like to do?',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _ActionCard(
                title: 'Request Delivery',
                subtitle: 'Get items to your door',
                icon: Icons.local_shipping_outlined,
                onTap: () {},
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _ActionCard(
                title: 'Carry a Delivery',
                subtitle: 'Earn while you walk',
                icon: Icons.directions_walk,
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _ActionCard(
                title: 'Find an Item',
                subtitle: 'Borrow from peers',
                icon: Icons.search,
                onTap: () {},
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _ActionCard(
                title: 'List an Item',
                subtitle: 'Rent out your stuff',
                icon: Icons.add_circle_outline,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: UniCard(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
