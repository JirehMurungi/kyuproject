import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'form_textfield.dart';

final _formKey = GlobalKey<FormState>();

class StudentForm extends StatelessWidget {
  const StudentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: ListView.builder(
        itemCount: studentFormFields.length,
        itemBuilder: (BuildContext context, int index) {
          // form feild
          final formField = studentFormFields[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  formField.label,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer(builder: (context, ref, _) {
                  final initialValue =
                      ref.watch(formField.formValueProvider.state).state;
                  return TextFormField(
                    initialValue: initialValue.toString(),
                   keyboardType: formField.keyboardType,
                    onChanged: (value) {
                      ref.read(formField.formValueProvider.notifier).state =
                          value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return formField.hint;
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text(formField.label),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
