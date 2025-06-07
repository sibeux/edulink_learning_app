import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/widgets/account_information/container_user_data.dart';
import 'package:edulink_learning_app/widgets/account_information/courses_picker_account_info.dart';
import 'package:edulink_learning_app/widgets/account_information/gender_picker_account_info.dart';
import 'package:flutter/material.dart';

class ListileInformation extends StatelessWidget {
  const ListileInformation({
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
          isHasInvalid: false,
          isImmutable: false,
          needEditing: false,
          formType: 'nameProfile',
          formtext: 'Full Name',
        ),
        ContainertileUserData(
          completeProfileController: completeProfileController,
          isHasInvalid: false,
          isImmutable: false,
          needEditing: false,
          formType: 'emailProfile',
          formtext: 'Email',
        ),
        ContainertileUserData(
          completeProfileController: completeProfileController,
          isHasInvalid: false,
          isImmutable: false,
          needEditing: false,
          formType: 'numberProfile',
          formtext: 'Phone Number',
        ),
        GenderPickerAccountInfo(
          controller: completeProfileController,
          needEditing: false,
        ),
        ContainertileUserData(
          completeProfileController: completeProfileController,
          isHasInvalid: false,
          isImmutable: false,
          needEditing: false,
          formType: 'birthdayProfile',
          formtext: 'Birthday',
        ),
        ContainertileUserData(
          completeProfileController: completeProfileController,
          isHasInvalid: false,
          isImmutable: false,
          needEditing: false,
          formType: 'cityProfile',
          formtext: 'City',
        ),
        ContainertileUserData(
          completeProfileController: completeProfileController,
          isHasInvalid: false,
          isImmutable: false,
          needEditing: false,
          formType: 'countryProfile',
          formtext: 'Country',
        ),
        ContainertileUserData(
          completeProfileController: completeProfileController,
          isHasInvalid: false,
          isImmutable: false,
          needEditing: false,
          formType: 'addressProfile',
          formtext: 'Address Line',
        ),
        CoursesPickerAccountInfo(
          controller: completeProfileController,
          needEditing: false,
        ),
      ],
    );
  }
}
