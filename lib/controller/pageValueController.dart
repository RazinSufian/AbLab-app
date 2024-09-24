import 'package:get/get.dart';

class PageValueController extends GetxController {
  // Track the current page index as an observable integer
  var pageValue = 0.obs;

  // Make reportListPage an observable string
  var reportListPage = "0".obs;

  // Additional state properties if needed
  var isVisible = false.obs;

  // Use this method to update the page value
  void updatePageValue(int value) {
    pageValue.value = value;
  }

  // Method to update reportListPage
  void updateReportListPage(String value) {
    reportListPage.value = value; // update observable string
  }
}
