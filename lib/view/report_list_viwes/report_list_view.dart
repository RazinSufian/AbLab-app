import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../../controller/reportListController.dart';
import '../../utils/components/commonHeader.dart';
import '../../utils/components/customPicker.dart';
import 'report_row_widget.dart';
import '../../utils/utils.dart';
import '../../view_model/report_list_view_model.dart';
import '../../res/image_assets.dart';
import '../../res/app_colors.dart';


class ReportListPage extends StatefulWidget {
  @override
  _ReportListPageState createState() => _ReportListPageState();
}

class _ReportListPageState extends State<ReportListPage> {
  final ReportListController _reportListController = Get.put(ReportListController()); // Initialize controller
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

    // Clear QuaryController if not in month selection mode
    if (!searchByMonth) {
      _reportListController.QuaryController = '';
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
                      activeTrackColor: AppColors.skyBGColor,
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
                    SizedBox(width: 5),
                    Text('Unpaid Reports', style: TextStyle(fontSize: 14)),
                  ],
                ),
                SizedBox(width: screenWidth * 0.02),
                Row(
                  children: [
                    Container(width: 10, height: 10, color: Colors.yellow),
                    SizedBox(width: 5),
                    Text('Report Incomplete', style: TextStyle(fontSize: 14)),
                  ],
                ),
                SizedBox(width: screenWidth * 0.02),
                Row(
                  children: [
                    Container(width: 10, height: 10, color: AppColors.skyBGColor),
                    SizedBox(width: 5),
                    Text('Done', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
          if (reportViewModel.reportList.isNotEmpty) ...[
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.0),
              child: Row(
                children: [
                  SizedBox(width: screenWidth * 0.04),
                  _buildHeaderCell('Patient Name'),
                  SizedBox(width: screenWidth * 0.03),
                  _buildHeaderCell('Report ID'),
                  SizedBox(width: screenWidth * 0.05),
                  _buildHeaderCell('Date'),
                  SizedBox(width: screenWidth * 0.05),
                  _buildHeaderCell('Payable Total'),
                  SizedBox(width: screenWidth * 0.05),
                  _buildHeaderCell('Paid'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              child: Divider(thickness: 1, color: Colors.black),
            ),
          ],
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
                : Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.005),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: ClampingScrollPhysics(),
                itemCount: reportViewModel.reportList.length,
                itemBuilder: (context, index) {
                  final report = reportViewModel.reportList[index];
                  double total = double.parse(report.estimatedTotal) *
                      (1 - double.parse(report.discount) / 100);
                  double due = total - double.parse(report.paidAmount);
                  Color backgroundColor = index % 2 == 0
                      ? AppColors.row_havy_blue
                      : AppColors.row_light_blue;

                  if (due > 10) {
                    backgroundColor = Colors.red;
                  } else if (report.testReportStatus != null) {
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
                    patientId: report.patientId,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDateSearch() {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime dayBeforeYesterday = today.subtract(Duration(days: 2));

    String todayString = 'day=${today.toIso8601String().split('T')[0]}';
    String yesterdayString = 'day=${yesterday.toIso8601String().split('T')[0]}';
    String dayBeforeYesterdayString =
        'day=${dayBeforeYesterday.toIso8601String().split('T')[0]}';

    return Row(
      children: [
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
                  _reportListController.QuaryController =
                  'day=${pickedDate.toIso8601String().split('T')[0]}';
                  selectedWeek = null;
                });
              }
            },
            isRequired: false,
          ),
        ),
        SizedBox(width: screenWidth * 0.05),
        DropdownButton<String>(
          hint: Text('Select',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
          value: selectedWeek,
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
              _reportListController.QuaryController = newValue!;
              selectedDate = null;
            });
          },
        ),
      ],
    );
  }

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
                    FontWeight.w400)),
            value: selectedMonth,
            items: months.map((String month) {
              return DropdownMenuItem<String>(
                value: month,
                child: Text(
                  month,
                  style: TextStyle(
                      fontSize: 15,
                      color: AppColors.blackColor),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedMonth = newValue;
                _updateDayRange();
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
                    FontWeight.w400)),
            value: selectedYear,
            items: years.map((String year) {
              return DropdownMenuItem<String>(
                value: year,
                child: Text(
                  year,
                  style: TextStyle(
                      fontSize: 15,
                      color: AppColors.blackColor),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedYear = newValue;
                _updateDayRange();
              });
            },
          ),
        ),
      ],
    );
  }

  void _updateDayRange() {
    if (selectedMonth != null && selectedYear != null) {
      int monthIndex =
          months.indexOf(selectedMonth!) + 1;
      String month = monthIndex.toString().padLeft(2, '0');
      String year = selectedYear!;

      DateTime firstDayOfMonth = DateTime(int.parse(year), monthIndex, 1);
      DateTime lastDayOfMonth =
      DateTime(int.parse(year), monthIndex + 1, 0);

      String startDate = '${year}-${month}-01';
      String endDate =
          '${year}-${month}-${lastDayOfMonth.day.toString().padLeft(2, '0')}';

      _reportListController.QuaryController = 'day_range=${startDate}_to_${endDate}';
    } else {
      _reportListController.QuaryController = "";
    }
  }

  void _fetchData(ReportListViewModel viewModel) {
    if ((searchByMonth && _reportListController.QuaryController == "") ||
        (!searchByMonth && _reportListController.QuaryController == "")) {
      Utils.showFlashMessage(
        context: context,
        message: 'Please select a query parameter',
        backgroundColor: Colors.red,
        icon: Icons.warning,
      );
      return;
    }

    Utils.showLoading(context);
    viewModel.fetchReport(_reportListController.QuaryController).then((_) {
      Utils.cancelLoading(context);
    });
  }

  void _toggleSearchByMonth(bool value) {
    setState(() {
      searchByMonth = value;
      _reportListController.QuaryController = '';
      selectedDate = null;
      selectedWeek = null;
    });
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
