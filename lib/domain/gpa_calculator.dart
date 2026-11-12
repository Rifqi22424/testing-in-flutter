import 'models/course_grade.dart';

/// Semua aturan perhitungan IPK ada di sini.
///
/// Kelas ini tidak memakai widget, internet, atau database. Inputnya data,
/// outputnya data. Karena itu kelas ini paling mudah dan paling cepat
/// dites dengan UNIT TEST (lihat test/unit/gpa_calculator_test.dart).
abstract final class GpaCalculator {
  static const List<String> grades = ['A', 'B', 'C', 'D', 'E'];

  static const Map<String, double> _points = {
    'A': 4,
    'B': 3,
    'C': 2,
    'D': 1,
    'E': 0,
  };

  /// Bobot satu nilai huruf. "a" dan " A " juga diterima.
  /// Huruf yang tidak dikenal melempar ArgumentError.
  static double gradePoint(String grade) {
    final point = _points[grade.trim().toUpperCase()];
    if (point == null) {
      throw ArgumentError('Nilai huruf tidak dikenal: $grade');
    }
    return point;
  }

  /// IPK = jumlah (bobot x SKS) / jumlah SKS.
  /// Jika belum ada mata kuliah, IPK = 0 (bukan NaN).
  static double calculate(List<CourseGrade> courses) {
    final totalSks = courses.fold(0, (sum, course) => sum + course.sks);
    if (totalSks == 0) return 0;

    final totalPoints = courses.fold(
      0.0,
      (sum, course) => sum + gradePoint(course.grade) * course.sks,
    );
    return totalPoints / totalSks;
  }

  /// 3.75 -> "3,75"
  static String format(double gpa) => gpa.toStringAsFixed(2).replaceAll('.', ',');

  /// Predikat kelulusan program sarjana.
  static String predicate(double gpa) {
    if (gpa > 3.50) return 'Pujian';
    if (gpa > 3.00) return 'Sangat Memuaskan';
    if (gpa >= 2.76) return 'Memuaskan';
    return 'Belum ada predikat';
  }
}
