import 'package:digital_queue/controllers/queue_controller.dart';
import 'package:digital_queue/services/queue_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchCourseWidget extends StatelessWidget {
  final QueueController controller;

  const SearchCourseWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller.findCourseTextController,
        autofocus: true,
        style: const TextStyle(
          color: Colors.indigo,
        ),
        decoration: const InputDecoration(
          labelText: "Search Course",
          prefixIcon: Icon(
            Icons.search,
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
      suggestionsCallback: (pattern) async {
        return await controller.findCourse(pattern);
      },
      itemBuilder: (context, Course suggestion) {
        return ListTile(
          textColor: Colors.indigo,
          iconColor: Colors.indigo,
          title: Text(
            suggestion.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text("${suggestion.year}"),
        );
      },
      onSuggestionSelected: (Course suggestion) {
        // your implementation here
        controller.selectCourse(suggestion);
      },
    );
  }
}
