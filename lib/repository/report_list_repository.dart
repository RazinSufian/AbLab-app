// repository/report_repository.dart

import '../model/report_list_model.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_urls.dart';

class ReportRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<List<Report>> fetchReportList(String queryParams) async {
    try {
      print('queryParams: $queryParams');
      print("url:${AppUrl.reportListEndpoint}?$queryParams");
      String url = '${AppUrl.reportListEndpoint}?$queryParams'; // Assume you have this URL in app_urls.dart
      dynamic response = await _apiServices.getGetApiResponse(url);
      List<Report> reportList = [];
      print(response);
      if (response['reports'] != null) {
        response['reports'].forEach((v) {
          reportList.add(Report.fromJson(v));
        });
      }
      return reportList;
    } catch (e) {
      throw e;
    }
  }
}
