import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

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

// a list of FormTextField for the student form from the above
List<FormTextField> studentFormFields = [
  FormTextField(
    label: 'Name',
    hint: 'Enter your name',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Name is required";
      }

      return null;
    },
    formValueProvider: nameProvider,
  ),
  FormTextField(
    label: 'Reg. No.',
    hint: 'Enter your reg. no.',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Reg number required";
      }

      return null;
    },
    formValueProvider: regNoProvider,
  ),
  FormTextField(
    label: 'Student No.',
    hint: 'Enter your student no.',
    keyboardType: TextInputType.number,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your student no.';
      }
      return null;
    },
    formValueProvider: studentNoProvider,
  ),
  FormTextField(
    label: 'Academic Year',
    hint: 'Enter your academic year',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your academic year';
      }
      return null;
    },
    formValueProvider: academicYearProvider,
  ),

  // ! Semester
  FormTextField(
    label: 'Semester',
    hint: 'Enter your semester',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your semester';
      }
      return null;
    },
    formValueProvider: semesterProvider,
  ),

  // ! Sex
  FormTextField(
    label: 'Sex',
    hint: 'Enter your Sex',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Sex';
      }
      return null;
    },
    formValueProvider: sexProvider,
  ),
  //! maritalStatusProvider

  FormTextField(
    label: 'Marital Status',
    hint: 'Enter your Marital Status',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Marital Status';
      }
      return null;
    },
    formValueProvider: maritalStatusProvider,
  ),

//!  dateOfBirthProvider

  FormTextField(
    label: 'Date of Birth',
    hint: 'Enter your Date of Birth',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Date of Birth';
      }
      return null;
    },
    formValueProvider: dateOfBirthProvider,
  ),

//  nationalityProvider

  FormTextField(
    label: 'Nationality',
    hint: 'Enter your Nationality',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Nationality';
      }
      return null;
    },
    formValueProvider: nationalityProvider,
  ),

//  emailAddressProvider

  FormTextField(
    label: 'Email Address',
    hint: 'Enter your Email Address',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Email Address';
      }
      return null;
    },
    formValueProvider: emailAddressProvider,
  ),

//  phoneNumberProvider

  FormTextField(
    label: 'Phone Number',
    hint: 'Enter your Phone Number',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Phone Number';
      }
      return null;
    },
    formValueProvider: phoneNumberProvider,
  ),

//!  homeDistrictProvider

  FormTextField(
    label: 'Home District',
    hint: 'Enter your Home District',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Home District';
      }
      return null;
    },
    formValueProvider: homeDistrictProvider,
  ),

//  religiousAffiliationProvider

  FormTextField(
    label: 'Religious Affiliation',
    hint: 'Enter your Religious Affiliation',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Religious Affiliation';
      }
      return null;
    },
    formValueProvider: religiousAffiliationProvider,
  ),

//  firstParentNameProvider

  FormTextField(
    label: 'First Parent Name',
    hint: 'Enter your First Parent Name',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your First Parent Name';
      }
      return null;
    },
    formValueProvider: firstParentNameProvider,
  ),

//  firstParentContactProvider

  FormTextField(
    label: 'First Parent Contact',
    hint: 'Enter your First Parent Contact',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your First Parent Contact';
      }
      return null;
    },
    formValueProvider: firstParentContactProvider,
  ),

//  secondParentNameProvider

  FormTextField(
    label: 'Second Parent Name',
    hint: 'Enter your Second Parent Name',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Second Parent Name';
      }
      return null;
    },
    formValueProvider: secondParentNameProvider,
  ),

//  secondParentContactProvider

  FormTextField(
    label: 'Second Parent Contact',
    hint: 'Enter your Second Parent Contact',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Second Parent Contact';
      }
      return null;
    },
    formValueProvider: secondParentContactProvider,
  ),

//!  disabledProvider
  FormTextField(
    label: 'Disabled',
    hint: 'Enter your disability status e.g Yes or No',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your disability status';
      }
      return null;
    },
    formValueProvider: disabledProvider,
  ),

//!  hallOfAttachmentProvider

  FormTextField(
    label: 'Hall Of Attachment',
    hint: 'Enter your Hall Of Attachment',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Hall Of Attachment';
      }
      return null;
    },
    formValueProvider: hallOfAttachmentProvider,
  ),

//!  residentialStatusProvider

  FormTextField(
    label: 'Residential Status',
    hint: 'Enter your Residential Status',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Residential Status';
      }
      return null;
    },
    formValueProvider: residentialStatusProvider,
  ),
];

// courseFormFields
//  courseNameProvider
//  courseYearOfEntryProvider
//  courseFacultyProvider
//  courseTypeOfEntryProvider
//  courseExpectedAwardProvider
List<FormTextField> courseFormFields = [
  FormTextField(
    label: 'Course Name',
    hint: 'Enter your Course Name',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Course Name';
      }
      return null;
    },
    formValueProvider: courseNameProvider,
  ),
  FormTextField(
    label: 'Course Year of Entry',
    hint: 'Enter your Course Year of Entry',
    keyboardType: TextInputType.number,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Course Year of Entry';
      }
      return null;
    },
    formValueProvider: courseYearOfEntryProvider,
  ),
  FormTextField(
    label: 'Course Faculty',
    hint: 'Enter your Course Faculty',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Course Faculty';
      }
      return null;
    },
    formValueProvider: courseFacultyProvider,
  ),
  FormTextField(
    label: 'Course Type of Entry',
    hint: 'Enter your Course Type of Entry',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Course Type of Entry';
      }
      return null;
    },
    formValueProvider: courseTypeOfEntryProvider,
  ),
  FormTextField(
    label: 'Course Expected Award',
    hint: 'Enter your Course Expected Award',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Course Expected Award';
      }
      return null;
    },
    formValueProvider: courseExpectedAwardProvider,
  ),
];

//  universityNameProvider
//  yearJoinedProvider
//  yearLeftProvider

//  alevelSchoolNameProvider
//  alevelYearJoinedProvider
//  alevelYearLeftProvider

//  olevelSchoolNameProvider
//  olevelYearJoinedProvider
//  olevelYearLeftProvider

List<FormTextField> schoolFormFields = [
  FormTextField(
    label: 'University Name',
    hint: 'Enter your University Name',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your University Name';
      }
      return null;
    },
    formValueProvider: universityNameProvider,
  ),
  FormTextField(
    label: 'Year Joined',
    hint: 'Enter your Year Joined',
    keyboardType: TextInputType.number,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Year Joined';
      }
      return null;
    },
    formValueProvider: yearJoinedProvider,
  ),
  FormTextField(
    label: 'Year Left',
    keyboardType: TextInputType.number,
    hint: 'Enter your Year Left',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your Year Left';
      }
      return null;
    },
    formValueProvider: yearLeftProvider,
  ),
  FormTextField(
    label: 'A Level School Name',
    hint: 'Enter your A Level School Name',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your A Level School Name';
      }
      return null;
    },
    formValueProvider: alevelSchoolNameProvider,
  ),
  FormTextField(
    label: 'A Level Year Joined',
    hint: 'Enter your A Level Year Joined',
    keyboardType: TextInputType.number,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your A Level Year Joined';
      }
      return null;
    },
    formValueProvider: alevelYearJoinedProvider,
  ),
  FormTextField(
    label: 'A Level Year Left',
    hint: 'Enter your A Level Year Left',
    keyboardType: TextInputType.number,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your A Level Year Left';
      }
      return null;
    },
    formValueProvider: alevelYearLeftProvider,
  ),
  FormTextField(
    label: 'O Level School Name',
    hint: 'Enter your O Level School Name',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your O Level School Name';
      }
      return null;
    },
    formValueProvider: olevelSchoolNameProvider,
  ),
  FormTextField(
    label: 'O Level Year Joined',
    hint: 'Enter your O Level Year Joined',
    keyboardType: TextInputType.number,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your O Level Year Joined';
      }
      return null;
    },
    formValueProvider: olevelYearJoinedProvider,
  ),
  FormTextField(
    label: 'O Level Year Left',
    hint: 'Enter your O Level Year Left',
    keyboardType: TextInputType.number,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your O Level Year Left';
      }
      return null;
    },
    formValueProvider: olevelYearLeftProvider,
  ),
];
