import 'package:get/get.dart';

class TeacherAvailabilty {
  final String? id;
  final String? teacherId;
  final String? availableDay;
  final String? startTime;
  final String? endTime;
  RxBool isAvailable;

  TeacherAvailabilty({
    this.id,
    this.teacherId,
    this.availableDay,
    this.startTime,
    this.endTime,
    bool isAvailable = false,
  }) : isAvailable = isAvailable.obs;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teacher_id': teacherId,
      'available_day': availableDay,
      'start_time': startTime,
      'end_time': endTime,
      'is_available': isAvailable.value,
    };
  }

  factory TeacherAvailabilty.fromJson(Map<String, dynamic> json) {
    return TeacherAvailabilty(
      id: json['id']?.toString(),
      availableDay: json['available_day']?.toString(),
      startTime: json['start_time']?.toString(),
      endTime: json['end_time']?.toString(),
      isAvailable: json['is_available'] == 'true' ? true : false,
    );
  }

  factory TeacherAvailabilty.fromMap(Map<String, dynamic> map) {
    return TeacherAvailabilty(
      id: map['id']?.toString(),
      teacherId: map['teacherId']?.toString(),
      availableDay: map['availableDay']?.toString(),
      startTime: map['startTime']?.toString(),
      endTime: map['endTime']?.toString(),
      isAvailable:
          map['isAvailable'] is bool
              ? map['isAvailable']
              : (map['isAvailable'] == 'true' ? true : false),
    );
  }
}
