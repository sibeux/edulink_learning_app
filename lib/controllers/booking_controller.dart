import 'dart:convert';

import 'package:edulink_learning_app/components/colorize_terminal.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/models/booking.dart';
import 'package:edulink_learning_app/models/explore_mentor.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BookingController extends GetxController {
  var indexBookingType = 0.obs;
  var isLoadingFetchExploreMentors = false.obs;
  var isLoadingSendBooking = false.obs;

  RxInt durationBooking = 1.obs;
  RxString dayBooking = ''.obs;
  RxString hourBooking = ''.obs;

  RxList<ExploreMentor> exploreMentorList = <ExploreMentor>[].obs;
  RxList<Booking> bookingList = <Booking>[].obs;

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

  Future<void> createBooking({required ExploreMentor mentor}) async {
    isLoadingSendBooking.value = true;

    const String url = 'https://sibeux.my.id/project/edulink-php-jwt/api/booking';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'method': 'create_booking',
          'teacher_id': mentor.mentorId,
          'student_id': Get.find<UserProfileController>().idUser,
          'booking_day': dayBooking.value,
          'booking_duration': durationBooking.value.toString(),
          'booking_time': hourBooking.value,
          'booking_price': (durationBooking.value *
                  (int.tryParse(mentor.price ?? '0') ?? 0))
              .toString(),
        },
      );

      if (response.body.isEmpty) {
        logError('Error Send Data: Response Body is Empty');
        return;
      }

      final data = json.decode(response.body);

      if (data['status'] == 'success') {
        logSuccess('Success Send Data: ${data['status']}');
        // readCart();
      } else {
        logError('Error Send Data: ${data['error']}');
      }
    } catch (e) {
      logError('Error creating booking: $e');
    } finally {
      isLoadingSendBooking.value = false;
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
