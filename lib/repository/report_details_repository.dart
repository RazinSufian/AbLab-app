import '../model/reportDetailsView_model.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_urls.dart';

class ReportDetailsRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<ReportDetails> fetchReportDetails(String reportId, String patientId) async {
    try {
      String url = '${AppUrl.reportDetailsEndpoint}?report_id=$reportId&patient_id=$patientId';
      final response = await _apiServices.getGetApiResponse(url);
      return ReportDetails.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
