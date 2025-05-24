import 'package:edulink_learning_app/widgets/auth_widget/auth_form/form_blueprint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/auth_controller/register_controller.dart';

class NameRegisterForm extends StatelessWidget {
  const NameRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBlueprint(
      authController: Get.find<RegisterController>(),
      formType: 'nameRegister',
      formText: 'nama lengkap',
      keyboardType: TextInputType.text,
      autoFillHints: AutofillHints.name,
    );
  }
}
