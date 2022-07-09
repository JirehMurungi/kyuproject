import 'package:flutter/material.dart';
import 'package:kyuproject/theme/colors.dart';
import 'package:kyuproject/views/forms/data/forms_data.dart';

import 'form_textfield.dart';

class FormScreen {
  // name
  final String screenName;

  // color
  final Color screenColor;

  // form fields
  final List<FormTextField> screenFormFields;

  FormScreen({
    required this.screenName,
    required this.screenFormFields,
    required this.screenColor,
  });
}

// list of FormScreen
List<FormScreen> formScreens = [
  FormScreen(
    screenName: 'Student BioData',
    screenFormFields: studentFormFields,
    screenColor: kyuBlue,
  ),
  FormScreen(
    screenName: 'Course',
    screenFormFields: courseFormFields,
    screenColor: kyuPink,
  ),
  FormScreen(
    screenName: 'Schools Attended',
    screenFormFields: schoolFormFields,
    screenColor: kyuPurple,
  ),
];
