import 'dart:convert';

import 'package:edulink_learning_app/components/colorize_terminal.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/models/teacher.dart';
import 'package:edulink_learning_app/models/teacher_availabilty.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;

var unescape = HtmlUnescape();

class ProfileTeacherController extends GetxController {
  RxBool isLoadingFetchData = false.obs;
  RxBool isLoadingUpdateData = false.obs;
  RxBool updateRefreshSetAvailableDay = false.obs;

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
        Get.back();
        throw Exception('Failed to load teacher data');
      }

      final Map<String, dynamic> jsonData = json.decode(response.bodyString!);
      final teacher = Teacher.fromJson(jsonData);

      teacherData.value = [teacher];
      availabilityData.value = _generateFullAvailability(teacher.availability);

      teacherData[0].availability =
          availabilityData
              .map(
                (item) => TeacherAvailabilty(
                  id: item['id'],
                  teacherId: item['teacherId'],
                  availableDay: item['availableDay'],
                  startTime: item['startTime'],
                  endTime: item['endTime'],
                  isAvailable: item['isAvailable'],
                ),
              )
              .toList();

      logSuccess('Teacher data fetched successfully.');
    } catch (e) {
      logError("Error in fetchTeacherData: $e");
      if (e is Error) {
        logError('Stack trace: ${e.stackTrace}');
      }
    } finally {
      isLoadingFetchData.value = false;
    }
  }

  Future<void> updateTeacherProfile() async {
    isLoadingUpdateData.value = true;
    try {
      final url = 'https://sibeux.my.id/project/edulink-php-jwt/api/teacher';

      final body = {
        'method': 'update_teacher_profile',
        'teacher_id': Get.find<UserProfileController>().idUser,
        'availability': availabilityData.toList(),
        'price': teacherData[0].price,
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == 'success') {
          logSuccess(
            'Teacher availability updated successfully. respnse: $result',
          );
        } else {
          throw Exception(result['message'] ?? 'Unknown error from server');
        }
      } else {
        throw Exception('HTTP error ${response.statusCode}');
      }
    } catch (e) {
      logError("Error in updateTeacherAvailability: $e");
      if (e is Error) {
        logError('Stack trace: ${e.stackTrace}');
      }
    } finally {
      isLoadingUpdateData.value = false;
    }
  }

  // Helper function
  List<Map<String, dynamic>> _generateFullAvailability(
    List<TeacherAvailabilty>? availability,
  ) {
    final List<String> allDays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final defaultTime = {'start': '09:00', 'end': '17:00'};

    // Jika kosong, isi semua hari dengan default
    if (availability == null || availability.isEmpty) {
      return allDays
          .map(
            (day) => {
              'id': "",
              'availableDay': day,
              'teacherId': Get.find<UserProfileController>().idUser,
              'startTime': defaultTime['start'],
              'endTime': defaultTime['end'],
              'isAvailable': false, // Default tidak tersedia
            },
          )
          .toList();
    }

    // Map hari yang sudah ada
    final Map<String, dynamic> existing = {
      for (var item in availability)
        if (item.availableDay != null)
          item.availableDay!: {
            'id': item.id,
            'teacherId': Get.find<UserProfileController>().idUser,
            'availableDay': item.availableDay,
            'startTime': item.startTime,
            'endTime': item.endTime,
            'isAvailable': item.isAvailable.value ? 'true' : 'false',
          },
    };

    // Gabungkan hari yang belum ada dengan default
    return allDays.map<Map<String, dynamic>>((day) {
      if (existing.containsKey(day)) {
        // Ini digunakan untuk mengupdate data yang sudah ada.
        return {
          'id': existing[day]['id'] ?? '',
          'teacherId': Get.find<UserProfileController>().idUser,
          'availableDay': day,
          'startTime': existing[day]['startTime'] ?? defaultTime['start'],
          'endTime': existing[day]['endTime'] ?? defaultTime['end'],
          'isAvailable': existing[day]['isAvailable'] == 'true',
        };
      } else {
        return {
          'id': '',
          'teacherId':
              Get.find<UserProfileController>()
                  .idUser, // ID guru bisa diisi nanti
          'availableDay': day,
          'startTime': defaultTime['start'],
          'endTime': defaultTime['end'],
          'isAvailable': false, // Default tidak tersedia
        };
      }
    }).toList();
  }

  void toggleSetAvailableDay(String day, bool value) {
    int index = availabilityData.indexWhere(
      (item) => item['availableDay'] == day,
    );
    if (index != -1) {
      // Update isAvailable pada hari tersebut
      availabilityData[index]['isAvailable'] = value;

      teacherData[0].availability![index].isAvailable.value = value;
      teacherData[0].availability![index].teacherId =
          Get.find<UserProfileController>().idUser;
      // Trigger update RxList
      availabilityData.refresh();
    }
    updateRefreshSetAvailableDay.value = !updateRefreshSetAvailableDay.value;
  }
}
