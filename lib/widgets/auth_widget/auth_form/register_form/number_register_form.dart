import 'package:edulink_learning_app/controllers/auth_controller/register_controller.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_form/form_blueprint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberRegisterForm extends StatelessWidget {
  const NumberRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBlueprint(
      authController: Get.find<RegisterController>(),
      formType: 'numberRegister',
      formText: 'number',
      keyboardType: TextInputType.phone,
      autoFillHints: AutofillHints.telephoneNumber,
    );
  }
}
