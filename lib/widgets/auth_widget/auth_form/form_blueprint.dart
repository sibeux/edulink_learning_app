import 'package:edulink_learning_app/controllers/auth_controller/login_controller.dart';
import 'package:edulink_learning_app/controllers/auth_controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../components/color_palette.dart';

class FormBlueprint extends StatelessWidget {
  const FormBlueprint({
    super.key,
    required this.formType,
    required this.keyboardType,
    required this.formText,
    required this.autoFillHints,
    required this.authController,
  });

  final String formType, formText, autoFillHints;
  final TextInputType keyboardType;
  final dynamic authController;

  @override
  Widget build(BuildContext context) {
    final controller = authController.formData[formType]?['controller'];
    return Obx(
      () => Padding(
        padding: EdgeInsets.zero,
        child: TextFormField(
          controller: controller as TextEditingController?,
          cursorColor: HexColor('#575757'),
          textAlignVertical: TextAlignVertical.center,
          enableSuggestions: true,
          autofillHints: [autoFillHints],
          keyboardType: keyboardType,
          obscureText:
              formType.toLowerCase().contains('password')
                  ? authController.isObscureValue
                  : false,
          onChanged: (value) {
            authController.onChanged(value, formType);
          },
          onTap: () {
            authController.onTap(formType, true);
          },
          onTapOutside: (event) {
            authController.onTap(formType, false);
            FocusManager.instance.primaryFocus?.unfocus();
          },
          style: TextStyle(
            color: HexColor('#1A1A1A'),
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            suffixIcon:
                formType.toLowerCase().contains('password')
                    ? Obx(
                      () =>
                          authController.isObscureValue == false
                              ? GestureDetector(
                                onTap: () {
                                  authController.toggleObscure();
                                },
                                child: Icon(
                                  Icons.visibility_off,
                                  color: ColorPalette().primary,
                                ),
                              )
                              : GestureDetector(
                                onTap: () {
                                  authController.toggleObscure();
                                },
                                child: Icon(
                                  Icons.visibility,
                                  color: ColorPalette().primary,
                                ),
                              ),
                    )
                    : null,
            isDense: true,
            fillColor: Colors.white,
            suffixIconConstraints: BoxConstraints(
              minWidth: 40.w,
              // minHeight: 45.h,
            ),
            enabledBorder: underlineInputBorder(authController, formType),
            focusedBorder: underlineInputBorder(authController, formType),
          ),
        ),
      ),
    );
  }
}

UnderlineInputBorder underlineInputBorder(
  dynamic authController,
  String formType,
) {
  final textValue = authController.formData[formType]?['text'].toString();
  final isCurrentType = authController.currentType.value == formType;

  bool isEmailNotValid = false;
  bool isPhoneNotValid = false;
  bool isCannotLogin = false;
  if (formType.toLowerCase().contains('login')) {
    final loginController = Get.find<LoginController>();
    isEmailNotValid =
        (!authController.getIsEmailValid(formType) && textValue!.isNotEmpty) ||
        (formType.toLowerCase().contains('login') &&
            !loginController.isLoginSuccess.value);
    isCannotLogin = !loginController.isLoginSuccess.value;
  } else {
    final registerController = Get.find<RegisterController>();
    isEmailNotValid =
        (!authController.getIsEmailValid(formType) && textValue!.isNotEmpty) ||
        registerController.isEmailRegistered.value;
    isPhoneNotValid =
        (!registerController.getIsPhoneValid() && textValue!.isNotEmpty) ||
        registerController.isPhoneRegistered.value;
  }

  return UnderlineInputBorder(
    borderSide: BorderSide(
      color:
          // Cek apakah yang diklik adalah form saat ini atau form tidak kosong.
          (isCurrentType || textValue!.isNotEmpty)
              // Cek apakah form saat ini adalah email
              ? formType.toLowerCase().contains('email')
                  // Cek apakah email tidak valid
                  ? isEmailNotValid
                      ? HexColor('#ff0000').withValues(alpha: 0.5)
                      : ColorPalette().primary.withValues(alpha: 0.5)
                  // Cek apakah form saat ini adalah full name
                  : formType.toLowerCase().contains('name')
                  // Cek apakah full name valid dan tidak kosong
                  ? authController.getIsNameValid() && textValue!.isNotEmpty
                      ? HexColor('#ff0000').withValues(alpha: 0.5)
                      : ColorPalette().primary.withValues(alpha: 0.5)
                  // Cek apakah form saat ini adalah dari login dan login tidak berhasil
                  : formType.toLowerCase().contains('number')
                  ? isPhoneNotValid
                      ? HexColor('#ff0000').withValues(alpha: 0.5)
                      : ColorPalette().primary.withValues(alpha: 0.5)
                  : isCannotLogin
                  ? HexColor('#ff0000').withValues(alpha: 0.5)
                  : ColorPalette().primary.withValues(alpha: 0.5)
              : HexColor('#BABABA').withValues(alpha: 0.93),
      width: 2.w,
    ),
  );
}
