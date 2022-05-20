class Lesson {
  String name;
  String teacherName;
  String teacherSurname;
  String? email;

  Lesson(this.email,
      {required this.name,
      required this.teacherName,
      required this.teacherSurname});

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        json['email'] == null ? 'email@email.com' : json['email'],
        name: json['name'] == null ? 'A' : json['name'],
        teacherName: json['teacherName'] == null ? 'B' : json['teacherName'],
        teacherSurname:
            json['teacherSurname'] == null ? 'C' : json['teacherSurname'],
      );
  factory Lesson.notNull() =>
      Lesson('emial', name: '', teacherName: '', teacherSurname: '');
  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['name'] = name;
    data['teacherName'] = teacherName;
    data['teacherSurname'] = teacherSurname;

    return data;
  }
}
