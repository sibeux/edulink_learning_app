import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/widgets/account_information/container_user_data.dart';
import 'package:edulink_learning_app/widgets/account_information/courses_picker_account_info.dart';
import 'package:edulink_learning_app/widgets/account_information/gender_picker_account_info.dart';
import 'package:edulink_learning_app/widgets/complete_profile/form/birthday_picker/modal_birthday.dart';
import 'package:edulink_learning_app/widgets/complete_profile/form/education_pick.dart';
import 'package:flutter/material.dart';

class ListileAccountEditing extends StatelessWidget {
  const ListileAccountEditing({
    super.key,
    required this.completeProfileController, required this.actor,
  });

  final CompleteProfileController completeProfileController;
  final String actor;

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
        AbsorbPointer(
          child: ContainertileUserData(
            completeProfileController: completeProfileController,
            isHasInvalid: true,
            isImmutable: true,
            needEditing: true,
            formType: 'emailProfile',
            formtext: 'Email',
          ),
        ),
        AbsorbPointer(
          child: ContainertileUserData(
            completeProfileController: completeProfileController,
            isHasInvalid: true,
            isImmutable: true,
            needEditing: true,
            formType: 'numberProfile',
            formtext: 'Phone Number',
          ),
        ),
        GenderPickerAccountInfo(
          controller: completeProfileController,
          needEditing: true,
        ),
        if (actor == 'student')
        EducationPick(controller: completeProfileController),
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
          completeProfileController: completeProfileController,
          needEditing: true,
          isHasInvalid: true,
        ),
      ],
    );
  }
}
