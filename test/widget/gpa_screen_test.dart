import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sesi9_pengujian/data/repositories/course_repository.dart';
import 'package:sesi9_pengujian/ui/gpa/gpa_screen.dart';
import 'package:sesi9_pengujian/ui/gpa/gpa_view_model.dart';

void main() {
  testWidgets('daftar kosong menampilkan IPK 0,00 dan petunjuk', (tester) async {
    final viewModel = GpaViewModel(repository: CourseRepository());
    await tester.pumpWidget(MaterialApp(home: GpaScreen(viewModel: viewModel)));

    expect(find.text('0,00'), findsOneWidget);
    expect(find.textContaining('Belum ada mata kuliah'), findsOneWidget);
  });

  testWidgets('menggeser mata kuliah menghapusnya dan IPK dihitung ulang', (tester) async {
    final viewModel = GpaViewModel(repository: CourseRepository())
      ..add(name: 'Kalkulus', sks: 3, grade: 'A')
      ..add(name: 'Fisika', sks: 3, grade: 'C');
    await tester.pumpWidget(MaterialApp(home: GpaScreen(viewModel: viewModel)));
    expect(find.text('3,00'), findsOneWidget);

    await tester.drag(find.text('Fisika'), const Offset(-500, 0));
    await tester.pumpAndSettle();

    expect(find.text('Fisika'), findsNothing);
    expect(find.text('4,00'), findsOneWidget);
  });
}
