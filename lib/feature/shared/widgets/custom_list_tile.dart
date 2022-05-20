import 'package:flutter/material.dart';
import 'package:qr_new/feature/home/model/lesson.dart';
import 'package:qr_new/feature/shared/utils/app_colors.dart';

class AdminListTile extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onTap;
  const AdminListTile({
    Key? key,
    required this.lesson,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const StadiumBorder(),
      shadowColor: AppColors.instance.black,
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: AppColors.instance.pink,
          child: Text(
            '${lesson.teacherName.characters.first}${lesson.teacherSurname.characters.first}',
            style: TextStyle(color: AppColors.instance.black),
          ),
        ),
        title: Text(lesson.name),
        subtitle: Text('${lesson.teacherName} ${lesson.teacherSurname}'),
      ),
    );
  }
}
