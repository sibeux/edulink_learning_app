import 'package:edulink_learning_app/widgets/auth_widget/auth_form/form_blueprint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/auth_controller/register_controller.dart';

class EmailRegisterForm extends StatelessWidget {
  const EmailRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBlueprint(
      authController: Get.find<RegisterController>(),
      formType: 'emailRegister',
      formText: 'email',
      keyboardType: TextInputType.emailAddress,
      autoFillHints: AutofillHints.email,
    );
  }
}
