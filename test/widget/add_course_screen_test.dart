import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sesi9_pengujian/ui/gpa/add_course_screen.dart';

// WIDGET TEST: menguji satu layar di lingkungan test (tanpa emulator).
void main() {
  testWidgets('menekan Simpan dengan isian kosong menampilkan pesan error', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AddCourseScreen()));

    await tester.tap(find.byKey(const Key('tombol-simpan')));
    await tester.pump();

    expect(find.text('Nama mata kuliah wajib diisi'), findsOneWidget);
    expect(find.text('SKS harus berupa angka'), findsOneWidget);
  });

  testWidgets('SKS 9 ditolak', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AddCourseScreen()));

    await tester.enterText(find.byKey(const Key('field-nama')), 'Kalkulus');
    await tester.enterText(find.byKey(const Key('field-sks')), '9');
    await tester.tap(find.byKey(const Key('tombol-simpan')));
    await tester.pump();

    expect(find.text('SKS harus antara 1 dan 6'), findsOneWidget);
  });
}
