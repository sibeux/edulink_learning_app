import 'package:edulink_learning_app/controllers/auth_controller/logout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'User Profile Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
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