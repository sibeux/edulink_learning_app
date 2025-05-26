import 'dart:convert';

import 'package:edulink_learning_app/components/colorize_terminal.dart';
import 'package:edulink_learning_app/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html_unescape/html_unescape.dart';

import 'package:http/http.dart' as http;

class UserProfileController extends GetxController {
  var userData = RxList<User>([]);
  var isLoading = false.obs;
  var unescape = HtmlUnescape();
  var idUser = '';

  @override
  void onInit() async {
    super.onInit();
    await getUserData();
  }

  Future<void> getUserData() async {
    isLoading.value = true;
    final box = GetStorage();
    final email = box.read('email');

    final String url =
        'https://sibeux.my.id/project/edulink-php-jwt/api/user?method=get_user_data&email=$email';

    try {
      final response = await http.get(Uri.parse(url));

      final List<dynamic> listData = json.decode(response.body);

      if (listData.isNotEmpty) {
        final list =
            listData.map((user) {
              return User(
                userId: user['user_id'],
                emailuser: user['email'],
                passUser: user['password_hash'],
                nameUser: user['full_name'],
                userPhone: user['phone_number'],
                userPhoto: user['user_photo'] ?? '',
                userActor: user['user_actor'],
              );
            }).toList();

        idUser = list[0].userId;

        // await orderController.getOrderHistoryCount(idUser);

        userData.value = list;
      } else {
        userData.value = [];
      }
    } catch (e) {
      logError("error in userProfileController: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
