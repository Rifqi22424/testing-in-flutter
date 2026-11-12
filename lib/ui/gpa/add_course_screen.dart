import 'package:flutter/material.dart';

import '../../domain/gpa_calculator.dart';
import 'gpa_view_model.dart';

/// Hasil formulir yang dikirim kembali dengan Navigator.pop().
typedef NewCourse = ({String name, int sks, String grade});

/// Formulir tambah mata kuliah.
///
/// Setiap kolom diberi Key supaya mudah ditemukan oleh widget test
/// dan integration test, misalnya find.byKey(const Key('field-nama')).
class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _sks = TextEditingController();
  String _grade = 'A';

  @override
  void dispose() {
    _name.dispose();
    _sks.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final NewCourse course = (name: _name.text, sks: int.parse(_sks.text), grade: _grade);
    Navigator.pop(context, course);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Mata Kuliah')),
      body: Form(
        key: _formKey,
        // Setelah Simpan ditekan sekali, pesan error ikut hilang saat diketik.
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              key: const Key('field-nama'),
              controller: _name,
              decoration: const InputDecoration(labelText: 'Nama mata kuliah'),
              validator: GpaViewModel.validateName,
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('field-sks'),
              controller: _sks,
              decoration: const InputDecoration(labelText: 'SKS'),
              keyboardType: TextInputType.number,
              validator: GpaViewModel.validateSks,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              key: const Key('field-nilai'),
              initialValue: _grade,
              decoration: const InputDecoration(labelText: 'Nilai huruf'),
              items: [
                for (final grade in GpaCalculator.grades)
                  DropdownMenuItem(value: grade, child: Text(grade)),
              ],
              onChanged: (value) => setState(() => _grade = value!),
            ),
            const SizedBox(height: 32),
            FilledButton(
              key: const Key('tombol-simpan'),
              onPressed: _save,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
