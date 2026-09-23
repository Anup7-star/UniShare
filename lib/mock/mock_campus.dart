import 'package:unishare/shared/models/models.dart';

/// Pickup locations — only Main Gate is a valid pickup point.
final List<CampusLocation> pickupLocations = [
  CampusLocation(id: 'loc_gate', name: 'Main Gate', type: 'gate', x: 200.0, y: 380.0, description: 'Campus Main Entrance'),
];

/// Drop-off destinations available for delivery.
final List<CampusLocation> dropLocations = [
  CampusLocation(id: 'loc_a_block', name: 'A Block', type: 'block', x: 100.0, y: 200.0, description: 'A Block'),
  CampusLocation(id: 'loc_b_block', name: 'B Block', type: 'block', x: 130.0, y: 200.0, description: 'B Block'),
  CampusLocation(id: 'loc_c_block', name: 'C Block', type: 'block', x: 160.0, y: 200.0, description: 'C Block'),
  CampusLocation(id: 'loc_d_block', name: 'D Block', type: 'block', x: 190.0, y: 200.0, description: 'D Block'),
  CampusLocation(id: 'loc_e_block', name: 'E Block', type: 'block', x: 220.0, y: 200.0, description: 'E Block'),
  CampusLocation(id: 'loc_f_block', name: 'F Block', type: 'block', x: 250.0, y: 200.0, description: 'F Block'),
  CampusLocation(id: 'loc_ab1', name: 'AB1', type: 'block', x: 100.0, y: 250.0, description: 'Academic Block 1'),
  CampusLocation(id: 'loc_ab2', name: 'AB2', type: 'block', x: 130.0, y: 250.0, description: 'Academic Block 2'),
  CampusLocation(id: 'loc_ab3', name: 'AB3', type: 'block', x: 160.0, y: 250.0, description: 'Academic Block 3'),
  CampusLocation(id: 'loc_ab4', name: 'AB4', type: 'block', x: 190.0, y: 250.0, description: 'Academic Block 4'),
  CampusLocation(id: 'loc_ab5', name: 'AB5', type: 'block', x: 220.0, y: 250.0, description: 'Academic Block 5'),
  CampusLocation(id: 'loc_north_square', name: 'North Square', type: 'area', x: 150.0, y: 100.0, description: 'North Square'),
  CampusLocation(id: 'loc_gazebo', name: 'Gazebo', type: 'area', x: 200.0, y: 150.0, description: 'Gazebo'),
];

/// Combined list used for backward-compatible lookups.
final List<CampusLocation> mockLocations = [...pickupLocations, ...dropLocations];

final List<CampusRoute> mockRoutes = [
  CampusRoute(id: 'r1', sourceId: 'loc_gate', targetId: 'loc_atm', distance: 150.0, durationMinutes: 2),
  CampusRoute(id: 'r2', sourceId: 'loc_gate', targetId: 'loc_shopping', distance: 300.0, durationMinutes: 4),
  CampusRoute(id: 'r3', sourceId: 'loc_atm', targetId: 'loc_lhc', distance: 400.0, durationMinutes: 5),
  CampusRoute(id: 'r4', sourceId: 'loc_shopping', targetId: 'loc_library', distance: 350.0, durationMinutes: 4),
  CampusRoute(id: 'r5', sourceId: 'loc_lhc', targetId: 'loc_library', distance: 200.0, durationMinutes: 3),
  CampusRoute(id: 'r6', sourceId: 'loc_lhc', targetId: 'loc_blk_vi', distance: 150.0, durationMinutes: 2),
  CampusRoute(id: 'r7', sourceId: 'loc_lhc', targetId: 'loc_blk_v', distance: 150.0, durationMinutes: 2),
  CampusRoute(id: 'r8', sourceId: 'loc_blk_vi', targetId: 'loc_blk_v', distance: 100.0, durationMinutes: 1),
  CampusRoute(id: 'r9', sourceId: 'loc_blk_vi', targetId: 'loc_cs_dept', distance: 120.0, durationMinutes: 2),
  CampusRoute(id: 'r10', sourceId: 'loc_blk_v', targetId: 'loc_bharti', distance: 250.0, durationMinutes: 3),
  CampusRoute(id: 'r11', sourceId: 'loc_cs_dept', targetId: 'loc_bharti', distance: 150.0, durationMinutes: 2),
  CampusRoute(id: 'r12', sourceId: 'loc_lhc', targetId: 'loc_masala', distance: 100.0, durationMinutes: 1),
  CampusRoute(id: 'r13', sourceId: 'loc_lhc', targetId: 'loc_amul', distance: 100.0, durationMinutes: 1),
  CampusRoute(id: 'r14', sourceId: 'loc_masala', targetId: 'loc_amul', distance: 50.0, durationMinutes: 1),
  CampusRoute(id: 'r15', sourceId: 'loc_library', targetId: 'loc_sac', distance: 300.0, durationMinutes: 4),
  CampusRoute(id: 'r16', sourceId: 'loc_sac', targetId: 'loc_jwalamukhi', distance: 400.0, durationMinutes: 5),
  CampusRoute(id: 'r17', sourceId: 'loc_jwalamukhi', targetId: 'loc_kumaon', distance: 300.0, durationMinutes: 4),
  CampusRoute(id: 'r18', sourceId: 'loc_kumaon', targetId: 'loc_nilgiri', distance: 150.0, durationMinutes: 2),
  CampusRoute(id: 'r19', sourceId: 'loc_nilgiri', targetId: 'loc_aravali', distance: 200.0, durationMinutes: 3),
  CampusRoute(id: 'r20', sourceId: 'loc_bharti', targetId: 'loc_nilgiri', distance: 350.0, durationMinutes: 4),
  CampusRoute(id: 'r21', sourceId: 'loc_cs_dept', targetId: 'loc_aravali', distance: 400.0, durationMinutes: 5),
  CampusRoute(id: 'r22', sourceId: 'loc_blk_vi', targetId: 'loc_kumaon', distance: 500.0, durationMinutes: 6),
  CampusRoute(id: 'r23', sourceId: 'loc_blk_v', targetId: 'loc_jwalamukhi', distance: 450.0, durationMinutes: 6),
  CampusRoute(id: 'r24', sourceId: 'loc_sac', targetId: 'loc_blk_v', distance: 350.0, durationMinutes: 4),
  CampusRoute(id: 'r25', sourceId: 'loc_masala', targetId: 'loc_atm', distance: 250.0, durationMinutes: 3),
  CampusRoute(id: 'r26', sourceId: 'loc_amul', targetId: 'loc_shopping', distance: 300.0, durationMinutes: 4),
  CampusRoute(id: 'r27', sourceId: 'loc_gate', targetId: 'loc_sac', distance: 800.0, durationMinutes: 10),
];
