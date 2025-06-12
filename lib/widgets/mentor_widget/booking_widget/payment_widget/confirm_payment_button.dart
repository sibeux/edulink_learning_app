import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/booking_controller.dart';
import 'package:edulink_learning_app/models/explore_mentor.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:flutter/material.dart';

class ConfirmPaymentButton extends StatelessWidget {
  const ConfirmPaymentButton({super.key, required this.mentor, required this.bookingController});

  final ExploreMentor mentor;
  final BookingController bookingController;

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'confirmPayment',
      buttonText: 'Confirm',
      foreground: Colors.white,
      background: ColorPalette().primary,
      isEnable: true,
      onPressed: () async {
        await bookingController.createBooking(
          mentor: mentor,
        );
      },
    );
  }
}
