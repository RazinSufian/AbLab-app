class ReportSummary {
  final String totalPatients;
  final String estimatedTotal;
  final String unpaidCount;
  final String discountCount;
  final String income;

  ReportSummary({
    required this.totalPatients,
    required this.estimatedTotal,
    required this.unpaidCount,
    required this.discountCount,
    required this.income,
  });

  // Factory constructor to parse the JSON data
  factory ReportSummary.fromJson(Map<String, dynamic> json) {
    return ReportSummary(
      totalPatients: json['total_patients'],
      estimatedTotal: json['estimated_total'],
      unpaidCount: json['unpaid_count'],
      discountCount: json['discount_count'],
      income: json['income'],
    );
  }
}

class ReportResponse {
  final Map<String, ReportSummary> summary;
  final String startDate;
  final String endDate;
  final String unpaidCount;
  final String discountCount;

  ReportResponse({
    required this.summary,
    required this.startDate,
    required this.endDate,
    required this.unpaidCount,
    required this.discountCount,
  });

  // Factory constructor to parse the JSON data
  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    Map<String, ReportSummary> summaryMap = {};
    json['summary'].forEach((key, value) {
      summaryMap[key] = ReportSummary.fromJson(value);
    });

    return ReportResponse(
      summary: summaryMap,
      startDate: json['start_date'],
      endDate: json['end_date'],
      unpaidCount: json['unpaid_count'],
      discountCount: json['discount_count'],
    );
  }
}
