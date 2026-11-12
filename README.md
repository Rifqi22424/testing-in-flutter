# NusaIPK — Sesi 9: Pengujian Unit dan Integrasi

Contoh aplikasi untuk mata kuliah **Pemrograman Perangkat Mobile (IF31033)**, Universitas Nusa Putra.

NusaIPK adalah kalkulator IPK sederhana: masukkan mata kuliah, SKS, dan nilai huruf, lalu IPK dan predikatnya dihitung. Yang dipelajari adalah **cara mengujinya** dengan tiga jenis test Flutter.

| Jenis test | Yang diuji | Berjalan di | Jumlah di proyek ini |
|---|---|---|---|
| **Unit test** | Satu fungsi atau kelas (`GpaCalculator`, `GpaViewModel`) | Laptop, tanpa emulator | 13 |
| **Widget test** | Satu layar (formulir, daftar) | Laptop, layar tiruan | 4 |
| **Integration test** | Seluruh aplikasi, seperti pengguna | Emulator atau HP | 1 |

## Menjalankan

```bash
flutter pub get
flutter run
```

Unit test dan widget test (sekitar 1 detik):

```bash
flutter test
```

Integration test (nyalakan emulator atau sambungkan HP dulu):

```bash
flutter test integration_test
```

## Struktur folder

```
lib/
├── main.dart
├── app.dart
├── config/dependencies.dart
├── domain/
│   ├── gpa_calculator.dart        # semua aturan IPK (target unit test)
│   └── models/course_grade.dart
├── data/repositories/course_repository.dart
└── ui/gpa/
    ├── gpa_view_model.dart        # + validateName, validateSks
    ├── gpa_screen.dart
    ├── add_course_screen.dart     # kolom diberi Key untuk test
    └── gpa_page.dart
test/
├── unit/
│   ├── gpa_calculator_test.dart
│   └── gpa_view_model_test.dart
└── widget/
    ├── add_course_screen_test.dart
    └── gpa_screen_test.dart
integration_test/
└── app_test.dart
```

## Setiap test: siapkan, jalankan, periksa

```dart
test('daftar kosong menghasilkan 0, bukan NaN', () {
  // 1. Siapkan
  final daftar = <CourseGrade>[];
  // 2. Jalankan
  final ipk = GpaCalculator.calculate(daftar);
  // 3. Periksa
  expect(ipk, 0);
});
```

## Langkah praktik

### Langkah 1 — Siapkan proyek

```bash
git clone https://github.com/Rifqi22424/testing-in-flutter.git
cd testing-in-flutter
flutter pub get
```

**Cek:** `flutter test` menampilkan `All tests passed!`.

### Langkah 2 — Unit test `gradePoint`

Buka `test/unit/gpa_calculator_test.dart`, baca grup `gradePoint`: nilai A, huruf kecil dengan spasi, dan huruf yang tidak dikenal.

**Cek:** `flutter test test/unit/gpa_calculator_test.dart` → 3 test grup `gradePoint` lulus.

### Langkah 3 — Unit test `calculate` dan melihat test merah

Di `lib/domain/gpa_calculator.dart`, hapus sementara baris:

```dart
if (totalSks == 0) return 0;
```

**Cek:** test "daftar kosong menghasilkan 0, bukan NaN" gagal dengan `Expected: <0> Actual: <NaN>`. Kembalikan baris tersebut, test hijau lagi.

### Langkah 4 — Nilai batas predikat

Di `predicate()`, ubah sementara `gpa > 3.50` menjadi `gpa >= 3.50`.

**Cek:** test "3,50 tepat belum Pujian" gagal. Kembalikan seperti semula.

### Langkah 5 — Widget test formulir

Buka `test/widget/add_course_screen_test.dart`. Test menampilkan `AddCourseScreen`, menekan `tombol-simpan`, lalu mencari teks error.

**Cek:** tambahkan test baru yang memasukkan SKS `0` dan memeriksa teks `SKS harus antara 1 dan 6`.

### Langkah 6 — Integration test

Nyalakan emulator, lalu:

```bash
flutter test integration_test
```

**Cek:** test "mahasiswa memasukkan tiga nilai dan mendapat IPK 3,75 Pujian" lulus. Di emulator terlihat formulir terisi sendiri.

## Troubleshooting

| Masalah | Penyebab | Solusi |
|---|---|---|
| `pumpAndSettle timed out` | Ada animasi tanpa akhir, misalnya loading | Pakai `pump(const Duration(...))` |
| `Too many elements` saat `find.text('B')` | Teks muncul dua kali (dropdown) | Pakai `.last` atau `find.byKey` |
| `No MediaQuery widget ancestor found` | Layar belum dibungkus `MaterialApp` | `pumpWidget(MaterialApp(home: ...))` |
| `No supported devices connected` | Integration test butuh perangkat | Nyalakan emulator atau sambungkan HP |
| Test selalu lulus walau kode salah | Lupa `expect`, atau test tidak memeriksa apa pun | Rusak kodenya sebentar dan pastikan test merah |

> Aturan predikat di aplikasi ini adalah contoh. Untuk aturan resmi, lihat pedoman akademik kampus.
