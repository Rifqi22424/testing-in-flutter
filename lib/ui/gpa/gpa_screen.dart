import 'package:flutter/material.dart';

import 'add_course_screen.dart';
import 'gpa_view_model.dart';

/// Layar utama: ringkasan IPK + daftar mata kuliah.
class GpaScreen extends StatelessWidget {
  const GpaScreen({super.key, required this.viewModel});

  final GpaViewModel viewModel;

  Future<void> _openForm(BuildContext context) async {
    final NewCourse? course = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddCourseScreen()),
    );
    if (course == null) return; // pengguna menekan Kembali
    viewModel.add(name: course.name, sks: course.sks, grade: course.grade);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NusaIPK')),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('tombol-tambah'),
        onPressed: () => _openForm(context),
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final text = Theme.of(context).textTheme;
          final courses = viewModel.courses;
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text('IPK', style: text.titleMedium),
                      Text(viewModel.gpaText, key: const Key('teks-ipk'), style: text.displayMedium),
                      Text(viewModel.predicate, key: const Key('teks-predikat'), style: text.titleSmall),
                      const SizedBox(height: 4),
                      Text('${viewModel.totalSks} SKS · ${courses.length} mata kuliah'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (courses.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Belum ada mata kuliah.\nTekan Tambah untuk memasukkan nilai.',
                    textAlign: TextAlign.center,
                  ),
                ),
              for (final course in courses)
                Dismissible(
                  key: ValueKey(course.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Theme.of(context).colorScheme.errorContainer,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete),
                  ),
                  onDismissed: (_) => viewModel.remove(course.id),
                  child: ListTile(
                    title: Text(course.name),
                    subtitle: Text('${course.sks} SKS'),
                    trailing: CircleAvatar(child: Text(course.grade)),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
