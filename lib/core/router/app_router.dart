import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unishare/core/router/route_names.dart';
import 'package:unishare/features/shell/main_shell.dart';
import 'package:unishare/features/home/presentation/home_screen.dart';
import 'package:unishare/features/delivery/presentation/browse_deliveries_screen.dart';
import 'package:unishare/features/delivery/presentation/request_delivery_screen.dart';
import 'package:unishare/features/delivery/presentation/delivery_detail_screen.dart';
import 'package:unishare/features/delivery/presentation/partner_selection_screen.dart';
import 'package:unishare/features/delivery/presentation/pickup_screen.dart';
import 'package:unishare/features/delivery/presentation/in_transit_screen.dart';
import 'package:unishare/features/delivery/presentation/delivery_complete_screen.dart';
import 'package:unishare/features/rental/presentation/rental_home_screen.dart';
import 'package:unishare/features/rental/presentation/item_detail_screen.dart';
import 'package:unishare/features/rental/presentation/list_item_screen.dart';
import 'package:unishare/features/campus/presentation/campus_map_screen.dart';
import 'package:unishare/features/profile/presentation/profile_screen.dart';
import 'package:unishare/features/notifications/presentation/notifications_screen.dart';
import 'package:unishare/features/messaging/presentation/inbox_screen.dart';
import 'package:unishare/features/messaging/presentation/chat_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.home,
    routes: [
      GoRoute(
        path: '/',
        redirect: (_, _) => RouteNames.home,
      ),
      // Bottom navigation shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          // Home tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          // Deliveries tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.deliveries,
                builder: (context, state) => const BrowseDeliveriesScreen(),
              ),
            ],
          ),
          // Rentals tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.rentals,
                builder: (context, state) => const RentalHomeScreen(),
              ),
            ],
          ),
          // Campus tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.campus,
                builder: (context, state) => const CampusMapScreen(),
              ),
            ],
          ),
          // Profile tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
          // Messages tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.messages,
                builder: (context, state) => const InboxScreen(),
              ),
            ],
          ),
        ],
      ),

      // Full-screen routes (outside bottom nav)

      // Delivery sub-screens
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/delivery/request',
        builder: (context, state) => const RequestDeliveryScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/delivery/detail/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return DeliveryDetailScreen(deliveryId: id);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/delivery/partners/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return PartnerSelectionScreen(deliveryId: id);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/delivery/pickup/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return PickupScreen(deliveryId: id);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/delivery/transit/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return InTransitScreen(deliveryId: id);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/delivery/complete/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return DeliveryCompleteScreen(deliveryId: id);
        },
      ),

      // Rental sub-screens
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/rental/detail/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return ItemDetailScreen(itemId: id);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/rental/list',
        builder: (context, state) => const ListItemScreen(),
      ),

      // Notifications
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: RouteNames.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),

      // Chat (full-screen, outside bottom nav)
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/messages/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return ChatScreen(conversationId: id);
        },
      ),
    ],
  );
});
