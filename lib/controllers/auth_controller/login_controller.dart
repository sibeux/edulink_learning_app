import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
}
