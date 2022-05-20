import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:qr_new/core/base/base_view_model.dart';
import 'package:qr_new/core/navigation/navigation_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/route_constants.dart';
import '../../../core/exception/postgrest_exception.dart';
import '../../home/model/lesson.dart';

class LessonsViewModel extends BaseViewModel {
  final String email;
  LessonsViewModel({required this.email});
  final client = GetIt.instance<SupabaseClient>();

  late List<Lesson> lessons;

  @override
  Future<bool> customBack() async {
    navigationService.pop();
    return Future.value(true);
  }

  @override
  Future<void> init() async {
    try {
      log('Lesson: ' + email);
      lessons = [];
      var response = await client.from('createdLesson').select().execute();
      var list = response.data;
      var lessonList = (list as List).map((e) => Lesson.fromJson(e)).toList();
      lessons.clear();
      lessons.addAll(lessonList);
    } on PostgrestException catch (e) {
      log(e.error.message);
    }
  }

  Future<void> lessonOnTap(int index) async {
    var lesson = lessons[index];
    lesson.email = email;
    await NavigationService.instance
        .pushNamed(routePath: RouteConstants.scan, args: lesson);
  }

  @override
  NavigationService get navigationService => NavigationService.instance;
}
