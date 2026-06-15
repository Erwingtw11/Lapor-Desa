import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    late Color backgroundColor;
    late Color foregroundColor;
    late String label;

    switch (status) {
      case 'PENDING':
        backgroundColor = const Color(0xFFFFF1CC);
        foregroundColor = const Color(0xFF9B6A00);
        label = 'Pending';
        break;
      case 'PROCESS':
        backgroundColor = const Color(0xFFDDF0FF);
        foregroundColor = const Color(0xFF0C5A8F);
        label = 'Diproses';
        break;
      case 'DONE':
        backgroundColor = const Color(0xFFDFF5E8);
        foregroundColor = const Color(0xFF146B47);
        label = 'Selesai';
        break;
      default:
        backgroundColor = const Color(0xFFE9EEF5);
        foregroundColor = const Color(0xFF4B5D73);
        label = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: foregroundColor,
        ),
      ),
    );
  }
}

