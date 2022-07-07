class Course {
  Course({
    required this.name,
    required this.yearOfEntry,
    required this.faculty,
    required this.typeOfEntry,
    required this.expectedAward,
  });

  String name;
  int yearOfEntry;
  String faculty;
  String typeOfEntry;
  String expectedAward;

  factory Course.fromMap(Map<String, dynamic> json) => Course(
        name: json["name"],
        yearOfEntry: json["yearOfEntry"],
        faculty: json["faculty"],
        typeOfEntry: json["typeOfEntry"],
        expectedAward: json["expectedAward"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "yearOfEntry": yearOfEntry,
        "faculty": faculty,
        "typeOfEntry": typeOfEntry,
        "expectedAward": expectedAward,
      };
}
