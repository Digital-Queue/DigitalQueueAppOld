import 'package:digital_queue/services/queue_service.dart';
import 'package:flutter/material.dart';

class QueueListWidget extends StatelessWidget {
  late final String course;
  late final List<QueueItem> items;

  QueueListWidget({
    Key? key,
    required this.course,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course),
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container();
        },
      ),
    );
  }
}
