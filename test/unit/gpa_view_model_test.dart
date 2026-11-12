import 'package:flutter_test/flutter_test.dart';
import 'package:sesi9_pengujian/data/repositories/course_repository.dart';
import 'package:sesi9_pengujian/ui/gpa/gpa_view_model.dart';

// Masih UNIT TEST: ViewModel dites tanpa layar.
void main() {
  late GpaViewModel viewModel;

  setUp(() => viewModel = GpaViewModel(repository: CourseRepository()));

  test('awalnya IPK 0,00 dan 0 SKS', () {
    expect(viewModel.gpaText, '0,00');
    expect(viewModel.totalSks, 0);
  });

  test('menambah mata kuliah memperbarui IPK, predikat, dan SKS', () {
    viewModel.add(name: 'PPM', sks: 3, grade: 'A');
    viewModel.add(name: 'AI', sks: 3, grade: 'A');
    viewModel.add(name: 'Etika', sks: 2, grade: 'B');

    expect(viewModel.gpaText, '3,75');
    expect(viewModel.predicate, 'Pujian');
    expect(viewModel.totalSks, 8);
  });

  test('validateSks menolak 0, 7, dan huruf', () {
    expect(GpaViewModel.validateSks('0'), isNotNull);
    expect(GpaViewModel.validateSks('7'), isNotNull);
    expect(GpaViewModel.validateSks('tiga'), isNotNull);
    expect(GpaViewModel.validateSks('3'), isNull);
  });

  test('validateName menolak isian kosong atau spasi saja', () {
    expect(GpaViewModel.validateName('   '), isNotNull);
    expect(GpaViewModel.validateName('Kalkulus'), isNull);
  });
}
