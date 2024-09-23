// repository/report_details_repository.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/reportDetails_model.dart';
import '../res/app_urls.dart';

class ReportDetailsRepository {
  Future<ReportDetails> fetchReportDetails(String reportId, String patientId) async {
    print("tring to make api call in repo");
    final response = await http.get(Uri.parse('${AppUrl.reportDetailsEndpoint}?report_id=$reportId&patient_id=$patientId'));

    if (response.statusCode == 200) {
      return ReportDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load report details');
    }
  }
}
