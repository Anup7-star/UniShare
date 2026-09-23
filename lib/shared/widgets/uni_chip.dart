import 'package:flutter/material.dart';

class UniChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final IconData? icon;

  final Color? backgroundColor;
  final Color? textColor;

  const UniChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.icon,
    Color? backgroundColor,
    Color? color,
    this.textColor,
    bool isSmall = false,
  }) : backgroundColor = backgroundColor ?? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: backgroundColor ?? (isSelected ? const Color(0xFF00BF6D) : const Color(0xFFF5F5F5)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: textColor ?? (isSelected ? Colors.white : const Color(0xFF6B6B6B)),
                ),
                const SizedBox(width: 4),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: textColor ?? (isSelected ? Colors.white : const Color(0xFF1A1A1A)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
