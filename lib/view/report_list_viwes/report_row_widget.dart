import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/report_details_controller.dart';
import '../../routes/routes_name.dart'; // Import routes

class ReportListDataRow extends StatelessWidget {
  final String name;
  final String reportId;
  final String date;
  final String estimatedTotal;
  final String discount;
  final String paidAmount;
  final Color backgroundColor;
  final String patientId;

  const ReportListDataRow({
    Key? key,
    required this.name,
    required this.reportId,
    required this.date,
    required this.estimatedTotal,
    required this.discount,
    required this.paidAmount,
    required this.backgroundColor,
    required this.patientId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    // Calculate total = estimatedTotal * discount
    double total = double.parse(estimatedTotal) * (1 - double.parse(discount) / 100);
    double due = total - double.parse(paidAmount);
    final formattedDate = _formatDate(date);
    final shortName = name.length > 9 ? '${name.substring(0, 8)}..' : name;

    return GestureDetector(
      onTap: () {
        // Set the report and patient ID in the GetX controller
        final reportController = Get.put(ReportController());
        reportController.setReportDetails(reportId, patientId);

        // Navigate to ReportView without making an API call
        Navigator.pushNamed(context, RoutesName.report_details_view);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.0115,
          horizontal: screenWidth * 0.04,
        ),
        margin: EdgeInsets.symmetric(
          vertical: screenHeight * 0.0025,
          horizontal: screenWidth * 0.015,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDataCell(shortName, alignLeft: true),
            _buildDataCell(reportId),
            _buildDataCell(formattedDate),
            _buildDataCell(total.toStringAsFixed(2)),
            _buildDataCell(due.toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }

  // Helper function to build individual data cells
  Widget _buildDataCell(String value, {bool alignLeft = false}) {
    return Expanded(
      child: Text(
        value,
        style: TextStyle(color: Colors.black),
        textAlign: alignLeft ? TextAlign.left : TextAlign.center,
      ),
    );
  }

  // Function to format the date to show only the day
  String _formatDate(String date) {
    final parts = date.split('-');
    if (parts.length == 3) {
      final day = parts[2];
      return day;
    }
    return date;
  }
}
