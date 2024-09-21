import 'package:ab_lab_app/res/app_colors.dart';
import 'package:flutter/material.dart';

import '../../utils/components/commonHeader.dart';
import '../../utils/components/customButton.dart';
import '../../utils/components/reportView_container.dart';

class TestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          CommonHeader(
            title: 'Report View',
            hideBackButton: false,
            onBackPress: () {
              Navigator.of(context).pop();
            },
          ),
          Expanded( // Use Expanded to ensure body takes remaining space
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Patient Information Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Patient Information', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Roboto Slab", fontSize: 15)),
                          SizedBox(height: screenHeight * 0.01),
                          Text('Patient ID: 22123123'),
                          Text('Name:'),
                          Text('Age:'),
                          Text('Address:'),
                          Text('Phone:'),
                          Text('Gender:'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Report Information:', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Roboto Slab", fontSize: 15)),
                          SizedBox(height: screenHeight * 0.01),
                          Text('Report ID:'),
                          Text('Biller Name:'),
                          Text('Billing Date:'),
                          Text('Billing Time:'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Download Bill Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomButton(
                      text: 'Download Bill',
                      onPressed: () {
                        // Implement the download bill action
                      },
                      backgroundColor: AppColors.skyBGColor,
                      textColor: Colors.white,
                      borderColor: AppColors.buttonBorder,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Tests Table within a gray container
                  Container(
                    color: Colors.grey[350]!,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: Column(
                            children: [
                              Table(
                                border: TableBorder(
                                  bottom: BorderSide(width: 1, color: Colors.black),
                                  verticalInside: BorderSide(width: 1, color: Colors.black),
                                ),
                                columnWidths: {
                                  0: FlexColumnWidth(0.15),
                                  1: FlexColumnWidth(0.6),
                                  2: FlexColumnWidth(0.3),
                                },
                                children: [
                                  TableRow(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.black, width: 1),
                                      ),
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('No', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Roboto Slab")),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Test Name', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Roboto Slab")),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Roboto Slab")),
                                      ),
                                    ],
                                  ),
                                  _buildTableRow(1, 'Red Blood Cell', '2000'),
                                  TableRow(children: [SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8)]), // Spacer row
                                  _buildTableRow(2, 'White Blood Cell', '3000'),
                                  TableRow(children: [SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8)]), // Spacer row
                                  _buildTableRow(3, 'Blood Platelets', '2000'),
                                ],
                              ),
                              // Summary Section within gray container
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('Grand Total: 7000'),
                                      Text('Discount %: 25%'),
                                      Text('Total Payable: 5250'),
                                      Text('Paid Amount: 3750'),
                                      Text('Due Amount: 1500'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Center the Test Reports Section
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        Text('Test Reports', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Roboto Slab')),
                        SizedBox(height: screenHeight * 0.03),
                        // Header Row
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.0),
                          child: Row(
                            children: [
                              SizedBox(width: screenWidth * 0.13),
                              _buildHeaderCell('Test Name'),
                              SizedBox(width: screenWidth * 0.12),
                              _buildHeaderCell('Test ID'),
                              SizedBox(width: screenWidth * 0.07),
                              _buildHeaderCell('Reported By'),
                              Container(), // Placeholder for status bullet
                            ],
                          ),
                        ),
                        Divider(thickness: 1, color: Colors.black),
                        // Test Report Containers
                        TestReportContainer(
                          testName: 'RBC',
                          testId: 'A#3005',
                          reporter: 'doctor name',
                          status: 'complete',
                          onViewPressed: () {
                            // View action
                          },
                        ),
                        TestReportContainer(
                          testName: 'WBC',
                          testId: 'B#3005',
                          reporter: 'doctor name',
                          status: 'draft',
                          onViewPressed: () {
                            // View action
                          },
                        ),
                        TestReportContainer(
                          testName: 'PLTdsfsdfdsf sadfsafsaasdasdsadsa sda',
                          testId: 'P#3005',
                          reporter: 'doctor namesadasdasdsad',
                          status: 'incomplete',
                          onViewPressed: () {
                            // View action
                          },
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(width: 10, height: 10, color: Colors.red),
                                SizedBox(width: 5),
                                Text('Report Incomplete', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            SizedBox(width: screenWidth * 0.011),
                            Row(
                              children: [
                                Container(width: 10, height: 10, color: Colors.yellow),
                                SizedBox(width: 5),
                                Text('Report Draft', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            SizedBox(width: screenWidth * 0.011),
                            Row(
                              children: [
                                Container(width: 10, height: 10, color: Colors.green),
                                SizedBox(width: 5),
                                Text('Report Complete', style: TextStyle(fontSize: 12, fontFamily: 'Roboto Slab')),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // CustomButton implementations can go here
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(int no, String testName, String amount) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(no.toString()),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(testName),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(amount),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 12,
        fontFamily: 'Roboto Slab',
      ),
      textAlign: TextAlign.center,
    );
  }
}
