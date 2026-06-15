import 'package:flutter/material.dart';

class ReportFormPage extends StatelessWidget {
  const ReportFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Laporan"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Judul Laporan",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: descController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Deskripsi Laporan",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Fitur pilih foto akan segera tersedia"),
                    ),
                  );
                },
                icon: const Icon(Icons.image),
                label: const Text("Pilih Foto"),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Laporan berhasil dibuat")),
                  );
                  Navigator.pop(context);
                },
                child: const Text("Kirim Laporan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
