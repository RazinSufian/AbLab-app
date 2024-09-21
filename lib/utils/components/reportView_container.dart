import 'package:ab_lab_app/res/app_colors.dart';
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
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
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
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.005),
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.003),
      decoration: BoxDecoration(
        color: AppColors.row_havy_blue,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey[400]!, width: 1),
      ),
      child: Row(
        children: [
          // Status bullet
          _buildStatusBullet(context, statusColor),

          // Test Name with fixed width
          SizedBox(
            width: screenWidth * 0.3, // Allocate 40% of the screen width
            child: _buildDataCell(testName),
          ),

          // Test ID with fixed width
          SizedBox(
            width: screenWidth * 0.17, // Allocate 25% of the screen width
            child: _buildDataCell(testId),
          ),

          // Reporter with fixed width
          SizedBox(
            width: screenWidth * 0.23, // Allocate 25% of the screen width
            child: _buildDataCell(reporter),
          ),
          SizedBox( width: screenWidth * 0.008),

          // View Button
          CustomButton(
            text: 'View',
            onPressed: onViewPressed,
            backgroundColor: Colors.white,
            textColor: Color(0xFF4D5AAF),
            borderColor: Color(0xFFB8BDDF),
            width: screenWidth * 0.115,
            borderWidth: 2,
            textWeight: FontWeight.bold

          ),
        ],
      ),
    );
  }

  // Helper to build the status bullet with respective color
  Widget _buildStatusBullet(BuildContext context, Color color) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.05,
      height: screenHeight * 0.015,
      margin: EdgeInsets.only(right: 0), // Adjust spacing to separate from the text
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  // Helper to build data cells
  Widget _buildDataCell(String value) {
    return Text(
      value,
      style: TextStyle(color: Colors.black),
      textAlign: TextAlign.center,
    );
  }
}
