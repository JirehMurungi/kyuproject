// page index
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/course.dart';
import '../../models/school_attended.dart';
import '../../models/student.dart';
import 'course_form.dart';
import 'schools_attended_form.dart';
import 'student_form.dart';

///Current Index of the auth pages
final currentScreenIndexProvider = StateProvider<int>((_) => 0);

// provider that provides a list of widget screen
final screenList = [
  const StudentForm(),
  const CourseForm(),
  const SchoolsAttended(),
];

// create state providers for the above fields
final nameProvider = StateProvider<String>((_) => '');
final regNoProvider = StateProvider<String>((_) => '');
final studentNoProvider = StateProvider<String>((_) => '');
final academicYearProvider = StateProvider<String>((_) => '');
final semesterProvider = StateProvider<String>((_) => '');
final sexProvider = StateProvider<String>((_) => '');
final maritalStatusProvider = StateProvider<String>((_) => '');
final dateOfBirthProvider = StateProvider<String>((_) => '');
final nationalityProvider = StateProvider<String>((_) => '');
final emailAddressProvider = StateProvider<String>((_) => '');
final phoneNumberProvider = StateProvider<String>((_) => '');
final homeDistrictProvider = StateProvider<String>((_) => '');
final religiousAffiliationProvider = StateProvider<String>((_) => '');
final firstParentNameProvider = StateProvider<String>((_) => '');
final firstParentContactProvider = StateProvider<String>((_) => '');
final secondParentNameProvider = StateProvider<String>((_) => '');
final secondParentContactProvider = StateProvider<String>((_) => '');
final disabledProvider = StateProvider<String>((_) => "");
final hallOfAttachmentProvider = StateProvider<String>((_) => '');
final residentialStatusProvider = StateProvider<String>((_) => '');

// String name;
// int yearOfEntry;
// String faculty;
// String typeOfEntry;
// String expectedAward;
final courseNameProvider = StateProvider<String>((_) => '');
final courseYearOfEntryProvider = StateProvider<String>((_) => "0");
final courseFacultyProvider = StateProvider<String>((_) => '');
final courseTypeOfEntryProvider = StateProvider<String>((_) => '');
final courseExpectedAwardProvider = StateProvider<String>((_) => '');

//   String schoolName;
// int from;
// int to;

final universityNameProvider = StateProvider<String>((_) => '');
final yearJoinedProvider = StateProvider<String>((_) => "0");
final yearLeftProvider = StateProvider<String>((_) => "0");

final alevelSchoolNameProvider = StateProvider<String>((_) => '');
final alevelYearJoinedProvider = StateProvider<String>((_) => "0");
final alevelYearLeftProvider = StateProvider<String>((_) => "0");

final olevelSchoolNameProvider = StateProvider<String>((_) => '');
final olevelYearJoinedProvider = StateProvider<String>((_) => "0");
final olevelYearLeftProvider = StateProvider<String>((_) => "0");

// generate a student object using values of the above providers
final studentProvider = Provider<Student>(
  (ref) {
    return Student(
      name: ref.watch(nameProvider.state).state,
      regNo: ref.watch(regNoProvider.state).state,
      studentNo: int.parse(ref.watch(studentNoProvider.state).state),
      academicYear: ref.watch(academicYearProvider.state).state,
      semester: ref.watch(semesterProvider.state).state,
      sex: ref.watch(sexProvider.state).state,
      maritalStatus: ref.watch(maritalStatusProvider.state).state,
      dateOfBirth: ref.watch(dateOfBirthProvider.state).state,
      nationality: ref.watch(nationalityProvider.state).state,
      emailAddress: ref.watch(emailAddressProvider.state).state,
      phoneNumber: ref.watch(phoneNumberProvider.state).state,
      homeDistrict: ref.watch(homeDistrictProvider.state).state,
      religiousAffiliation: ref.watch(religiousAffiliationProvider.state).state,
      firstParentName: ref.watch(firstParentNameProvider.state).state,
      firstParentContact: ref.watch(firstParentContactProvider.state).state,
      secondParentName: ref.watch(secondParentNameProvider.state).state,
      secondParentContact: ref.watch(secondParentContactProvider.state).state,
      disabled: ref.watch(disabledProvider.state).state,
      course: Course(
        name: ref.watch(courseNameProvider.state).state,
        yearOfEntry:
            int.parse(ref.watch(courseYearOfEntryProvider.state).state),
        faculty: ref.watch(courseFacultyProvider.state).state,
        typeOfEntry: ref.watch(courseTypeOfEntryProvider.state).state,
        expectedAward: ref.watch(courseExpectedAwardProvider.state).state,
      ),
      schoolsAttended: [
        SchoolAttended(
          schoolName: ref.watch(universityNameProvider.state).state,
          from: int.parse(ref.watch(yearJoinedProvider.state).state),
          to: int.parse(ref.watch(yearLeftProvider.state).state),
        ),
        SchoolAttended(
          schoolName: ref.watch(alevelSchoolNameProvider.state).state,
          from: int.parse(ref.watch(alevelYearJoinedProvider.state).state),
          to: int.parse(ref.watch(alevelYearLeftProvider.state).state),
        ),
        SchoolAttended(
          schoolName: ref.watch(olevelSchoolNameProvider.state).state,
          from: int.parse(ref.watch(olevelYearJoinedProvider.state).state),
          to: int.parse(ref.watch(olevelYearLeftProvider.state).state),
        )
      ],
      hallOfAttachment: ref.watch(hallOfAttachmentProvider.state).state,
      residentialStatus: ref.watch(residentialStatusProvider.state).state,
    );
  },
);
