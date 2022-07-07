import 'package:flutter/material.dart';

import 'course_form.dart';
import 'schools_attended_form.dart';
import 'student_form.dart';

class FormScreen {
  // name
  final String screenName;

  // widget
  final Widget screenWidget;
  FormScreen({
    required this.screenName,
    required this.screenWidget,
  });
}

// list of FormScreen
List<FormScreen> formScreens = [
  FormScreen(
    screenName: 'Student BioData',
    screenWidget: const StudentForm(),
  ),
  FormScreen(
    screenName: 'Course',
    screenWidget: const CourseForm(),
  ),
  FormScreen(
    screenName: 'Schools Attended',
    screenWidget: const SchoolsAttended(),
  ),
];
