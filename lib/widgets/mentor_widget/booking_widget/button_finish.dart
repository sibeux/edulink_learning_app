import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/booking_controller.dart';
import 'package:edulink_learning_app/models/booking.dart';
import 'package:edulink_learning_app/widgets/auth_widget/auth_button/auth_button.dart';
import 'package:flutter/material.dart';

class ButtonFinishBooking extends StatelessWidget {
  const ButtonFinishBooking({
    super.key,
    required this.booking,
    required this.bookingController,
  });

  final Booking booking;
  final BookingController bookingController;

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'finishBooking',
      buttonText: 'Finish',
      foreground: Colors.white,
      background: ColorPalette().primary,
      isEnable: true,
      onPressed: () async {
        await bookingController.updateBookingStatus(
          bookingId: booking.bookingId,
        );
      },
    );
  }
}
