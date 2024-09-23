import 'package:flutter/material.dart';
import '../model/reportDetails_model.dart';
import '../repository/report_details_repository.dart';
import '../utils/utils.dart';


class ReportDetailsViewModel extends ChangeNotifier {
  final _reportDetailsRepository = ReportDetailsRepository();
  ReportDetails? reportDetails;
  String errorMessage = '';

  Future<void> fetchReportDetails(BuildContext context, String reportId, String patientId) async {
    // Show custom loading dialog
    Utils.showLoading(context);

    errorMessage = '';
    notifyListeners();

    try {
      reportDetails = await _reportDetailsRepository.fetchReportDetails(reportId, patientId);
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      // Dismiss custom loading dialog
      Utils.cancelLoading(context);
      notifyListeners();
    }
  }
}
