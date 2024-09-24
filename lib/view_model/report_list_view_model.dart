// view_model/report_view_model.dart

import 'package:flutter/material.dart';

import '../model/report_list_model.dart';
import '../repository/report_list_repository.dart';


class ReportListViewModel extends ChangeNotifier {
  final _reportRepository = ReportRepository();
  List<Report> reportList = [];
  bool isLoading = false;
  String errorMessage = '';

  // Fetch report list based on query parameters
  Future<void> fetchReport(String queryParams) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      reportList = await _reportRepository.fetchReportList(queryParams);
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Clear report list and reset error message
  void clearReportList() {
    reportList.clear();
    errorMessage = '';
    notifyListeners();
  }
}
