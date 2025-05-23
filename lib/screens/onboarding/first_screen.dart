import 'package:edulink_learning_app/controllers/chat_controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the first screen!'),
            ElevatedButton(
              onPressed: () {
                // Navigate to the second screen
                Get.put(ChatController()).sendMessage(message: "Hello from First Screen");
              },
              child: const Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
    );
  }
}