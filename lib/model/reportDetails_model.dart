class Patient {
  String patientDeleteFlag;
  String address;
  String dateOfBirth;
  String phone;
  String name;
  String bloodGroup;
  String gender;
  String patientId;
  String age;

  Patient({
    required this.patientDeleteFlag,
    required this.address,
    required this.dateOfBirth,
    required this.phone,
    required this.name,
    required this.bloodGroup,
    required this.gender,
    required this.patientId,
    required this.age,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      patientDeleteFlag: json['patient_delete_flag'],
      address: json['address'],
      dateOfBirth: json['date_of_birth'],
      phone: json['phone'],
      name: json['name'],
      bloodGroup: json['blood_group'],
      gender: json['gender'],
      patientId: json['patient_id'],
      age: json['age'],
    );
  }
}

class Report {
  String referredTo;
  String entryDate;
  String patientName;
  String discount;
  String paidAmount;
  String estimatedTotal;
  String reportId;
  String billerName;
  String entryTime;
  Map<String, String> testReportStatus;
  Map<String, String> billInformations;

  Report({
    required this.referredTo,
    required this.entryDate,
    required this.patientName,
    required this.discount,
    required this.paidAmount,
    required this.estimatedTotal,
    required this.reportId,
    required this.billerName,
    required this.entryTime,
    required this.testReportStatus,
    required this.billInformations,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      referredTo: json['referred_to'],
      entryDate: json['entry_date'],
      patientName: json['patient_name'],
      discount: json['discount'],
      paidAmount: json['paid_amount'],
      estimatedTotal: json['estimated_total'],
      reportId: json['report_id'],
      billerName: json['biller_name'],
      entryTime: json['entry_time'],
      testReportStatus: Map<String, String>.from(json['test_report_status']),
      billInformations: Map<String, String>.from(json['bill_informations']),
    );
  }
}

class TestInformation {
  String reportStatus;
  String reportBy;

  TestInformation({
    required this.reportStatus,
    required this.reportBy,
  });

  factory TestInformation.fromJson(Map<String, dynamic> json) {
    return TestInformation(
      reportStatus: json['report_status'],
      reportBy: json['report_by'],
    );
  }
}

class ReportDetails {
  Patient patient;
  Report report;
  Map<String, TestInformation> testesInformations;

  ReportDetails({
    required this.patient,
    required this.report,
    required this.testesInformations,
  });

  factory ReportDetails.fromJson(Map<String, dynamic> json) {
    // Parsing testes_informations
    Map<String, TestInformation> testesInformations = {};
    if (json['body']['testes_informations'] != null) {
      json['body']['testes_informations'].forEach((key, value) {
        testesInformations[key] = TestInformation.fromJson(value);
      });
    }

    return ReportDetails(
      patient: Patient.fromJson(json['body']['patient']),
      report: Report.fromJson(json['body']['report']),
      testesInformations: testesInformations,
    );
  }
}
