import 'package:edulink_learning_app/controllers/auth_controller/jwt_controller.dart';
import 'package:edulink_learning_app/screens/onboarding/first_screen.dart';
import 'package:get/get.dart';

class LogoutController extends GetxController {
  var isLoggingOut = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLoggingOut.value = false;
  }

  Future<void> logout() async {
    isLoggingOut.value = true;
    final jwtController = Get.find<JwtController>();
    await jwtController.deleteToken();
    Get.offAll(() => FirstScreen(), transition: Transition.rightToLeftWithFade);
    isLoggingOut.value = false;
  }
}
