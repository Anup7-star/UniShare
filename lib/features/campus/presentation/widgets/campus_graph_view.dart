import 'package:flutter/material.dart';

class CampusGraphPainter extends CustomPainter {
  final List<Map<String, dynamic>> nodes;
  final List<Map<String, dynamic>> edges;

  CampusGraphPainter({required this.nodes, required this.edges});

  @override
  void paint(Canvas canvas, Size size) {
    final edgePaint = Paint()
      ..color = const Color(0xFFE5E5EA)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Draw edges
    for (var edge in edges) {
      final fromNode = nodes.firstWhere((n) => n['id'] == edge['from']);
      final toNode = nodes.firstWhere((n) => n['id'] == edge['to']);
      
      final p1 = Offset(fromNode['x'] as double, fromNode['y'] as double);
      final p2 = Offset(toNode['x'] as double, toNode['y'] as double);
      
      canvas.drawLine(p1, p2, edgePaint);

      // Draw distance label
      final center = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);
      textPainter.text = TextSpan(
        text: '${edge['distance']}m',
        style: const TextStyle(
          color: Color(0xFF8E8E93),
          fontSize: 10,
          ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
