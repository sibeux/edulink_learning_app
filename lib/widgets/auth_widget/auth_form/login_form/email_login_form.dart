import 'package:edulink_learning_app/controllers/auth_controller/login_controller.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_form/form_blueprint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailLoginForm extends StatelessWidget {
  const EmailLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBlueprint(
      authController: Get.find<LoginController>(),
      formType: 'emailLogin',
      formText: 'email',
      keyboardType: TextInputType.emailAddress,
      autoFillHints: AutofillHints.email,
    );
  }
}
