import 'dart:convert';

import 'package:edulink_learning_app/components/colorize_terminal.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/models/teacher.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';

var unescape = HtmlUnescape();

class ProfileTeacherController extends GetxController {
  RxBool isLoadingFetchData = false.obs;

  RxList<Teacher> teacherData = RxList<Teacher>([]);
  RxList<dynamic> availabilityData = RxList<dynamic>([]);

  @override
  void onInit() {
    super.onInit();
    final String teacherId =
        Get.find<UserProfileController>().userData[0].userId;
    fetchTeacherData(teacherId);
  }

  Future<void> fetchTeacherData(String teacherId) async {
    isLoadingFetchData.value = true;

    try {
      final url =
          'https://sibeux.my.id/project/edulink-php-jwt/api/teacher?method=get_teacher_data&teacher_id=$teacherId';

      final response = await GetConnect().get(url);

      if (response.status.hasError) {
        throw Exception('Failed to load teacher data');
      }

      final Map<String, dynamic> jsonData = json.decode(response.bodyString!);
      final teacher = Teacher.fromJson(jsonData);

      teacherData.value = [teacher];
      availabilityData.value = teacher.availability ?? [];

      logSuccess('Teacher data fetched successfully.');
    } catch (e) {
      logError("Error in fetchTeacherData: $e");
    } finally {
      isLoadingFetchData.value = false;
    }
  }
}
