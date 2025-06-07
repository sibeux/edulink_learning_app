import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/widgets/account_information/container_user_data.dart';
import 'package:edulink_learning_app/widgets/account_information/courses_picker_account_info.dart';
import 'package:edulink_learning_app/widgets/account_information/gender_picker_account_info.dart';
import 'package:edulink_learning_app/widgets/complete_profile/form/birthday_picker/modal_birthday.dart';
import 'package:flutter/material.dart';

class ListileAccountEditing extends StatelessWidget {
  const ListileAccountEditing({
    super.key,
    required this.completeProfileController,
  });

  final CompleteProfileController completeProfileController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContainertileUserData(
          completeProfileController: completeProfileController,
          isHasInvalid: true,
          isImmutable: false,
          needEditing: true,
          formType: 'nameProfile',
          formtext: 'Full Name',
        ),
        ContainertileUserData(
          completeProfileController: completeProfileController,
          isHasInvalid: true,
          isImmutable: true,
          needEditing: true,
          formType: 'emailProfile',
          formtext: 'Email',
        ),
        ContainertileUserData(
          completeProfileController: completeProfileController,
          isHasInvalid: true,
          isImmutable: true,
          needEditing: true,
          formType: 'numberProfile',
          formtext: 'Phone Number',
        ),
        GenderPickerAccountInfo(
          controller: completeProfileController,
          needEditing: true,
        ),
        GestureDetector(
          onTap: () {
            birthdayPickModal(context, controller: completeProfileController);
          },
          child: AbsorbPointer(
            absorbing: true,
            child: ContainertileUserData(
              completeProfileController: completeProfileController,
              isHasInvalid: false,
              isImmutable: false,
              needEditing: true,
              formType: 'birthdayProfile',
              formtext: 'Birthday',
            ),
          ),
        ),
        ContainertileUserData(
          completeProfileController: completeProfileController,
          isHasInvalid: true,
          isImmutable: false,
          needEditing: true,
          formType: 'cityProfile',
          formtext: 'City',
        ),
        ContainertileUserData(
          completeProfileController: completeProfileController,
          isHasInvalid: false,
          isImmutable: false,
          needEditing: true,
          formType: 'countryProfile',
          formtext: 'Country',
        ),
        ContainertileUserData(
          completeProfileController: completeProfileController,
          isHasInvalid: false,
          isImmutable: false,
          needEditing: true,
          formType: 'addressProfile',
          formtext: 'Address Line',
        ),
        CoursesPickerAccountInfo(
          controller: completeProfileController,
          needEditing: true,
        ),
      ],
    );
  }
}
