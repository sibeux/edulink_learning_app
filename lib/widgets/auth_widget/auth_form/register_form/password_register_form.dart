import 'package:edulink_learning_app/widgets/auth_widget/auth_form/form_blueprint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/auth_controller/register_controller.dart';

class PasswordRegisterForm extends StatelessWidget {
  const PasswordRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBlueprint(
      authController: Get.find<RegisterController>(),
      formType: 'passwordRegister',
      formText: 'password',
      keyboardType: TextInputType.visiblePassword,
      autoFillHints: '',
    );
  }
}
