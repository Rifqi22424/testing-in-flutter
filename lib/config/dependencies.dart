import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/course_repository.dart';

List<SingleChildWidget> get providers => [
      ChangeNotifierProvider(create: (context) => CourseRepository()),
    ];
