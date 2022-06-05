import 'package:digital_queue/queues/models/course.dart';
import 'package:digital_queue/queues/models/course_queue.dart';
import 'package:digital_queue/queues/models/queue_item.dart';
import 'package:digital_queue/queues/models/queue_type.dart';
import 'package:digital_queue/shared/services/backend_service.dart';

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
      return BackendResponse(
        data: List<CourseQueue>.empty(),
        error: true,
        message: response.message,
      );
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

  Future<BackendResponse> getCourseQueue(
      String courseId, QueueType type) async {
    final response = await send(
      path: "/courses/$courseId/queue",
      method: "GET",
      params: {
        "received": type == QueueType.received ? true : false,
      },
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
      path: "/courses/$courseId/queue/create",
      method: "POST",
      requireAuth: true,
    );

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
