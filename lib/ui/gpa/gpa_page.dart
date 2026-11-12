import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'gpa_screen.dart';
import 'gpa_view_model.dart';

/// Membuat GpaViewModel dari repository di Provider, lalu menampilkan layar.
class GpaPage extends StatefulWidget {
  const GpaPage({super.key});

  @override
  State<GpaPage> createState() => _GpaPageState();
}

class _GpaPageState extends State<GpaPage> {
  late final GpaViewModel _viewModel = GpaViewModel(repository: context.read());

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GpaScreen(viewModel: _viewModel);
}
