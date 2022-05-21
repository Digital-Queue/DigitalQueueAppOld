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
    required String requestId,
  }) async {
    final response = await send(
      path: "/courses/complete-queue-item",
      method: "POST",
      requireAuth: true,
      params: {
        "itemId": requestId,
      },
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
  QueueItem({required this.id, this.student});
}

class CourseQueue {
  late String course;
  late int total;
  late String type;
  List<QueueItem>? requests = List.empty();
  CourseQueue({
    required this.type,
    required this.course,
    required this.total,
    this.requests,
  });

  factory CourseQueue.fromJson(String type, Map<String, dynamic> data) {
    Iterable requests = data["requests"];
    return CourseQueue(
      type: type,
      course: data["course"],
      total: data["total"],
      requests: requests
          .map((e) => QueueItem(id: e["id"], student: e["student"]))
          .toList(),
    );
  }
}
