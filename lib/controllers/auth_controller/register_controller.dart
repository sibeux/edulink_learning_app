import 'dart:convert';

import 'package:edulink_learning_app/controllers/auth_controller/jwt_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  // 0 = student, 1 = tutor
  var indexUserType = 0.obs;

  var isObscure = true.obs;
  var isLoading = false.obs;
  var isEmailRegistered = false.obs;
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

  bool getIsDataLoginValid() {
    final emailValue = formData['emailLogin']!['text'].toString();
    return EmailValidator.validate(emailValue) &&
        emailValue.isNotEmpty &&
        formData['passwordLogin']!['text'].toString().isNotEmpty;
  }

  bool getIsDataRegisterValid() {
    return formData['nameRegister']!['text'].toString().isNotEmpty &&
        formData['passwordRegister']!['text'].toString().isNotEmpty;
  }

  bool getIsNameValid() {
    final nameValue = formData['nameRegister']!['text'].toString();
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

    return !nameRegExp.hasMatch(nameValue) && nameValue.isNotEmpty;
  }

  get isObscureValue => isObscure.value;

  Future<void> getCheckEmail({required String email}) async {
    isLoading.value = true;

    const String url = 'https://sibeux.my.id/project/edulink-php-jwt/api/auth';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'method': 'email_check', 'email': email},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        bool emailExists = jsonResponse['email_exists'] == 'true';

        if (emailExists) {
          isEmailRegistered.value = true;
        } else {
          isEmailRegistered.value = false;
          if (kDebugMode) {
            print('Email is available for registration.');
          }

          createNewUserData(
            email: formData['emailRegister']!['text'].toString().trim(),
            name: formData['nameRegister']!['text'].toString().trim(),
            password: formData['passwordRegister']!['text'].toString(),
            phoneNumber: formData['numberRegister']!['text'].toString(),
            actor: indexUserType.value == 0 ? 'student' : 'tutor',
          );
        }
      } else {
        if (kDebugMode) {
          print('Failed checking. Error: ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('error: $e');
      }
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
          if (kDebugMode) {
            print('Failed registering. Error: ${response.body}');
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed registering. Error: ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('error: $e');
      }
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
        if (kDebugMode) {
          print('register success');
        }
      } else {
        if (kDebugMode) {
          print('Failed generating JWT. Error: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('error: $e');
      }
    } finally {
      isLoading.value = false;
      isRedirecting.value = false;
    }
  }
}
