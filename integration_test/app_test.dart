import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sesi9_pengujian/main.dart' as app;

// INTEGRATION TEST: menjalankan aplikasi SUNGGUHAN di emulator/HP,
// lalu menekan tombol seperti pengguna. Semua bagian diuji bersama:
// layar, navigasi, formulir, ViewModel, repository, dan perhitungan.
//
// Jalankan dengan:  flutter test integration_test
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> tambahMataKuliah(WidgetTester tester, String nama, String sks, String nilai) async {
    await tester.tap(find.byKey(const Key('tombol-tambah')));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('field-nama')), nama);
    await tester.enterText(find.byKey(const Key('field-sks')), sks);
    await tester.tap(find.byKey(const Key('field-nilai')));
    await tester.pumpAndSettle();
    await tester.tap(find.text(nilai).last); // pilih dari menu dropdown
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('tombol-simpan')));
    await tester.pumpAndSettle();
  }

  testWidgets('mahasiswa memasukkan tiga nilai dan mendapat IPK 3,75 Pujian', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.text('0,00'), findsOneWidget);

    await tambahMataKuliah(tester, 'Pemrograman Perangkat Mobile', '3', 'A');
    await tambahMataKuliah(tester, 'Kecerdasan Buatan', '3', 'A');
    await tambahMataKuliah(tester, 'Etika Profesi', '2', 'B');

    expect(find.text('3,75'), findsOneWidget);
    expect(find.text('Pujian'), findsOneWidget);
    expect(find.text('8 SKS · 3 mata kuliah'), findsOneWidget);
  });
}
