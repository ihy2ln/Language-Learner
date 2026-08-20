import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/review/review_home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Spanish until the language picker (features/languages/) replaces
      // this as the app's entry point.
      home: ReviewHomeScreen(languageCode: 'es-419'),
    );
  }
}
