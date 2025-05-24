import 'package:get/get.dart';

class OnboardingScreenController extends GetxController {
  var currentPageIndex = 0.obs;

  void nextPage() {
    currentPageIndex.value++;
  }

  void previousPage() {
    if (currentPageIndex > 0) {
      currentPageIndex.value--;
    }
  }
}
