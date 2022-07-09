import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormTextField {
  // label
  final String label;

  // hint
  final String hint;

  // validator
  final FormFieldValidator<String> validator;

  // formValueProvider
  final StateProvider formValueProvider;

  // keyboard
  final TextInputType? keyboardType;

  FormTextField({
    required this.label,
    required this.hint,
    required this.validator,
    required this.formValueProvider,
    this.keyboardType = TextInputType.text,
  });
}
