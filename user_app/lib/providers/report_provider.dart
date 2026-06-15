import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/report_model.dart';
import '../services/report_service.dart';

class ReportProvider extends ChangeNotifier {
  final ReportService _reportService = ReportService();

  String? _token;
  bool _isLoading = false;
  String? _errorMessage;
  List<ReportModel> _reports = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<ReportModel> get reports => _reports;

  void setAuthToken(String? token) {
    if (_token == token) {
      return;
    }

    final hadSession = _token != null;
    _token = token;

    if (_token == null) {
      if (!hadSession && _reports.isEmpty && _errorMessage == null) {
        return;
      }

      _reports = [];
      _errorMessage = null;
      notifyListeners();
    }
  }

  Future<void> fetchReports() async {
    if (_token == null) {
      return;
    }

    _setLoading(true);
    _errorMessage = null;

    try {
      _reports = await _reportService.getReports(_token!);
    } catch (error) {
      _errorMessage = error.toString().replaceFirst('Exception: ', '');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> createReport({
    required String title,
    required String description,
    required String location,
    required File imageFile,
  }) async {
    if (_token == null) {
      _errorMessage = 'Silakan login kembali.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _errorMessage = null;

    try {
      final createdReport = await _reportService.createReport(
        token: _token!,
        title: title,
        description: description,
        location: location,
        imageFile: imageFile,
      );

      _reports = [createdReport, ..._reports];
      notifyListeners();
      return true;
    } catch (error) {
      _errorMessage = error.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
