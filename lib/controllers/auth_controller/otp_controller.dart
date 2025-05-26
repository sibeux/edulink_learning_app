import 'dart:convert';

import 'package:edulink_learning_app/components/colorize_terminal.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OtpController extends GetxController {
  var otpInput = "".obs;
  var isLoading = false.obs;
  var isOtpValid = true.obs;

  Future<void> sendOTP({required String email, required String name}) async {
    const String url = 'https://sibeux.my.id/project/edulink-php-jwt/api/otp';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'method': 'generate_otp', 'email': email, 'name': name},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success'] == true) {
          logInfo('Success. ${jsonResponse["message"]} $email');
        } else {
          logError('Failed to send OTP. Error: ${response.body}');
        }
      } else {
        logError('Failed sending OTP. Error: ${response.body}');
      }
    } catch (e) {
      logError('error from sendOTP: $e');
    }
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    isLoading.value = true;

    const String url = 'https://sibeux.my.id/project/edulink-php-jwt/api/otp';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'method': 'verify_otp', 'email': email, 'otp': otp},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == 'success') {
          logSuccess('OTP verified successfully.');
          isOtpValid.value = true;
          // Handle successful OTP verification
        } else {
          logError('Failed to verify OTP. Error: ${response.body}');
          isOtpValid.value = false;
        }
      } else {
        logError('Failed verifying OTP. Error: ${response.body}');
      }
    } catch (e) {
      logError('error from verifyOtp: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
