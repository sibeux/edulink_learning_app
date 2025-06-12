import 'dart:convert';

import 'package:edulink_learning_app/components/colorize_terminal.dart';
import 'package:edulink_learning_app/models/explore_mentor.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BookingController extends GetxController {
  var indexBookingType = 0.obs;
  var isLoadingFetchExploreMentors = false.obs;

  RxInt durationBooking = 1.obs;
  RxString dayBooking = ''.obs;
  RxString hourBooking = ''.obs;

  RxList<ExploreMentor> exploreMentorList = <ExploreMentor>[].obs;

  @override
  void onInit() {
    fetchExploreMentors();
    super.onInit();
  }

  void changeIndexBookingType(int index) {
    indexBookingType.value = index;
  }

  Future<void> fetchExploreMentors() async {
    isLoadingFetchExploreMentors.value = true;
    try {
      final response = await http.get(
        Uri.parse(
          'https://sibeux.my.id/project/edulink-php-jwt/api/teacher?method=get_explore_mentor',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty) {
          final list =
              data.map((mentor) {
                return ExploreMentor(
                  mentorId: mentor['teacher_id'],
                  name: mentor['full_name'],
                  uriPhoto: mentor['user_photo'],
                  price: mentor['price']?.toString() ?? '0',
                  schedule: mentor['schedule']?.toString() ?? '',
                );
              }).toList();

          exploreMentorList.value = list;
          logSuccess(
            'Successfully fetched mentors: ${exploreMentorList.length} mentors found',
          );
        } else {
          exploreMentorList.value = [];
        }
      } else {
        logError('Failed to fetch mentors: ${response.statusCode}');
      }
    } catch (e) {
      logError('Error fetching mentors: $e');
    } finally {
      isLoadingFetchExploreMentors.value = false;
    }
  }

  List<String> getAvailableDays(String schedule) {
    List<String> availableDays = [];

    // Pisahkan berdasarkan koma untuk dapatkan tiap hari
    List<String> dayEntries = schedule.split(',');

    for (var entry in dayEntries) {
      entry = entry.trim(); // Hilangkan spasi depan-belakang

      if (entry.contains('true')) {
        // Ambil nama hari sebelum jam (misal: "Saturday 09:00:00-17:00:00 true")
        String day = entry.split(' ')[0];
        availableDays.add(day);
      }
    }

    return availableDays;
  }
}
