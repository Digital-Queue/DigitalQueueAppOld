import 'package:digital_queue/queues/models/queue_item.dart';

class CourseQueue {
  late String course;
  late String courseId;
  late int total;
  late String type;
  List<QueueItem>? requests = List.empty();
  CourseQueue({
    required this.type,
    required this.course,
    required this.courseId,
    required this.total,
    this.requests,
  });

  factory CourseQueue.fromJson(String type, Map<String, dynamic> data) {
    return CourseQueue(
      type: type,
      course: data["course"],
      courseId: data["courseId"],
      total: data["total"],
    );
  }
}
