import 'package:flutter/material.dart';
import '../../services/api_services.dart';
import '../../models/laporan_model.dart';
import '../../widgets/status_badge.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Laporan>> futureLaporan;

  @override
  void initState() {
    super.initState();
    futureLaporan = ApiService.getLaporan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Laporan Saya")),
      body: FutureBuilder<List<Laporan>>(
        future: futureLaporan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Terjadi error"));
          }

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final laporan = data[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(laporan.judul),
                  subtitle: Text(laporan.deskripsi),
                  trailing: StatusBadge(status: laporan.status),
                ),
              );
            },
          );
        },
      ),
    );
  }
}