import 'package:flutter/material.dart';

import '../../utils/components/customButton.dart';
import '../../utils/components/reportView_container.dart';

class TestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('Tests')),
      body: SingleChildScrollView(
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
                    Text('Patient ID: 22123123', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Information:'),
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
                    Text('Report Information:', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Date:'),
                    Text('Blood Group:'),
                    Text('Report ID:'),
                    Text('Biller Name:'),
                    Text('Reporter Name:'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            // Download Bill Button
            Align(
              alignment: Alignment.centerLeft, // Align to the left
              child: CustomButton(
                text: 'Download Bill',
                onPressed: () {
                  // Implement the download bill action
                },
                backgroundColor: Colors.blue,
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            // Tests Table within a gray container
            Container(
              color: Colors.grey[200], // Gray background for the table container
              child: Column(
                children: [
                  // Adding the border around the entire container
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Column(
                      children: [
                        Table(
                          border: TableBorder(
                            bottom: BorderSide(width: 1, color: Colors.black), // Bottom border of the table
                            verticalInside: BorderSide(width: 1, color: Colors.black), // Vertical lines inside the table
                          ),
                          columnWidths: {
                            0: FlexColumnWidth(0.15), // Adjusted widths after removing the empty column
                            1: FlexColumnWidth(0.6),
                            2: FlexColumnWidth(0.3),
                          },
                          children: [
                            TableRow(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.black, width: 1), // Row line below the header
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('No', style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Test Name', style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            _buildTableRow(1, 'Red Blood Cell', '2000'),
                            TableRow(
                              children: [SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8)],
                            ), // Spacer row
                            _buildTableRow(2, 'White Blood Cell', '3000'),
                            TableRow(
                              children: [SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8)],
                            ), // Spacer row
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
            // Center the Test Reports Section
            Align(
              alignment: Alignment.center, // Center the Test Reports section
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Test Reports', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  // Header Row
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0), // Add left padding here
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _buildHeaderCell('Test Name')),
                        Expanded(child: _buildHeaderCell('Test ID')),
                        Expanded(child: _buildHeaderCell('Reported By')),
                        Expanded(child: Container()), // Placeholder for status bullet
                      ],
                    ),
                  ),

                  // Add a horizontal line under the header row
                  Divider(
                    thickness: 1, // Adjust thickness of the line
                    color: Colors.black, // Color of the line
                  ),
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
                    testName: 'PLT',
                    testId: 'P#3005',
                    reporter: 'doctor name',
                    status: 'incomplete',
                    onViewPressed: () {
                      // View action
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  text: 'Save',
                  onPressed: () {
                    // Implement save action
                  },
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                ),
                SizedBox(width: 16),
                CustomButton(
                  text: 'Download All',
                  onPressed: () {
                    // Implement download all action
                  },
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                ),
                SizedBox(width: 16),
                CustomButton(
                  text: 'Cancel',
                  onPressed: () {
                    // Implement cancel action
                  },
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
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
          color: Colors.black, fontWeight: FontWeight.normal, fontSize: 12),
      textAlign: TextAlign.center,
    );
  }
}

// New TestReportContainer widge
