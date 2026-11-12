import 'package:flutter_test/flutter_test.dart';
import 'package:sesi9_pengujian/domain/gpa_calculator.dart';
import 'package:sesi9_pengujian/domain/models/course_grade.dart';

// UNIT TEST: menguji satu kelas (GpaCalculator) secara terpisah.
// Tanpa layar, tanpa emulator. Satu test selesai dalam milidetik.

CourseGrade mk(int sks, String grade) =>
    CourseGrade(id: '$sks$grade', name: 'MK', sks: sks, grade: grade);

void main() {
  group('gradePoint', () {
    test('A bernilai 4 dan E bernilai 0', () {
      expect(GpaCalculator.gradePoint('A'), 4);
      expect(GpaCalculator.gradePoint('E'), 0);
    });

    test('huruf kecil dan spasi tetap dikenali', () {
      expect(GpaCalculator.gradePoint(' b '), 3);
    });

    test('huruf yang tidak dikenal melempar ArgumentError', () {
      expect(() => GpaCalculator.gradePoint('F'), throwsArgumentError);
    });
  });

  group('calculate', () {
    test('IPK dihitung dengan bobot SKS', () {
      // (4x3 + 4x3 + 3x2) / 8 = 30 / 8 = 3,75
      final gpa = GpaCalculator.calculate([mk(3, 'A'), mk(3, 'A'), mk(2, 'B')]);
      expect(gpa, 3.75);
    });

    test('daftar kosong menghasilkan 0, bukan NaN', () {
      expect(GpaCalculator.calculate([]), 0);
    });
  });

  group('predicate (nilai batas)', () {
    test('3,50 tepat belum Pujian', () {
      expect(GpaCalculator.predicate(3.50), 'Sangat Memuaskan');
    });

    test('3,51 sudah Pujian', () {
      expect(GpaCalculator.predicate(3.51), 'Pujian');
    });

    test('2,76 Memuaskan, 2,75 belum ada predikat', () {
      expect(GpaCalculator.predicate(2.76), 'Memuaskan');
      expect(GpaCalculator.predicate(2.75), 'Belum ada predikat');
    });
  });

  test('format memakai koma dan dua angka desimal', () {
    expect(GpaCalculator.format(3.75), '3,75');
    expect(GpaCalculator.format(0), '0,00');
  });
}
