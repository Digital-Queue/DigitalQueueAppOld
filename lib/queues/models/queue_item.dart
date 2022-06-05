class QueueItem {
  late String id;
  late String? student;
  late String? createdAt;
  late bool me;
  QueueItem({
    required this.id,
    this.student,
    this.createdAt,
    this.me = false,
  });
  factory QueueItem.fromJson(Map<String, dynamic> data) {
    return QueueItem(
      id: data["id"],
      student: data["student"],
      createdAt: data["createdAt"],
      me: data["me"],
    );
  }
}
