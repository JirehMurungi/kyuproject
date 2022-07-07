import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'form_textfield.dart';

final _formKey = GlobalKey<FormState>();

class SchoolsAttended extends StatelessWidget {
  const SchoolsAttended({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          ...List.generate(schoolFormFields.length, (index) {
            final formField = schoolFormFields[index];

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
          }),
        ],
      ),
    );
  }
}
