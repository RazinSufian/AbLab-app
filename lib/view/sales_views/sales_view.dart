import 'package:ab_lab_app/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sales_row_widget.dart'; // Make sure to use the correct path
import '../../view_model/sales_view_model.dart';
import '../../utils/components/commonHeader.dart';
import '../../utils/utils.dart'; // Import Utils for custom loading

class SalesPage extends StatefulWidget {
  SalesPage({Key? key}) : super(key: key);

  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'
  ];

  final List<String> years = List.generate(2044 - DateTime.now().year + 1, (index) => (DateTime.now().year + index).toString());

  String? selectedMonth;
  String? selectedYear;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedMonth = months[now.month - 1];
    selectedYear = now.year.toString();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final reportViewModel = Provider.of<SalesViewModel>(context);

    // Calculate totals
    int totalPatients = 0;
    double totalEstimatedIncome = 0.0;
    double totalIncome = 0.0;

    if (reportViewModel.reportResponse != null && reportViewModel.reportResponse!.summary.isNotEmpty) {
      reportViewModel.reportResponse!.summary.forEach((key, report) {
        totalPatients += int.parse(report.totalPatients);
        totalEstimatedIncome += double.parse(report.estimatedTotal);
        totalIncome += double.parse(report.income);
      });
    }

    return Scaffold(
      body: Column(
        children: [
          CommonHeader(
            title: 'Sales',
            hideBackButton: false,
            onBackPress: () {
              Navigator.of(context).pop();
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text('Select Month'),
                    value: selectedMonth,
                    items: months.map((String month) {
                      return DropdownMenuItem<String>(
                        value: month,
                        child: Text(month),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedMonth = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: DropdownButton<String>(
                    hint: Text('Select Year'),
                    value: selectedYear,
                    items: years.map((String year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedYear = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                TextButton(
                  onPressed: () async {
                    if (selectedYear != null && selectedMonth != null) {
                      final monthIndex = months.indexOf(selectedMonth!) + 1;
                      final formattedMonth = monthIndex.toString().padLeft(2, '0');
                      final selectedDate = '$selectedYear-$formattedMonth';

                      // Show custom loading indicator
                      Utils.showLoading(context);

                      // Fetch report data
                      try {
                        await reportViewModel.fetchReport(selectedDate);
                      } finally {
                        // Hide custom loading indicator
                        Utils.cancelLoading(context);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select both year and month')),
                      );
                    }
                  },
                  child: Text("Fetch Data"),
                ),
              ],
            ),
          ),

          Expanded(
            child: reportViewModel.errorMessage.isNotEmpty
                ? Center(
              child: Text(
                reportViewModel.errorMessage,
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            )
                : reportViewModel.reportResponse?.summary.isEmpty ?? true
                ? Center(
              child: Text(
                'No report data available',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.3, top: screenHeight * 0.02, left: screenWidth * 0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Patients: $totalPatients', textAlign: TextAlign.left),
                      SizedBox(height: screenHeight * 0.005),
                      Text('Total Expected Income: $totalEstimatedIncome', textAlign: TextAlign.left),
                      SizedBox(height: screenHeight * 0.005),
                      Text('Income: $totalIncome', textAlign: TextAlign.left),
                      SizedBox(height: screenHeight * 0.05),
                    ],
                  ),
                ),

                // Add header row with underlined text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025), // Apply padding to the header row
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: _buildHeaderCell('Date')),
                          Expanded(child: _buildHeaderCell('Total Patients')),
                          Expanded(child: _buildHeaderCell('Estimated Total')),
                          Expanded(child: _buildHeaderCell('Unpaid')),
                          Expanded(child: _buildHeaderCell('Discounts')),
                          Expanded(child: _buildHeaderCell('Income')),
                        ],
                      ),
                      // Add a horizontal line under the header row
                      Divider(
                        thickness: 1, // Adjust thickness of the line
                        color: Colors.black, // Color of the line
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero, // Remove padding from the ListView
                    itemCount: reportViewModel.reportResponse?.summary.length ?? 0,
                    itemBuilder: (context, index) {
                      final key = reportViewModel.reportResponse!.summary.keys.elementAt(index);
                      final report = reportViewModel.reportResponse!.summary[key]!;
                      final backgroundColor = index % 2 == 0
                          ? AppColors.row_havy_blue
                          : AppColors.row_light_blue;

                      return DataRowWidget(
                        date: key,
                        totalPatients: report.totalPatients,
                        estimatedTotal: report.estimatedTotal,
                        unpaid: report.unpaidCount,
                        discount: report.discountCount,
                        income: report.income,
                        backgroundColor: backgroundColor,
                      );
                    },
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }

  // Helper function to build header cells
  Widget _buildHeaderCell(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 12),
      textAlign: TextAlign.center,
    );
  }
}
