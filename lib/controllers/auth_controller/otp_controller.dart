import 'dart:convert';

import 'package:edulink_learning_app/components/colorize_terminal.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OtpController extends GetxController{
  
void sendOTP({required String email, required String name}) async {
    const String url = 'https://sibeux.my.id/project/edulink-php-jwt/api/otp';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'method': 'send_otp', 'email': email, 'name': name},
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
}


