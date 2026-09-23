import 'package:flutter/material.dart';

class UniCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final bool hasBorder;

  UniCard({
    super.key,
    required this.child,
    dynamic padding = 16.0,
    this.onTap,
    this.hasBorder = false,
  }) : padding = padding is EdgeInsetsGeometry
            ? padding
            : (padding is num
                ? EdgeInsets.all(padding.toDouble())
                : const EdgeInsets.all(16.0));

  @override
  Widget build(BuildContext context) {
    Widget cardContent = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: hasBorder ? Border.all(color: const Color(0xFFE5E5EA), width: 1) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: cardContent,
        ),
      );
    }

    return cardContent;
  }
}
