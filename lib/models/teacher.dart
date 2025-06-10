import 'package:edulink_learning_app/models/teacher_availabilty.dart';

class Teacher {
  final String teacherId;
  final String? about;
  final String? skills;
  final double? price;
  final List<TeacherAvailabilty>? availability;

  Teacher({
    required this.teacherId,
    this.about,
    this.skills,
    this.price,
    this.availability,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      teacherId: json['teacher_id'].toString(),
      about: json['about'],
      skills: json['skills'],
      price:
          json['price'] != null
              ? double.tryParse(json['price'].toString())
              : null,
      availability:
          (json['availabilities'] as List<dynamic>?)
              ?.map((data) => TeacherAvailabilty.fromJson(data))
              .toList(),
    );
  }

}
