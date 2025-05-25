import 'dart:convert';

import 'package:edulink_learning_app/components/colorize_terminal.dart';
import 'package:edulink_learning_app/controllers/auth_controller/jwt_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  // 0 = student, 1 = tutor
  var indexUserType = 0.obs;

  var isObscure = true.obs;
  var isLoading = false.obs;
  var isEmailRegistered = false.obs;
  var isPhoneRegistered = false.obs;
  var isRedirecting = false.obs;
  var isCheckboxChecked = false.obs;

  var currentType = ''.obs;

  var formData = RxMap({
    'emailRegister': {
      'text': '',
      'type': 'emailRegister',
      'controller': TextEditingController(),
    },
    'nameRegister': {
      'text': '',
      'type': 'nameRegister',
      'controller': TextEditingController(),
    },
    'passwordRegister': {
      'text': '',
      'type': 'passwordRegister',
      'controller': TextEditingController(),
    },
    'numberRegister': {
      'text': '',
      'type': 'numberRegister',
      'controller': TextEditingController(),
    },
  });

  @override
  void onInit() {
    super.onInit();
    isLoading.value = false;
    isEmailRegistered.value = false;
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

  void changeIndexUserType(int index) {
    indexUserType.value = index;
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

  bool getIsPhoneValid() {
    final phoneValue = formData['numberRegister']!['text'].toString();
    final phoneRegExp = RegExp(r'^(?:0)8[1-9][0-9]{6,15}$');

    return phoneRegExp.hasMatch(phoneValue) && phoneValue.isNotEmpty;
  }

  bool getIsPhoneEmpty() {
    final phoneValue = formData['numberRegister']!['text'].toString();
    return phoneValue.isEmpty;
  }

  bool getIsDataLoginValid() {
    final emailValue = formData['emailLogin']!['text'].toString();
    return EmailValidator.validate(emailValue) &&
        emailValue.isNotEmpty &&
        formData['passwordLogin']!['text'].toString().isNotEmpty;
  }

  bool getIsDataRegisterValid() {
    return formData['nameRegister']!['text'].toString().isNotEmpty &&
        formData['passwordRegister']!['text'].toString().isNotEmpty &&
        formData['numberRegister']!['text'].toString().isNotEmpty &&
        getIsEmailValid('emailRegister') &&
        !getIsNameValid() &&
        getIsPhoneValid();
  }

  bool getIsNameValid() {
    final nameValue = formData['nameRegister']!['text'].toString();
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

    return !nameRegExp.hasMatch(nameValue) && nameValue.isNotEmpty;
  }

  get isObscureValue => isObscure.value;

  Future<void> getCheckEmailPhone({
    required String email,
    required String phone,
  }) async {
    isLoading.value = true;

    const String url = 'https://sibeux.my.id/project/edulink-php-jwt/api/auth';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'method': 'email_phone_check', 'email': email, 'phone': phone},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        bool emailExists = jsonResponse['email_exists'] == 'true';
        bool phoneExists = jsonResponse['phone_exists'] == 'true';

        if (emailExists || phoneExists) {
          isEmailRegistered.value = emailExists;
          isPhoneRegistered.value = phoneExists;
          logError(
            'Email or Phone already registered. Email: $emailExists, Phone: $phoneExists',
          );
        } else {
          isEmailRegistered.value = false;
          isPhoneRegistered.value = false;
          logSuccess('Email & Phone is available for registration.');

          // createNewUserData(
          //   email: formData['emailRegister']!['text'].toString().trim(),
          //   name: formData['nameRegister']!['text'].toString().trim(),
          //   password: formData['passwordRegister']!['text'].toString(),
          //   phoneNumber: formData['numberRegister']!['text'].toString(),
          //   actor: indexUserType.value == 0 ? 'student' : 'tutor',
          // );
        }
      } else {
        logError('Failed checking. Error: ${response.body}');
      }
    } catch (e) {
      logError('error from getCheckEmailPhone: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createNewUserData({
    required String email,
    required String name,
    required String password,
    required String phoneNumber,
    required String actor,
  }) async {
    isLoading.value = true;

    const String url = 'https://sibeux.my.id/project/edulink-php-jwt/api/auth';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'method': 'create_user',
          'email': email,
          'full_name': name,
          'password': password,
          'phone_number': phoneNumber,
          'user_actor': actor,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        bool success = jsonResponse['status'] == 'success';

        if (success) {
          await generateJwtRegister(email: email, password: password);
        } else {
          logError('Failed registering. Error: ${response.body}');
        }
      } else {
        logError('Failed registering. Error: ${response.body}');
      }
    } catch (e) {
      logError('error from createNewUserData: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> generateJwtRegister({
    required String email,
    required String password,
  }) async {
    const String url = 'https://sibeux.my.id/project/edulink-php-jwt/login';
    final jwtController = Get.put(JwtController());
    // final userProfileController = Get.find<UserProfileController>();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        isRedirecting.value = true;
        final jsonResponse = jsonDecode(response.body);
        await jwtController.setToken(
          token: jsonResponse['token'],
          email: email,
        );
        logSuccess('register success: ${response.body}');
      } else {
        logError('Failed generating JWT. Error: ${response.statusCode}');
      }
    } catch (e) {
      logError('error from generateJwtRegister: $e');
    } finally {
      isLoading.value = false;
      isRedirecting.value = false;
    }
  }
}
