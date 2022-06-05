class Course {
  late String id;
  late String title;
  late int year;

  Course({
    required this.id,
    required this.title,
    required this.year,
  });

  factory Course.fromJson(Map<String, dynamic> data) => Course(
        id: data["id"],
        title: data["title"],
        year: data["year"],
      );
}
