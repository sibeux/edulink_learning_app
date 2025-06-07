import 'package:edulink_learning_app/controllers/auth_controller/jwt_controller.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/screens/onboarding/first_screen.dart';
import 'package:edulink_learning_app/screens/list_bar_screen/persistent_bar_screen.dart';
import 'package:edulink_learning_app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashHandler extends StatelessWidget {
  const SplashHandler({super.key});

  Future<Widget> _checkAuth() async {
    await Get.find<JwtController>().checkToken();
    final box = GetStorage();

    if (box.read('login') == true) {
      // Validasi token jika perlu (misalnya cek expiry)
      return PersistentBarScreen(
        actor: Get.find<UserProfileController>().userData[0].userActor,
      );
    } else {
      return const FirstScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return FutureBuilder<Widget>(
      future: _checkAuth(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Tampilkan splash Flutter (logo, loading)
          return SplashScreen();
        } else if (snapshot.hasData) {
          // Redirect ke screen sesuai hasil cek token
          return snapshot.data!;
        } else {
          // Optional: kalau ada error
          return const FirstScreen();
        }
      },
    );
  }
}
