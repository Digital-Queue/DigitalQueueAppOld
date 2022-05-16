import 'package:digital_queue/services/backend_service.dart';

class CoursesService extends BackendService {
  Future<BackendResponse> search({required String query}) async {
    final accessToken = await cache.read(key: 'user_access_token');
    final response = await send(
      path: "/courses?q=$query",
      method: "GET",
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.error == true) {
      return BackendResponse(data: List.empty());
    }

    final list = response.data as Iterable;
    final courses = list.map((e) => Course.fromJson(e));

    return BackendResponse(data: courses.toList(growable: false));
  }

  Future<BackendResponse> createQueueItem({
    required String courseId,
    required String accessToken,
  }) async {
    final response = await send(
      path: "/courses/create-request",
      method: "POST",
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );

    return response;
  }

  Future<BackendResponse> completeQueueItem({
    required String courseId,
    required String requestId,
    required String accessToken,
  }) async {
    final response = await send(
      path: "/courses/complete-request",
      method: "POST",
      headers: {
        "Authorization": "Bearer $accessToken",
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
