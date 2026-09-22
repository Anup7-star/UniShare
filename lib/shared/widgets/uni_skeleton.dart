import 'package:flutter/material.dart';
import 'package:unishare/core/theme/app_colors.dart';
import 'package:unishare/core/theme/app_spacing.dart';

class UniSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final double borderRadius;

  const UniSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8.0,
  });

  @override
  State<UniSkeleton> createState() => _UniSkeletonState();
}

class _UniSkeletonState extends State<UniSkeleton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.5, 1.0],
              colors: const [
                Color(0xFFE5E5EA),
                Color(0xFFF5F5F5),
                Color(0xFFE5E5EA),
              ],
              transform: GradientRotation(_animation.value),
            ),
          ),
        );
      },
    );
  }
}

class UniSkeletonCard extends StatelessWidget {
  const UniSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E5EA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UniSkeleton(height: 120, width: double.infinity, borderRadius: 8),
          const SizedBox(height: 12),
          const UniSkeleton(height: 16, width: 150),
          const SizedBox(height: 8),
          const UniSkeleton(height: 14, width: double.infinity),
          const SizedBox(height: 4),
          const UniSkeleton(height: 14, width: 200),
        ],
      ),
    );
  }
}

class UniSkeletonList extends StatelessWidget {
  final int count;

  const UniSkeletonList({super.key, this.count = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) => const UniSkeletonCard(),
    );
  }
}
