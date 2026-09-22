import 'package:flutter/material.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:unishare/core/theme/app_spacing.dart';
import 'package:unishare/shared/widgets/uni_section_header.dart';
import 'package:unishare/mock/mock_data.dart';
import 'package:unishare/shared/models/models.dart';
import 'package:unishare/features/home/presentation/widgets/greeting_header.dart';
import 'package:unishare/features/home/presentation/widgets/quick_actions.dart';
import 'package:unishare/features/home/presentation/widgets/active_transaction_card.dart';
import 'package:unishare/features/home/presentation/widgets/nearby_deliveries.dart';
import 'package:unishare/features/home/presentation/widgets/popular_rentals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MockDataService _mockService = MockDataService();
  List<DeliveryRequest> _nearbyDeliveries = [];
  List<RentalListing> _popularRentals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final deliveries = await _mockService.getNearbyDeliveries();
    final rentals = await _mockService.getPopularRentals();
    if (mounted) {
      setState(() {
        _nearbyDeliveries = deliveries;
        _popularRentals = rentals;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GreetingHeader(
                userName: 'Aditya',
                userAvatar: 'https://i.pravatar.cc/150?u=aditya',
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildVerificationCard(context),
              const SizedBox(height: AppSpacing.xl),
              const QuickActions(),
              const SizedBox(height: AppSpacing.xl),
              UniSectionHeader(
                title: 'Active',
              ),
              const SizedBox(height: AppSpacing.sm),
              const ActiveTransactionCard(),
              const SizedBox(height: AppSpacing.xl),
              UniSectionHeader(
                title: 'Nearby Requests',
                actionLabel: 'See all',
                onActionTap: () {},
              ),
              const SizedBox(height: AppSpacing.sm),
              _isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                  : NearbyDeliveries(deliveries: _nearbyDeliveries),
              const SizedBox(height: AppSpacing.xl),
              UniSectionHeader(
                title: 'Popular Rentals',
                actionLabel: 'See all',
                onActionTap: () {},
              ),
              const SizedBox(height: AppSpacing.sm),
              _isLoading
                  ? const SizedBox()
                  : PopularRentals(items: _popularRentals),
              const SizedBox(height: AppSpacing.xl),
              _buildCampusActivity(context),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerificationCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
        border: const Border(left: BorderSide(color: AppColors.primary, width: 4)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: AppColors.surface, size: 14),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'College Verified',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'IIT Delhi • Computer Science',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampusActivity(BuildContext context) {
    return Center(
      child: Text(
        '23 deliveries today • 45 items listed • 150+ verified students',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.textTertiary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
