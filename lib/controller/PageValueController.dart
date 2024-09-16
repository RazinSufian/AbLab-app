import 'package:get/get.dart';

class PageValueController extends GetxController {
  // Track the current page index
  var pageValue = 0.obs; // Using Rx variable to allow reactivity

  // Additional state properties if needed
  var isVisible = false.obs;
  var addPhotoPageValue = 0.obs;
  var singlePhotoPageValue = 0.obs;
  var detailsOrConfirmOverview = 0.obs;
  var growthPageValue = 0.obs;
  var childButtonVisible = false.obs;
  var listCardColor = false.obs;
  var draftPageValue = 0.obs;

  // Optional: if you need a string ID or other properties
  var childUserId = "0".obs;

  // Use this method to update the page value
  void updatePageValue(int value) {
    pageValue.value = value;
  }
}
