class Laporan {
  final int id;
  final String judul;
  final String deskripsi;
  final String status;

  Laporan({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.status,
  });

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      id: json['id'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      status: json['status'],
    );
  }
}