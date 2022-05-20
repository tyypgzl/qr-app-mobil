import 'package:flutter/material.dart';
import 'package:qr_new/core/base/base_view.dart';
import 'package:qr_new/feature/lessons/view_model/lessons_view_model.dart';
import 'package:qr_new/feature/shared/widgets/custom_list_tile.dart';

class LessonView extends BaseView<LessonsViewModel> {
  final String email;
  LessonView({required this.email, Key? key}) : super(key: key);

  @override
  LessonsViewModel get homeViewModel => LessonsViewModel(email: email);

  @override
  Widget? body(BuildContext context, LessonsViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.lessons.length,
      itemBuilder: (context, index) => AdminListTile(
        lesson: viewModel.lessons[index],
        onTap: () => viewModel.lessonOnTap(index),
      ),
    );
  }
}
