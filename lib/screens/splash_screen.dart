import 'package:edulink_learning_app/controllers/auth_controller/jwt_controller.dart';
import 'package:edulink_learning_app/screens/onboarding/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    initialization();
  }

  Future<void> initialization() async {
    await Get.find<JwtController>().checkToken();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return FirstScreen();
  }
}
