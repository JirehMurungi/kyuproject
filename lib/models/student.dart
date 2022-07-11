// To parse required this JSON data, do
//
//     final student = studentFromMap(jsonfinal String);

import 'dart:convert';

import 'course.dart';
import 'school_attended.dart';

// access the firebase user object
// User user;

Student studentFromMap(String str) => Student.fromMap(json.decode(str));

String studentToMap(Student data) => json.encode(data.toMap());

class Student {
  Student({
    required this.name,
    required this.regNo,
    required this.studentNo,
    required this.academicYear,
    required this.semester,
    required this.sex,
    required this.maritalStatus,
    required this.dateOfBirth,
    required this.nationality,
    required this.emailAddress,
    required this.phoneNumber,
    required this.homeDistrict,
    required this.religiousAffiliation,
    required this.firstParentName,
    required this.firstParentContact,
    required this.secondParentName,
    required this.secondParentContact,
    required this.disabled,
    required this.course,
    required this.schoolsAttended,
    required this.hallOfAttachment,
    required this.residentialStatus,
    this.userId,
  });

  final String name;
  final String regNo;
  final String studentNo;
  final String academicYear;
  final String semester;
  final String sex;
  final String maritalStatus;
  final DateTime dateOfBirth;
  final String nationality;
  final String emailAddress;
  final String phoneNumber;
  final String homeDistrict;
  final String religiousAffiliation;
  final String firstParentName;
  final String firstParentContact;
  final String secondParentName;
  final String secondParentContact;
  final String disabled;
  final Course course;
  final List<SchoolAttended> schoolsAttended;
  final String hallOfAttachment;
  final String residentialStatus;
  final String? userId;

  factory Student.fromMap(Map<String, dynamic> json) => Student(
        name: json["name"],
        regNo: json["regNo"],
        studentNo: json["studentNo"],
        academicYear: json["academicYear"],
        semester: json["semester"],
        sex: json["sex"],
        maritalStatus: json["maritalStatus"],
        dateOfBirth: json["dateOfBirth"],
        nationality: json["nationality"],
        emailAddress: json["emailAddress"],
        phoneNumber: json["phoneNumber"],
        homeDistrict: json["homeDistrict"],
        religiousAffiliation: json["religiousAffiliation"],
        firstParentName: json["firstParentName"],
        firstParentContact: json["firstParentContact"],
        secondParentName: json["secondParentName"],
        secondParentContact: json["secondParentContact"],
        disabled: json["disabled"],
        course: Course.fromMap(json["course"]),
        schoolsAttended: List<SchoolAttended>.from(
            json["schoolsAttended"].map((x) => SchoolAttended.fromMap(x))),
        hallOfAttachment: json["hallOfAttachment"],
        residentialStatus: json["residentialStatus"],
        userId: json["userId"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "regNo": regNo,
        "studentNo": studentNo,
        "academicYear": academicYear,
        "semester": semester,
        "sex": sex,
        "maritalStatus": maritalStatus,
        "dateOfBirth": dateOfBirth,
        "nationality": nationality,
        "emailAddress": emailAddress,
        "phoneNumber": phoneNumber,
        "homeDistrict": homeDistrict,
        "religiousAffiliation": religiousAffiliation,
        "firstParentName": firstParentName,
        "firstParentContact": firstParentContact,
        "secondParentName": secondParentName,
        "secondParentContact": secondParentContact,
        "disabled": disabled,
        "course": course.toMap(),
        "schoolsAttended":
            List<dynamic>.from(schoolsAttended.map((x) => x.toMap())),
        "hallOfAttachment": hallOfAttachment,
        "residentialStatus": residentialStatus,
        "userId": userId,
      };

  static Student sampleStudent = Student(
    name: "Cephas Brian",
    regNo: "19/i/7834",
    studentNo: "2000944",
    academicYear: "Year 1",
    semester: "Sem 2",
    sex: "Male",
    maritalStatus: "Single",
    dateOfBirth: DateTime.now(),
    nationality: "Ugandan",
    emailAddress: "jirehmurungi@gmail.com",
    phoneNumber: "0775533685",
    homeDistrict: "Kabarole",
    religiousAffiliation: "BornAgain",
    firstParentName: "Mr KattaPatrick",
    firstParentContact: "0775533685",
    secondParentName: "MrsKattaGrace",
    secondParentContact: "0774149104",
    disabled: "false",
    course: Course(
        name: "Computer Science",
        yearOfEntry: "2020",
        faculty: "Faculty of Science",
        typeOfEntry: "Alevel",
        expectedAward: "Diploma"),
    schoolsAttended: [
      SchoolAttended(schoolName: "KYU", from: "2018", to: "2020"),
      SchoolAttended(schoolName: "KYU", from: "2018", to: "2020"),
      SchoolAttended(schoolName: "KYU", from: "2018", to: "2020")
    ],
    hallOfAttachment: "Nanziri",
    residentialStatus: "Non-Resident",
    userId: "vbndm",
  );

  //  to final string
  @override
  String toString() {
    return 'Student{name: $name, regNo: $regNo, studentNo: $studentNo, academicYear: $academicYear, semester: $semester';
  }
}
