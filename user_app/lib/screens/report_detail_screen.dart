import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/report_model.dart';
import '../widgets/status_chip.dart';

class ReportDetailScreen extends StatelessWidget {
  final ReportModel report;

  const ReportDetailScreen({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Laporan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Image.network(
              report.imageUrl,
              height: 240,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  height: 240,
                  color: const Color(0xFFEAF1F8),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.image_not_supported_rounded,
                    size: 52,
                    color: Color(0xFF7F90A7),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  report.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF10243E),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              StatusChip(status: report.status),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x12000000),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRow(
                  icon: Icons.place_outlined,
                  label: 'Lokasi',
                  value: report.location,
                ),
                const SizedBox(height: 14),
                _infoRow(
                  icon: Icons.schedule_rounded,
                  label: 'Dibuat pada',
                  value: DateFormat('dd MMMM yyyy, HH:mm', 'id_ID')
                      .format(report.createdAt),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Deskripsi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF10243E),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            report.description,
            style: const TextStyle(
              height: 1.7,
              color: Color(0xFF4F6177),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFF46E50)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7B8AA0),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF10243E),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

