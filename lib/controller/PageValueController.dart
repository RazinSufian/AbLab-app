import 'package:get/get.dart';

class PageValueController extends GetxController {
  // Track the current page index
  var pageValue = 0.obs; // Using Rx variable to allow reactivity
  String reportListPage= "0";


  // Additional state properties if needed
  var isVisible = false.obs;


  // Optional: if you need a string ID or other properties
  // var childUserId = "0".obs;

  // Use this method to update the page value
  void updatePageValue(int value) {
    pageValue.value = value;
  }
}
