import 'package:flutter/material.dart';

import '../settings/settings_screen.dart';
import 'review_screen.dart';

/// Launch screen for the one seeded language. Stands in for the
/// language picker, which is deliberately not built yet — depth on one
/// language before the list grows.
class ReviewHomeScreen extends StatelessWidget {
  const ReviewHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LinguaForge'),
        actions: [
          IconButton(
            key: const Key('open-settings-button'),
            icon: const Icon(Icons.settings),
            tooltip: 'Provider keys',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Español',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Greetings and introductions · A1'),
              const SizedBox(height: 32),
              FilledButton(
                key: const Key('start-review-button'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ReviewScreen()),
                  );
                },
                child: const Text('Start review'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
