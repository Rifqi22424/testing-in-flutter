import 'package:flutter/foundation.dart';

import '../../data/repositories/course_repository.dart';
import '../../domain/gpa_calculator.dart';
import '../../domain/models/course_grade.dart';

/// Logika layar IPK: menyiapkan teks yang siap tampil.
class GpaViewModel extends ChangeNotifier {
  GpaViewModel({required CourseRepository repository}) : _repository = repository {
    _repository.addListener(notifyListeners);
  }

  final CourseRepository _repository;

  List<CourseGrade> get courses => _repository.courses;

  double get gpa => GpaCalculator.calculate(courses);
  String get gpaText => GpaCalculator.format(gpa);
  String get predicate => GpaCalculator.predicate(gpa);
  int get totalSks => courses.fold(0, (sum, course) => sum + course.sks);

  void add({required String name, required int sks, required String grade}) {
    _repository.add(CourseGrade(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name.trim(),
      sks: sks,
      grade: grade,
    ));
  }

  void remove(String id) => _repository.remove(id);

  // ---- Aturan isian formulir (dipakai validator, dites dengan unit test) ----

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Nama mata kuliah wajib diisi';
    return null;
  }

  static String? validateSks(String? value) {
    final sks = int.tryParse(value ?? '');
    if (sks == null) return 'SKS harus berupa angka';
    if (sks < 1 || sks > 6) return 'SKS harus antara 1 dan 6';
    return null;
  }

  @override
  void dispose() {
    _repository.removeListener(notifyListeners);
    super.dispose();
  }
}
