import 'package:flutter/material.dart';

import '../model/reportDetailsView_model.dart';
import '../repository/report_details_repository.dart';

class ReportDetailsViewModel extends ChangeNotifier {
  final _reportDetailsRepository = ReportDetailsRepository();
  ReportDetails? reportDetails;
  bool isLoading = false;
  String errorMessage = '';

  Future<void> fetchReportDetails(String reportId, String patientId) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      print("tring to make api call in repo");
      reportDetails = await _reportDetailsRepository.fetchReportDetails(reportId, patientId);
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
