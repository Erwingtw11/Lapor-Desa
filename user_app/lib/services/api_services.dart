class ApiServices {
  static const String baseUrl = "http://localhost:3000/api";

  Future<List<Map<String, dynamic>>> getReports() async {
    return [
      {
        "title": "Jalan Rusak",
        "desc": "Jalan berlubang di daerah Sukamaju",
        "status": "Diproses",
      },
      {
        "title": "Lampu Mati",
        "desc": "Lampu jalan tidak menyala",
        "status": "Selesai",
      },
    ];
  }

  Future<bool> createReport({
    required String title,
    required String desc,
  }) async {
    return true;
  }

  Future<bool> uploadReportImage() async {
    return true;
  }
}
