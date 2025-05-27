import 'dart:convert';

import 'package:edulink_learning_app/components/colorize_terminal.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

AndroidOptions _getAndroidOptions() =>
    const AndroidOptions(encryptedSharedPreferences: true);

class JwtController extends GetxController {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  final box = GetStorage();

  Future<void> checkToken() async {
    final token = await storage.read(key: 'token');
    if (token != null) {
      logInfo('Token found: $token');
      await sendTokenToServer(token);
    } else {
      await deleteToken();
      logInfo('No token found, user is not logged in.');
    }
  }

  Future<void> setToken({required String token, email}) async {
    await storage.write(key: 'token', value: token);
    box.write('email', email);
    await Get.find<UserProfileController>().getUserData();

    box.write('login', true);
    logSuccess('Token set successfully.');
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
    box.write('login', false);
    box.remove('email');
  }

  Future<void> sendTokenToServer(String token) async {
    final url = Uri.parse(
      'https://sibeux.my.id/project/edulink-php-jwt/verify',
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        // Cek apakah token valid dan tidak expired
        if ((jsonResponse['login'] == 'sukses') &&
            (jsonResponse['exp'] == 'no')) {
          logSuccess('Token is valid and not expired.');
          final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
          final email = decodedToken['data']['email'];
          await setToken(token: token, email: email);
        } else {
          await deleteToken();
          logError('Token verification failed: ${jsonResponse.toString()}');
        }
      }
    } catch (e) {
      await deleteToken();
      logError('Error occurred while sending token: $e');
    }
  }
}
