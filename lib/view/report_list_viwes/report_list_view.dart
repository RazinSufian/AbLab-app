import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/components/commonHeader.dart';
import '../../utils/components/customPicker.dart';
import '../../utils/components/report_row_widget.dart';
import '../../utils/utils.dart';
import '../../view_model/report_list_view_model.dart';
import '../../res/image_assets.dart';
import '../../res/app_colors.dart';

class ReportListPage extends StatefulWidget {
  @override
  _ReportListPageState createState() => _ReportListPageState();
}

class _ReportListPageState extends State<ReportListPage> {
  String? selectedQuery;
  String? selectedWeek;
  DateTime? selectedDate;
  DateTime? rangeStartDate;
  DateTime? rangeEndDate;
  bool searchByMonth = false;

  // For month-based search
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final List<String> years = List.generate(2044 - DateTime.now().year + 1,
      (index) => (DateTime.now().year + index).toString());

  String? selectedMonth;
  String? selectedYear;

  @override
  void initState() {
    super.initState();

    // Initialize with current month and year by default
    DateTime now = DateTime.now();
    selectedMonth = months[now.month - 1]; // Current month
    selectedYear = now.year.toString(); // Current year

    // Update day_range based on current month and year
    _updateDayRange();

    // Clear selectedQuery if not in month selection mode
    if (!searchByMonth) {
      selectedQuery = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final reportViewModel = Provider.of<ReportListViewModel>(context);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          CommonHeader(
            title: 'Report List',
            hideBackButton: false,
            onBackPress: () {
              Navigator.of(context).pop();
            },
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Search by Month',
                      style: TextStyle(
                          fontSize: 15,
                          color: AppColors.blackColor), // Apply custom styling
                    ),
                    Switch(
                      value: searchByMonth,
                      onChanged: (value) {
                        _toggleSearchByMonth(value);
                      },
                      activeTrackColor: AppColors
                          .skyBGColor, // Background color of the switch when it's on
                      // activeColor: AppColors.skyBGColor,  // Thumb color when the switch is on
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    _fetchData(reportViewModel);
                  },
                  child: Text(
                    'Fetch Data',
                    style: TextStyle(
                        fontSize: 15,
                        color: AppColors.activeBGColor), // Apply custom styling
                  ),
                ),
              ],
            ),
          ),
          // Fixed-size container for input options
          Container(
            height: screenHeight * 0.15, // Fixed height for the input container
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child:
                      searchByMonth ? _buildMonthSearch() : _buildDateSearch(),
                ),
              ],
            ),
          ),
          // Labels for report status
          Padding(
            padding:
                 EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.00),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 10, height: 10, color: Colors.red),
                    // Red dot
                    SizedBox(width: 5),
                    Text('Unpaid Reports', style: TextStyle(fontSize: 14)),
                  ],
                ),
                SizedBox(width: screenWidth * 0.05),
                Row(
                  children: [
                    Container(width: 10, height: 10, color: Colors.yellow),
                    // Yellow dot
                    SizedBox(width: 5),
                    Text('Report Incomplete', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
          // Space for displaying fetched data
          Expanded(
            child: reportViewModel.errorMessage.isNotEmpty
                ? Center(child: Text(reportViewModel.errorMessage))
                : reportViewModel.reportList.isEmpty
                    ? Center(
                        child: Text(
                          'No report data available',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: reportViewModel.reportList.length,
                        itemBuilder: (context, index) {
                          final report = reportViewModel.reportList[index];

                          // Calculate total = estimatedTotal * discount
                          double total = double.parse(report.estimatedTotal) *
                              (1 - double.parse(report.discount) / 100);

                          // Calculate due = total - paidAmount
                          double due = total - double.parse(report.paidAmount);

                          // Default background color based on index
                          Color backgroundColor = index % 2 == 0
                              ? AppColors.row_havy_blue
                              : AppColors.row_light_blue;

                          // Check if due amount is greater than 10
                          if (due > 10) {
                            backgroundColor = Colors.red;
                          } else if (report.testReportStatus != null) {
                            // Only check testReportStatus if backgroundColor is not already red
                            report.testReportStatus.forEach((testId, status) {
                              if (status == "0") {
                                backgroundColor = Colors.yellow;
                              }
                            });
                          }

                          return ReportListDataRow(
                            name: report.patientName,
                            reportId: report.reportId,
                            date: report.entryDate,
                            estimatedTotal: report.estimatedTotal,
                            discount: report.discount,
                            paidAmount: report.paidAmount,
                            backgroundColor: backgroundColor,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  // Date-based search UI
  Widget _buildDateSearch() {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // Calculate the dates
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime dayBeforeYesterday = today.subtract(Duration(days: 2));

    // Format the dates
    String todayString = 'day=${today.toIso8601String().split('T')[0]}';
    String yesterdayString = 'day=${yesterday.toIso8601String().split('T')[0]}';
    String dayBeforeYesterdayString =
        'day=${dayBeforeYesterday.toIso8601String().split('T')[0]}';

    return Row(
      children: [
        // CustomPicker for selecting the date
        Expanded(
          child: CustomPicker(
            title: "Date:",
            initialText: selectedDate != null
                ? 'Date: ${selectedDate!.toLocal().toIso8601String().split('T')[0]}'
                : "Date: Select Date",
            selectedDateText: selectedDate != null
                ? 'Date: ${selectedDate!.toLocal().toIso8601String().split('T')[0]}'
                : null,
            selectDateFunction: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  selectedDate = pickedDate;
                  selectedQuery =
                      'day=${pickedDate.toIso8601String().split('T')[0]}';
                  selectedWeek = null; // Reset week selection
                });
              }
            },
            isRequired: false,
          ),
        ),
        SizedBox(width: screenWidth * 0.05),
        // Space between the CustomPicker and Dropdown

        // Dropdown for selecting the week range
        DropdownButton<String>(
          hint: Text('Select',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
          // Placeholder text
          value: selectedWeek,
          // Default to null so it shows the hint
          items: [
            DropdownMenuItem(
              value: todayString,
              child: Text('Today',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            ),
            DropdownMenuItem(
              value: yesterdayString,
              child: Text('Previous Day',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            ),
            DropdownMenuItem(
              value: dayBeforeYesterdayString,
              child: Text('Day Before Yesterday',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            ),
            DropdownMenuItem(
              value: 'week=1',
              child: Text('This Week',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            ),
            DropdownMenuItem(
              value: 'week=2',
              child: Text('Previous Week',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            ),
          ],
          onChanged: (newValue) {
            setState(() {
              selectedWeek = newValue;
              selectedQuery = newValue;
              selectedDate = null; // Reset date selection
            });
          },
        ),
      ],
    );
  }

  // Month-based search UI
  Widget _buildMonthSearch() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: DropdownButton<String>(
            hint: Text('Select Month',
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.blackColor,
                    fontWeight:
                        FontWeight.w400)), // Apply custom styling to hint
            value: selectedMonth,
            items: months.map((String month) {
              return DropdownMenuItem<String>(
                value: month,
                child: Text(
                  month,
                  style: TextStyle(
                      fontSize: 15,
                      color: AppColors
                          .blackColor), // Apply custom styling to items
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedMonth = newValue;
                _updateDayRange(); // Call function to update day_range
              });
            },
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: DropdownButton<String>(
            hint: Text('Select Year',
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.blackColor,
                    fontWeight:
                        FontWeight.w400)), // Apply custom styling to hint
            value: selectedYear,
            items: years.map((String year) {
              return DropdownMenuItem<String>(
                value: year,
                child: Text(
                  year,
                  style: TextStyle(
                      fontSize: 15,
                      color: AppColors
                          .blackColor), // Apply custom styling to items
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedYear = newValue;
                _updateDayRange(); // Call function to update day_range
              });
            },
          ),
        ),
      ],
    );
  }

  // Function to update the day_range parameter based on selected month and year
  void _updateDayRange() {
    if (selectedMonth != null && selectedYear != null) {
      // Find the index of the selected month
      int monthIndex =
          months.indexOf(selectedMonth!) + 1; // +1 because index is 0-based
      String month = monthIndex
          .toString()
          .padLeft(2, '0'); // Ensure two-digit format for month
      String year = selectedYear!;

      // Determine the last day of the month
      DateTime firstDayOfMonth = DateTime(int.parse(year), monthIndex, 1);
      DateTime lastDayOfMonth =
          DateTime(int.parse(year), monthIndex + 1, 0); // 0th day of next month

      // Format the date range
      String startDate = '${year}-${month}-01';
      String endDate =
          '${year}-${month}-${lastDayOfMonth.day.toString().padLeft(2, '0')}';

      // Construct the day_range parameter
      selectedQuery = 'day_range=${startDate}_to_${endDate}';
    } else {
      // Reset selectedQuery if either month or year is not selected
      selectedQuery = null;
    }
  }

  // Fetch data
  void _fetchData(ReportListViewModel viewModel) {
    // Check if the query parameter is empty
    if ((searchByMonth && selectedQuery == "") ||
        (!searchByMonth && selectedQuery == "")) {
      Utils.showFlashMessage(
        context: context,
        message: 'Please select a query parameter',
        backgroundColor: Colors.red, // You can customize the color as needed
        icon: Icons.warning, // Optional: Use an icon if desired
      );
      return; // Exit the method if no query parameter is selected
    }

    // Use selectedQuery for API call
    Utils.showLoading(context); // Show custom loading indicator
    viewModel.fetchReport(selectedQuery!).then((_) {
      Utils.cancelLoading(context); // Hide custom loading indicator
    });
  }

  // Toggle Search By Month
  void _toggleSearchByMonth(bool value) {
    setState(() {
      searchByMonth = value;
      selectedQuery = ''; // Reset selectedQuery if not in month selection mode
      selectedDate = null;
      selectedWeek = null;
    });
  }
}
