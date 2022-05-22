import 'package:digital_queue/services/backend_service.dart';

class QueueService extends BackendService {
  Future<BackendResponse> search({required String query}) async {
    final response = await send(
      path: "/courses",
      method: "GET",
      requireAuth: true,
      params: {
        'q': query,
      },
    );

    if (response.error == true) {
      return BackendResponse(data: List.empty());
    }

    final list = response.data as Iterable;
    final courses = list.map((e) => Course.fromJson(e));

    return BackendResponse(data: courses.toList(growable: false));
  }

  Future<BackendResponse> getQueues() async {
    final response = await send(
      path: "/courses/get-queues",
      method: "GET",
      requireAuth: true,
    );

    if (response.error == true) {
      return BackendResponse(data: List<CourseQueue>.empty());
    }

    final sent = response.data["sent"] as Iterable;
    final received = response.data["received"] as Iterable;

    final queues = {
      "sent": sent.map((e) => CourseQueue.fromJson("sent", e)).toList(),
      "received":
          received.map((e) => CourseQueue.fromJson("received", e)).toList()
    };

    return BackendResponse(data: queues);
  }

  Future<BackendResponse> getCourseQueue(String courseId) async {
    final response = await send(
      path: "/courses/$courseId/queue",
      method: "GET",
      requireAuth: true,
    );

    if (response.error == true) {
      return BackendResponse(data: List<CourseQueue>.empty());
    }

    final list = response.data as Iterable;

    final queues = list.map((e) => QueueItem.fromJson(e)).toList();

    return BackendResponse(data: queues);
  }

  Future<BackendResponse> createQueueItem({required String courseId}) async {
    final response = await send(
        path: "/courses/create-queue-item",
        method: "POST",
        requireAuth: true,
        params: {
          "courseId": courseId,
        });

    return response;
  }

  Future<BackendResponse> completeQueueItem({
    required String courseId,
    required String itemId,
  }) async {
    final response = await send(
      path: "/courses/$courseId/queue/$itemId/complete",
      method: "PATCH",
      requireAuth: true,
    );

    return response;
  }
}

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

class QueueItem {
  late String id;
  late String? student;
  late String? createdAt;
  QueueItem({
    required this.id,
    this.student,
    this.createdAt,
  });
  factory QueueItem.fromJson(Map<String, dynamic> data) {
    return QueueItem(
      id: data["id"],
      student: data["student"],
      createdAt: data["createdAt"],
    );
  }
}

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
