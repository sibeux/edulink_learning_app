class TeacherAvailabilty {
  final String? id;
  final String? teacherId;
  final String? availableDate;
  final String? startTime;
  final String? endTime;

  TeacherAvailabilty({
    this.id,
    this.teacherId,
    this.availableDate,
    this.startTime,
    this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teacher_id': teacherId,
      'available_date': availableDate,
      'start_time': startTime,
      'end_time': endTime,
    };
  }

  factory TeacherAvailabilty.fromJson(Map<String, dynamic> json) {
    return TeacherAvailabilty(
      id: json['id']?.toString(),
      availableDate: json['available_date']?.toString(),
      startTime: json['start_time']?.toString(),
      endTime: json['end_time']?.toString(),
    );
  }
}
