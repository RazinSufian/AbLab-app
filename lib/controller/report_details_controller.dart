import 'package:get/get.dart';

class ReportController extends GetxController {
  var reportId = ''.obs;
  var patientId = ''.obs;

  void setReportDetails(String reportId, String patientId) {
    this.reportId.value = reportId;
    this.patientId.value = patientId;
  }
}
