import 'package:flutter/material.dart';

import 'customButton.dart';

class TestReportContainer extends StatelessWidget {
  final String testName;
  final String testId;
  final String reporter;
  final String status;
  final VoidCallback onViewPressed;

  const TestReportContainer({
    Key? key,
    required this.testName,
    required this.testId,
    required this.reporter,
    required this.status,
    required this.onViewPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine status color
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'complete':
        statusColor = Colors.green;
        break;
      case 'draft':
        statusColor = Colors.orange;
        break;
      case 'incomplete':
      default:
        statusColor = Colors.red;
        break;
    }

    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey[400]!, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Display the status as a colored circle bullet
          _buildStatusBullet(statusColor),
          _buildDataCell(testName),
          _buildDataCell(testId),
          _buildDataCell(reporter),
          CustomButton(
            text: 'View',
            onPressed: onViewPressed,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }

  // Helper to build the status bullet with respective color
  Widget _buildStatusBullet(Color color) {
    return Container(
      width: 12,
      height: 12,
      margin: EdgeInsets.only(right: 8), // Adjust spacing to separate from the text
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  // Helper to build data cells
  Widget _buildDataCell(String value) {
    return Expanded(
      child: Text(
        value,
        style: TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }
}
