class SchoolAttended {
  SchoolAttended({
    required this.schoolName,
    required this.from,
    required this.to,
  });

  String schoolName;
  int from;
  int to;

  factory SchoolAttended.fromMap(Map<String, dynamic> json) => SchoolAttended(
        schoolName: json["schoolName"],
        from: json["from"],
        to: json["to"],
      );

  Map<String, dynamic> toMap() => {
        "schoolName": schoolName,
        "from": from,
        "to": to,
      };
}
