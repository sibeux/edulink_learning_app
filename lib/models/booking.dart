class Booking {
  final String bookingId;
  final String mentorId;
  final String mentorName;
  final String mentorPhoto;
  final String studentId;
  final String day;
  final String duration;
  final String time;
  final String price;
  String status;

  Booking(
    {
    required this.bookingId,
    required this.mentorId,
    required this.mentorName,
    required this.mentorPhoto,
    required this.studentId,
    required this.day,
    required this.duration,
    required this.time,
    required this.price,
    required this.status,
  });
}
