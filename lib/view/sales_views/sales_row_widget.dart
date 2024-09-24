import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/reportListController.dart'; // Assuming controllers are stored here
import '../../controller/pageValueController.dart'; // Assuming controllers are stored here
import '../../routes/routes.dart';
import '../../routes/routes_name.dart'; // Assuming routes are defined here

class DataRowWidget extends StatelessWidget {
  final String date;
  final String totalPatients;
  final String estimatedTotal;
  final String unpaid;
  final String discount;
  final String income;
  final Color backgroundColor;



  const DataRowWidget({
    Key? key,
    required this.date,
    required this.totalPatients,
    required this.estimatedTotal,
    required this.unpaid,
    required this.discount,
    required this.income,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReportListController _reportListController = Get.put(ReportListController()); // Find the ReportListController
    final PageValueController _pageValueController = Get.put(PageValueController()); // Find the PageValueController
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    // Format the date to "DD-MM-YY"
    final formattedDate = _formatDate(date);

    return GestureDetector(
      onTap: () {
        // Step 1: Pass the date to the ReportListController's QuaryController
        _reportListController.QuaryController = 'day=$date';
        print('QuaryController: ${_reportListController.QuaryController}');

        // Step 2: Set reportListPage to "1"
        _pageValueController.updateReportListPage("1");

        // Step 3: Navigate to ReportListPage
        Navigator.pushNamed(context, RoutesName.reportList);
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
          color: backgroundColor, // Set the background color
          borderRadius: BorderRadius.circular(6), // Add rounded corners
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDataCell(formattedDate), // Use displayDate here
            _buildDataCell(totalPatients),
            _buildDataCell(estimatedTotal),
            _buildDataCell(unpaid),
            _buildDataCell(discount),
            _buildDataCell(income),
          ],
        ),
      ),
    );
  }

  // Helper function to build individual data cells
  Widget _buildDataCell(String value) {
    return Expanded(
      child: Text(
        value,
        style: TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Function to format the date to "DD-MM-YY"
  String _formatDate(String date) {
    // Assuming date format is "YYYY-MM-DD"
    final parts = date.split('-');
    if (parts.length == 3) {
      final year = parts[0].substring(2); // Get the last two characters of the year
      final month = parts[1];
      final day = parts[2];
      return '$day-$month-$year';
    }
    return date; // Return original date if the format is not as expected
  }
}
