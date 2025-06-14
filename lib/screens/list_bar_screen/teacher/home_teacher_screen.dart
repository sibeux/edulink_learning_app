import 'package:edulink_learning_app/controllers/auth_controller/logout_controller.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTeacherScreen extends StatelessWidget {
  const HomeTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileController = Get.find<UserProfileController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Home Teacher Screen')),
      body: Center(
        child: Column(
          children: [
            Text(
              'Welcome to the Home Screen! ${userProfileController.userData.first.nameUser}',
            ),
            ElevatedButton(
              onPressed: () async {
                await Get.put(LogoutController()).logout();
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
