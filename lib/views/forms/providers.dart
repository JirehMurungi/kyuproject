// page index
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/course.dart';
import '../../models/school_attended.dart';
import '../../models/student.dart';
import 'data/dropdown_lists.dart';

///Current Index of the auth pages
final currentScreenIndexProvider = StateProvider<int>((_) => 0);

// create state providers for the above fields
final nameProvider = StateProvider<String>((_) => '');
final regNoProvider = StateProvider<String>((_) => '');
final studentNoProvider = StateProvider<String>((_) => '');
final academicYearProvider =
    StateProvider<String>((_) => academicYearList.first);
final semesterProvider = StateProvider<String>((_) => semesterList.first);
final sexProvider = StateProvider<String>((_) => sexList.first);
final maritalStatusProvider =
    StateProvider<String>((_) => maritalStatusList.first);
final dateOfBirthProvider = StateProvider<DateTime>(
  (_) => DateTime.now(),
);
final nationalityProvider = StateProvider<String>((_) => '');
final emailAddressProvider = StateProvider<String>((_) => '');
final phoneNumberProvider = StateProvider<String>((_) => '');
final homeDistrictProvider = StateProvider<String>((_) {
  final List<String> alphabetDistricts = homeDistrictList
    ..sort((a, b) => a.compareTo(b));
  return alphabetDistricts.first;
});
final religiousAffiliationProvider = StateProvider<String>((_) => '');
final firstParentNameProvider = StateProvider<String>((_) => '');
final firstParentContactProvider = StateProvider<String>((_) => '');
final secondParentNameProvider = StateProvider<String>((_) => '');
final secondParentContactProvider = StateProvider<String>((_) => '');
final disabledProvider = StateProvider<String>((_) => disabledList.first);
final hallOfAttachmentProvider =
    StateProvider<String>((_) => hallOfAttachmentList.first);
final residentialStatusProvider =
    StateProvider<String>((_) => residentialStatusList.first);

final courseNameProvider = StateProvider<String>((_) {
  final List<String> alphabetCourses = courseList
    ..sort((a, b) => a.compareTo(b));
  return alphabetCourses.first;
});
final courseYearOfEntryProvider = StateProvider<String>((_) => "0");
final courseFacultyProvider =
    StateProvider<String>((_) => courseFacultyList.first);
final courseTypeOfEntryProvider =
    StateProvider<String>((_) => courseTypeOfEntryList.first);
final courseExpectedAwardProvider =
    StateProvider<String>((_) => courseExpectedAwardList.first);

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
      studentNo: ref.watch(studentNoProvider.state).state,
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
        yearOfEntry: ref.watch(courseYearOfEntryProvider.state).state,
        faculty: ref.watch(courseFacultyProvider.state).state,
        typeOfEntry: ref.watch(courseTypeOfEntryProvider.state).state,
        expectedAward: ref.watch(courseExpectedAwardProvider.state).state,
      ),
      schoolsAttended: [
        SchoolAttended(
          schoolName: ref.watch(universityNameProvider.state).state,
          from: ref.watch(yearJoinedProvider.state).state,
          to: ref.watch(yearLeftProvider.state).state,
        ),
        SchoolAttended(
          schoolName: ref.watch(alevelSchoolNameProvider.state).state,
          from: ref.watch(alevelYearJoinedProvider.state).state,
          to: ref.watch(alevelYearLeftProvider.state).state,
        ),
        SchoolAttended(
          schoolName: ref.watch(olevelSchoolNameProvider.state).state,
          from: ref.watch(olevelYearJoinedProvider.state).state,
          to: ref.watch(olevelYearLeftProvider.state).state,
        )
      ],
      hallOfAttachment: ref.watch(hallOfAttachmentProvider.state).state,
      residentialStatus: ref.watch(residentialStatusProvider.state).state,
      userId: FirebaseAuth.instance.currentUser?.uid,
    );
  },
);
