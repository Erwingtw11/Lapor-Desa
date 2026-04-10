import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/laporan_model.dart';

class ApiService {
  static const baseUrl = "http://10.0.2.2:3000"; // NestJS kamu

  static Future<List<Laporan>> getLaporan() async {
    final response = await http.get(Uri.parse("$baseUrl/laporan"));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Laporan.fromJson(e)).toList();
    } else {
      throw Exception("Gagal ambil data");
    }
  }
}