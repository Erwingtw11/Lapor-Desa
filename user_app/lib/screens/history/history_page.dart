import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text("Lampu Jalan"),
              subtitle: Text("Laporan selesai ditangani"),
            ),
          ),

          SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: Icon(Icons.access_time, color: Colors.orange),
              title: Text("Jalan Rusak"),
              subtitle: Text("Masih dalam proses"),
            ),
          ),
        ],
      ),
    );
  }
}
