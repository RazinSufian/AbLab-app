import 'package:flutter/material.dart';

class ReportListDataRow extends StatelessWidget {
  final String name;
  final String reportId;
  final String date;
  final String estimatedTotal;
  final String discount;
  final String paidAmount;
  final Color backgroundColor;

  const ReportListDataRow({
    Key? key,
    required this.name,
    required this.reportId,
    required this.date,
    required this.estimatedTotal,
    required this.discount,
    required this.paidAmount,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    // Calculate total = estimatedTotal * discount
    double total = double.parse(estimatedTotal) * (1 - double.parse(discount) / 100);

    // Calculate due = total - paidAmount
    double due = total - double.parse(paidAmount);

    // Format the date to show only the day
    final formattedDate = _formatDate(date);

    // Shorten the name to the first 9 characters
    final shortName = name.length > 9 ? '${name.substring(0, 8)}..' : name;

    return Container(
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
          _buildDataCell(shortName, alignLeft: true), // Align the name to the left
          _buildDataCell(reportId),
          _buildDataCell(formattedDate),
          _buildDataCell(total.toStringAsFixed(2)), // Display total formatted to 2 decimal places
          _buildDataCell(due.toStringAsFixed(2)), // Display due formatted to 2 decimal places
        ],
      ),
    );
  }

  // Helper function to build individual data cells
  Widget _buildDataCell(String value, {bool alignLeft = false}) {
    return Expanded(
      child: Text(
        value,
        style: TextStyle(color: Colors.black),
        textAlign: alignLeft ? TextAlign.left : TextAlign.center, // Align left or center based on parameter
      ),
    );
  }

  // Function to format the date to show only the day
  String _formatDate(String date) {
    // Assuming date format is "YYYY-MM-DD"
    final parts = date.split('-');
    if (parts.length == 3) {
      final day = parts[2]; // Get the day part of the date
      return day;
    }
    return date; // Return original date if the format is not as expected
  }
}
