import 'package:edulink_learning_app/widgets/complete_profile/form/birthday_picker/birtday_picker.dart';
import 'package:flutter/material.dart';

class ContentModal extends StatelessWidget {
  const ContentModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [BirthdayPicker()],
      ),
    );
  }
}
