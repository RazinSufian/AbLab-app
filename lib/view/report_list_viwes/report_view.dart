import 'package:ab_lab_app/res/app_colors.dart';
import 'package:ab_lab_app/view/report_list_viwes/reportView_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart'; // Make sure to include provider for state management
import '../../controller/report_details_controller.dart';
import '../../utils/components/commonHeader.dart';
import '../../utils/components/customButton.dart';

import '../../view_model/report_details_view_model.dart';
import 'downloadBillPdf.dart'; // Import your view model

class ReportView extends StatefulWidget {
  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  final reportController = Get.put(ReportController());
  late ReportDetailsViewModel reportDetailsViewModel;

  @override
  void initState() {
    super.initState();
    reportDetailsViewModel = Provider.of<ReportDetailsViewModel>(context, listen: false);

    // Schedule the API call to run after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchReportDetails();
    });
  }

  void fetchReportDetails() {
    reportDetailsViewModel.fetchReportDetails(
      context,
      reportController.reportId.value,
      reportController.patientId.value,
    );
  }

  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: Consumer<ReportDetailsViewModel>(
              builder: (context, reportDetailsViewModel, child) {
                if (reportDetailsViewModel.errorMessage.isNotEmpty) {
                  return Center(child: Text(reportDetailsViewModel.errorMessage));
                }

                final reportDetails = reportDetailsViewModel.reportDetails;

                if (reportDetails == null) {
                  return Center(child: Text("No report details available."));
                }

                // Getting the patient and report data
                final patient = reportDetails.patient;
                final report = reportDetails.report;

                // Getting the billInformations (for table) and testes_informations (for TestReportContainer)
                final billInformations = report.billInformations;
                final testesInformations = reportDetails.testesInformations;

                return SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Patient Information Section (can be kept static or dynamic if needed)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Patient Information', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Roboto Slab", fontSize: 15)),
                              SizedBox(height: screenHeight * 0.01),
                              Text('Patient ID: ${patient.patientId}'),
                              Text('Name: ${patient.name}'),
                              Text('Age: ${patient.age}'),
                              Text('Address: ${patient.address}'),
                              Text('Phone: ${patient.phone}'),
                              Text('Gender: ${patient.gender}'),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Report Information:', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Roboto Slab", fontSize: 15)),
                              SizedBox(height: screenHeight * 0.01),
                              Text('Report ID: ${report.reportId}'),
                              Text('Biller Name: ${report.billerName}'),
                              Text('Billing Date: ${report.entryDate}'),
                              Text('Billing Time: ${report.entryTime}'),
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
                            downloadBillPdf(context, reportDetailsViewModel);
                          },
                          backgroundColor: AppColors.skyBGColor,
                          textColor: Colors.white,
                          borderColor: AppColors.buttonBorder,
                        ),
                      ),
                      SizedBox(height: 16),
                      // Dynamic Tests Table (using billInformations)
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
                                      // Dynamically build table rows from billInformations
                                      for (var i = 0; i < billInformations.length; i++)
                                        _buildTableRow(i + 1, billInformations.keys.elementAt(i), billInformations.values.elementAt(i)),
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
                                          Text('Grand Total: ${report.estimatedTotal}'),
                                          Text('Discount %: ${report.discount}'),
                                          Text('Total Payable: ${(int.parse(report.estimatedTotal) * (1 - (int.parse(report.discount) / 100))).toStringAsFixed(2)}'),
                                          Text('Paid Amount: ${report.paidAmount}'),
                                          Text('Due Amount: ${(int.parse(report.estimatedTotal) * (1 - (int.parse(report.discount) / 100)) - int.parse(report.paidAmount)).toStringAsFixed(2)}'),
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
                            // Dynamically build TestReportContainers from testesInformations
                            for (var testId in testesInformations.keys)
                              TestReportContainer(
                                testName: _getTestName(testId), // Based on prefix logic
                                testId: testId,
                                reporter: testesInformations[testId]?.reportBy ?? "N/A",
                                status: _getStatus(testesInformations[testId]?.reportStatus),
                                onViewPressed: () {
                                  // Implement view action
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
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get status based on report_status
  String _getStatus(String? reportStatus) {
    if (reportStatus == "1") return "Complete";
    if (reportStatus == "2") return "Draft";
    return "Incomplete";
  }

  // Helper method to get test name based on the testId prefix
  String _getTestName(String testId) {
    String prefix = testId.substring(0, 2);
    switch (prefix) {
      case "PS":
        return "Pap's Smear";
      case "FN":
        return "FNAC";
      case "SB":
        return "Skin Biopsy";
      case "SA":
        return "Semen Analysis";
      case "FA":
        return "Fluid Analysis";
      case "NB":
        return "Needle Core Biopsy";
      case "HB":
        return "Histopathology/Biopsy";
      case "FC":
        return "Fungus/Cytology";
      default:
        return "Unknown Test";
    }
  }

  // Dynamic table row builder
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
