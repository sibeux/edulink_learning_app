class Booking {
  final String bookingId;
  final String mentorId;
  final String studentId;
  final String day;
  final int duration;
  final String time;
  String status;

  Booking(
    this.status, {
    required this.bookingId,
    required this.mentorId,
    required this.studentId,
    required this.day,
    required this.duration,
    required this.time,
  });
}
