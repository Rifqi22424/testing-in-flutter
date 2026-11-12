import 'package:flutter/material.dart';

import 'ui/gpa/gpa_page.dart';

class NusaIpkApp extends StatelessWidget {
  const NusaIpkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaIPK',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: const Color(0xFF6B4FBB)),
      home: const GpaPage(),
    );
  }
}
