import 'package:ab_lab_app/view/patient_entry_views/patient_entry.dart';
import 'package:ab_lab_app/view/report_list_viwes/report_list_view.dart';
import 'package:ab_lab_app/view/sales_views/sales_view.dart';
import 'package:ab_lab_app/view/setting_views/settings_view.dart';
import 'package:ab_lab_app/view/test_views/test_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pageValueController.dart';
import '../res/image_assets.dart';

class MenuView extends StatefulWidget {
  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  // Initialize PageValueController
  final PageValueController pageValueController = Get.put(PageValueController());

  // Initialize PageController
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: pageValueController.pageValue.value);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Pages to be displayed in PageView
  final List<Widget> _pages = [
    SalesPage(),
    ReportListPage(),
    TestsPage(),
    PatientEntryPage(),
    SettingsPage(),
  ];

  // Handle navigation tap
  void _onItemTapped(int index) {
    // Update the page value in the controller
    pageValueController.updatePageValue(index);
    pageValueController.isVisible.value = index == 2; // Example: set visibility flag for page 2
    // Navigate to the selected page
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(), // Prevents swipe navigation
        children: _pages,
        onPageChanged: (index) {
          // Update the page value whenever the page changes
          pageValueController.updatePageValue(index);
        },
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              ImageAssets.nav_sales,
              height: 24,
              width: 24,
            ),
            label: 'Sales',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImageAssets.nav_patient_list,
              height: 24,
              width: 24,
            ),
            label: 'Patient List',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImageAssets.nav_tests,
              height: 24,
              width: 24,
            ),
            label: 'Tests',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImageAssets.nav_patient_entry,
              height: 24,
              width: 24,
            ),
            label: 'Patient Entry',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImageAssets.nav_settings,
              height: 24,
              width: 24,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: pageValueController.pageValue.value,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue, // Customize the color as needed
        onTap: _onItemTapped,
        selectedLabelStyle: TextStyle(fontSize: 12), // Adjust the font size if needed
        unselectedLabelStyle: TextStyle(fontSize: 12), // Adjust the font size if needed
      )),
    );
  }
}

