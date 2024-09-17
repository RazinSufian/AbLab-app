import 'package:flutter/material.dart';
import '../model/sales_report_summary.dart';
import '../repository/sales_repo.dart';

class SalesViewModel with ChangeNotifier {
  final ReportRepository _reportRepository = ReportRepository();
  ReportResponse? _reportResponse;
  bool _isLoading = false;
  String _errorMessage = '';

  ReportResponse? get reportResponse => _reportResponse;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchReport(String month) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _reportResponse = await _reportRepository.fetchReport(month);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
