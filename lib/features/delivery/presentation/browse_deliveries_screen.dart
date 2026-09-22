import 'package:flutter/material.dart';
import 'package:unishare/shared/models/models.dart';
import 'package:unishare/mock/mock_data.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unishare/features/delivery/presentation/widgets/delivery_card.dart';
import 'package:go_router/go_router.dart';
import 'package:unishare/shared/widgets/uni_empty_state.dart';

class BrowseDeliveriesScreen extends StatefulWidget {
  const BrowseDeliveriesScreen({Key? key}) : super(key: key);

  @override
  State<BrowseDeliveriesScreen> createState() => _BrowseDeliveriesScreenState();
}

class _BrowseDeliveriesScreenState extends State<BrowseDeliveriesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final MockDataService _mockDataService = MockDataService();
  
  List<DeliveryRequest> _openRequests = [];
  List<DeliveryRequest> _myDeliveries = [];
  Map<String, UniUser> _users = {};
  Map<String, CampusLocation> _locations = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    
    try {
      final deliveries = await _mockDataService.getDeliveryRequests();
      final users = await _mockDataService.getUsers();
      final locations = await _mockDataService.getLocations();
      final currentUser = await _mockDataService.getCurrentUser();
      
      final open = deliveries.where((d) => d.status == DeliveryStatus.open && d.requesterId != currentUser.id).toList();
      final mine = deliveries.where((d) => d.requesterId == currentUser.id || d.courierId == currentUser.id).toList();
      
      setState(() {
        _openRequests = open;
        _myDeliveries = mine;
        _users = {for (var u in users) u.id: u};
        _locations = {for (var l in locations) l.id: l};
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Deliveries',
          style: GoogleFonts.inter(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Open Requests'),
            Tab(text: 'My Deliveries'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList(_openRequests),
          _buildList(_myDeliveries),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/delivery/request'),
        icon: const Icon(Icons.add, color: AppColors.scaffold),
        label: Text(
          'Request Delivery',
          style: GoogleFonts.inter(color: AppColors.scaffold, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildList(List<DeliveryRequest> requests) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    }

    if (requests.isEmpty) {
      return UniEmptyState(
        icon: Icons.local_shipping_outlined,
        title: 'No Deliveries Found',
        subtitle: 'There are no delivery requests at the moment.',
        onAction: _loadData,
        actionLabel: 'Refresh',
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      color: AppColors.primary,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          return DeliveryCard(
            request: request,
            requester: _users[request.requesterId],
            pickup: _locations[request.pickupLocationId],
            destination: _locations[request.destinationId],
            onTap: () {
              context.push('/delivery/detail/${request.id}');
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

