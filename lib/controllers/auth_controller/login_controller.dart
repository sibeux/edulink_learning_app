import 'dart:convert';

import 'package:edulink_learning_app/components/colorize_terminal.dart';
import 'package:edulink_learning_app/controllers/auth_controller/jwt_controller.dart';
import 'package:edulink_learning_app/screens/home_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  // 0 = student, 1 = tutor
  var indexUserType = 0.obs;

  var isLoading = false.obs;
  var isLoginSuccess = true.obs;
  var isRedirecting = false.obs;
  var isObscure = true.obs;

  var currentType = ''.obs;

  var formData = RxMap({
    'emailLogin': {
      'text': '',
      'type': 'emailLogin',
      'controller': TextEditingController(),
    },
    'passwordLogin': {
      'text': '',
      'type': 'passwordLogin',
      'controller': TextEditingController(),
    },
  });

  @override
  void onInit() {
    super.onInit();
    isLoading.value = false;
    isLoginSuccess.value = true;
    isRedirecting.value = false;
  }

  void onChanged(String value, String type) {
    final currentController = formData[type]?['controller'];
    // Memperbarui referensi map
    formData[type] = {
      'text': value,
      'type': type,
      'controller': currentController!,
    };
    update();
  }

  void onTap(String type, bool isFocus) {
    final currentController = formData[type]?['controller'];
    final currentText = formData[type]?['text'];
    formData[type] = {
      'text': currentText!,
      'type': type,
      'controller': currentController!,
    };
    currentType.value = isFocus ? type : '';
    update();
  }

  void onClearController(String type) {
    final currentController =
        formData[type]?['controller'] as TextEditingController;
    currentController.clear();
    formData[type] = {
      'text': '',
      'type': type,
      'controller': currentController,
    };
    update();
  }

  void toggleObscure() {
    isObscure.value = !isObscure.value;
    update();
  }

  bool getIsEmailValid(String type) {
    final emailValue = formData[type]!['text'].toString();
    return EmailValidator.validate(emailValue);
  }

  bool getIsDataLoginValid() {
    final emailValue = formData['emailLogin']!['text'].toString();
    return EmailValidator.validate(emailValue) &&
        emailValue.isNotEmpty &&
        formData['passwordLogin']!['text'].toString().isNotEmpty;
  }

  void changeIndexUserType(int index) {
    indexUserType.value = index;
  }

  get isObscureValue => isObscure.value;

  Future<void> generateJwtLogin({
    required String email,
    required String password,
    required String actor, // 'student' or 'tutor'
  }) async {
    isLoading.value = true;

    final jwtController = Get.find<JwtController>();
    const String url = 'https://sibeux.my.id/project/edulink-php-jwt/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'email': email, 'password': password, 'user_actor': actor},
      );

      if (response.statusCode == 200) {
        isLoginSuccess.value = true;
        isLoading.value = false;
        isRedirecting.value = true;
        final jsonResponse = jsonDecode(response.body);
        await jwtController.setToken(
          token: jsonResponse['token'],
          email: email,
        );
        logSuccess('Login successful, token: ${response.body}');
        Get.offAll(
          () => const HomeScreen(),
          transition: Transition.rightToLeftWithFade,
        );
      } else {
        isLoginSuccess.value = false;

        logError('Login failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      logError('error from generateJwtLogin: $e');
    } finally {
      isLoading.value = false;
      isRedirecting.value = false;
    }
  }
}
