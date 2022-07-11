// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../theme/colors.dart';
import 'data/exporter.dart';

final _formKey = GlobalKey<FormState>();

class FormBody extends ConsumerWidget {
  const FormBody({
    Key? key,
    required this.formScreen,
  }) : super(key: key);
  // form feild
  final FormScreen formScreen;

  @override
  Widget build(BuildContext context, ref) {
    final screenFormFields = formScreen.screenFormFields;

    return Form(
      key: _formKey,
      child: ListView.builder(
        itemCount: screenFormFields.length,
        itemBuilder: (BuildContext context, int index) {
          // form feild
          final formField = screenFormFields[index];
          // is dropdown
          final isDropDownField = (formField is DropDownField);

          // isDate
          final isDateField = (formField is DateFormField);

          // isLast
          final isLast = index == screenFormFields.length - 1;

          final initialValue =
              ref.watch(formField.formValueProvider.state).state;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    formField.label,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                if (isDropDownField)
                  DropdownButtonFormField<String>(
                    value: initialValue,
                    icon: const Icon(
                      CupertinoIcons.chevron_down_circle_fill,
                      color: kyuBlack,
                    ),
                    elevation: 16,
                    style: const TextStyle(color: kyuBlack),
                    menuMaxHeight: 500,
                    decoration: InputDecoration(
                      label: Text(formField.label),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: kyuBlack,
                        ),
                      ),
                    ),
                    hint: Text(formField.hint),
                    onChanged: (String? newValue) {
                      ref.read(formField.formValueProvider.notifier).state =
                          newValue;
                    },
                    items: formField.dropDownItems
                        .map<DropdownMenuItem<String>>((String value) {
                      // chopped Value  this shows the value chopped to the first 20 characters and the rest represented by an ellipsis
                      // but first check if string hs more than 20 characters before we chop it
                      final choppedValue = value.length > 18
                          ? '${value.substring(0, 18)}...'
                          : value;
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(choppedValue),
                      );
                    }).toList(),
                  )
                else if (isDateField)
                  InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: initialValue,
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        //pickedDate output format => 2021-03-10 00:00:00.000
                        print(pickedDate);
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        //formatted date output using intl package =>  2021-03-16
                        print(formattedDate);

                        ref.read(formField.formValueProvider.notifier).state =
                            pickedDate;
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kyuBlack,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // calender icon
                          const Icon(
                            CupertinoIcons.calendar,
                            color: kyuBlack,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            initialValue == null
                                ? formField.hint
                                : DateFormat.yMMMMEEEEd().format(initialValue),
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  TextFormField(
                    initialValue: initialValue.toString(),
                    keyboardType: formField.keyboardType,
                    onChanged: (newValue) {
                      ref.read(formField.formValueProvider.notifier).state =
                          newValue;
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
                  ),

                // put some spacing if last
                if (isLast) const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}
