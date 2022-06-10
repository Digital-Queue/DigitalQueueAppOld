import 'package:digital_queue/queues/models/course.dart';
import 'package:digital_queue/queues/models/course_queue.dart';
import 'package:digital_queue/queues/models/queue_item.dart';
import 'package:digital_queue/queues/models/queue_type.dart';
import 'package:digital_queue/shared/services/backend_service.dart';
import 'package:digital_queue/shared/services/cache_service.dart';
import 'package:digital_queue/users/models/result.dart';

class QueueService extends BackendService {
  QueueService({required CacheService cacheService})
      : super(cacheService: cacheService);

  Future<Result<List<Course>>> search({required String query}) async {
    final response = await send(
      path: "/courses",
      method: "GET",
      requireAuth: true,
      params: {
        'q': query,
      },
    );

    if (response.error == true) {
      return Result.error(message: response.message);
    }

    final list = response.data as Iterable;
    final courses = list.map((e) => Course.fromJson(e));

    return Result.ok(data: courses.toList(growable: false));
  }

  Future<Result<Map<String, List<CourseQueue>>>> getQueues() async {
    final response = await send(
      path: "/courses/get-queues",
      method: "GET",
      requireAuth: true,
    );

    if (response.error == true) {
      return Result.error(
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

    return Result.ok(data: queues);
  }

  Future<Result<List<QueueItem>>> getCourseQueue(
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
      return Result.error(message: response.message);
    }

    final list = response.data as Iterable;

    final queues = list.map((e) => QueueItem.fromJson(e)).toList();

    return Result.ok(data: queues);
  }

  Future<Result> createQueueItem({required String courseId}) async {
    final response = await send(
      path: "/courses/$courseId/queue/create",
      method: "POST",
      requireAuth: true,
    );

    if (response.error == true) {
      return Result.error(message: response.message ?? "Something went wrong");
    }

    return Result.ok();
  }

  Future<Result> completeQueueItem({
    required String courseId,
    required String itemId,
  }) async {
    final response = await send(
      path: "/courses/$courseId/queue/$itemId/complete",
      method: "PATCH",
      requireAuth: true,
    );

    if (response.error == true) {
      return Result.error(message: response.message ?? "Something went wrong");
    }

    return Result.ok();
  }
}
