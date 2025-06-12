import 'package:edulink_learning_app/models/teacher_availabilty.dart';

class Teacher {
  final String teacherId;
  final String? about;
  final String? skills;
  double? price;
  List<TeacherAvailabilty>? availability;

  Teacher({
    required this.teacherId,
    this.about,
    this.skills,
    this.price,
    this.availability,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      // For demonstration purposes, we are using a static about text.
      about: 'As an experienced tutor, I am dedicated to helping students achieve their academic potential. I have strong knowledge in the subject of Maths and extensive teaching experience at various levels of education.',
      skills: 'algebra,calculus,geometry,statistics,trigonometry',
      teacherId: json['teacher_id'].toString(),
      // about: json['about'],
      // skills: json['skills'],
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
