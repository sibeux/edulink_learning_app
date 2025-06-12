class ExploreMentor {
  final String mentorId;
  final String name;
  final String? uriPhoto;
  final String? price;
  final String? schedule;

  ExploreMentor({
    required this.mentorId,
    required this.name,
    this.schedule,
    this.uriPhoto,
    this.price,
  });
}
