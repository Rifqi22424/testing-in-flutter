import 'package:flutter/foundation.dart';

import '../../domain/models/course_grade.dart';

/// Sumber kebenaran daftar mata kuliah (disimpan di memori).
class CourseRepository extends ChangeNotifier {
  final List<CourseGrade> _courses = [];

  List<CourseGrade> get courses => List.unmodifiable(_courses);

  void add(CourseGrade course) {
    _courses.add(course);
    notifyListeners();
  }

  void remove(String id) {
    _courses.removeWhere((course) => course.id == id);
    notifyListeners();
  }
}
