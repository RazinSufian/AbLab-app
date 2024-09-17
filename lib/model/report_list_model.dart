// models/report_model.dart

class Report {
  final String referredTo;
  final String entryDate;
  final String patientName;
  final String dateOfBirth;
  final String discount;
  final String referredBy;
  final Map<String, String> testReportStatus;
  final String estimatedTotal;
  final String paidAmount;
  final String deliveryDate;
  final String billerName;
  final String reportDeleteFlag;
  final String extra1;
  final Map<String, String> billInformations;
  final String entryTime;
  final String patientId;
  final String reportId;
  final String payableTotal;
  final String unpaidStatus;

  Report({
    required this.referredTo,
    required this.entryDate,
    required this.patientName,
    required this.dateOfBirth,
    required this.discount,
    required this.referredBy,
    required this.testReportStatus,
    required this.estimatedTotal,
    required this.paidAmount,
    required this.deliveryDate,
    required this.billerName,
    required this.reportDeleteFlag,
    required this.extra1,
    required this.billInformations,
    required this.entryTime,
    required this.patientId,
    required this.reportId,
    required this.payableTotal,
    required this.unpaidStatus,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      referredTo: json['referred_to'] ?? '',
      entryDate: json['entry_date'] ?? '',
      patientName: json['patient_name'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      discount: json['discount'] ?? '',
      referredBy: json['referred_by'] ?? '',
      testReportStatus: Map<String, String>.from(json['test_report_status'] ?? {}),
      estimatedTotal: json['estimated_total'] ?? '',
      paidAmount: json['paid_amount'] ?? '',
      deliveryDate: json['delivery_date'] ?? '',
      billerName: json['biller_name'] ?? '',
      reportDeleteFlag: json['report_delete_flag'] ?? '',
      extra1: json['extra1'] ?? '',
      billInformations: Map<String, String>.from(json['bill_informations'] ?? {}),
      entryTime: json['entry_time'] ?? '',
      patientId: json['patient_id'] ?? '',
      reportId: json['report_id'] ?? '',
      payableTotal: json['payable_total'] ?? '',
      unpaidStatus: json['unpaid_status'] ?? '',
    );
  }
}
