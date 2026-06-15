import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../models/report_model.dart';
import 'api_service.dart';

class ReportService {
  final ApiService _apiService = ApiService();

  Future<List<ReportModel>> getReports(String token) async {
    _apiService.setAuthToken(token);

    try {
      final response = await _apiService.dio.get('/reports');
      final data = response.data as List<dynamic>;

      return data
          .map((item) => ReportModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (error) {
      throw Exception(_extractMessage(error, fallback: 'Gagal memuat laporan.'));
    }
  }

  Future<ReportModel> createReport({
    required String token,
    required String title,
    required String description,
    required String location,
    required File imageFile,
  }) async {
    _apiService.setAuthToken(token);

    final extension = imageFile.path.split('.').last.toLowerCase();
    final mediaType = extension == 'png'
        ? MediaType('image', 'png')
        : MediaType('image', 'jpeg');

    final formData = FormData.fromMap({
      'title': title,
      'description': description,
      'location': location,
      'image': await MultipartFile.fromFile(
        imageFile.path,
        contentType: mediaType,
        filename: imageFile.path.split(Platform.pathSeparator).last,
      ),
    });

    try {
      final response = await _apiService.dio.post(
        '/reports',
        data: formData,
      );

      return ReportModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (error) {
      throw Exception(_extractMessage(error, fallback: 'Gagal mengirim laporan.'));
    }
  }

  Future<ReportModel> getReportDetail({
    required String token,
    required int reportId,
  }) async {
    _apiService.setAuthToken(token);

    try {
      final response = await _apiService.dio.get('/reports/$reportId');
      return ReportModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (error) {
      throw Exception(_extractMessage(error, fallback: 'Gagal memuat detail laporan.'));
    }
  }

  String _extractMessage(DioException error, {required String fallback}) {
    final data = error.response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message'];
      if (message is List) {
        return message.join(', ');
      }
      if (message is String) {
        return message;
      }
    }

    return fallback;
  }
}

