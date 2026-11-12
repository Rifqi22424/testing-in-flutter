/// Satu mata kuliah yang sudah keluar nilainya.
class CourseGrade {
  final String id;
  final String name;
  final int sks;
  final String grade; // "A", "B", "C", "D", atau "E"

  const CourseGrade({
    required this.id,
    required this.name,
    required this.sks,
    required this.grade,
  });
}
