import 'package:qr_new/feature/shared/utils/const.dart';

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
        json['email'] ?? nullString,
        name: json['name'] ?? nullString,
        teacherName: json['teacherName'] ?? nullString,
        teacherSurname: json['teacherSurname'] ?? nullString,
      );
  factory Lesson.notNull() =>
      Lesson('emial', name: '', teacherName: '', teacherSurname: '');
  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['teacherName'] = teacherName;
    data['teacherSurname'] = teacherSurname;

    return data;
  }
}
