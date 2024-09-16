import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';

import '../model/sales_report_summary.dart';
import '../res/app_urls.dart';

class ReportRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<ReportResponse> fetchReport(String month) async {
    try {
      // Define the URL with the month parameter
      String url = '${AppUrl.reportMonthlySummary}?month=$month';
      // Make the GET request
      final response = await _apiServices.getGetApiResponse(url);
      // Parse the response into a ReportResponse object
      return ReportResponse.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
