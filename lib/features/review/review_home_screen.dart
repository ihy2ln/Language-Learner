import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/content/seed_loader.dart';
import '../../data/db/database_provider.dart';
import '../../data/repositories/repository_providers.dart';
import '../../domain/entities/entities.dart';
import '../settings/settings_screen.dart';
import 'review_screen.dart';

/// Fetches the language's display name and its current unit's title, so
/// [ReviewHomeScreen] isn't hardcoded to any one language.
final languageOverviewProvider =
    FutureProvider.family<(Language, Unit), String>((ref, languageCode) async {
  await ensureSeedContent(ref.watch(databaseProvider));

  final languageRepository = ref.watch(languageRepositoryProvider);
  final contentRepository = ref.watch(contentRepositoryProvider);

  final language = (await languageRepository.getByCode(languageCode))
      .when(ok: (l) => l, err: (e) => throw StateError(e.message));
  final bundle = (await contentRepository.getBundle(languageCode))
      .when(ok: (b) => b, err: (e) => throw StateError(e.message));

  return (language, bundle.units.single);
});

/// Launch screen for a single language: its name, current unit, and a
/// Start button. Reused for any language with curated content — the
/// language picker (features/languages/) decides which [languageCode]
/// reaches this screen.
class ReviewHomeScreen extends ConsumerWidget {
  const ReviewHomeScreen({super.key, required this.languageCode});

  final String languageCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overviewAsync = ref.watch(languageOverviewProvider(languageCode));

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
          child: overviewAsync.when(
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) =>
                Text('Could not load language: $error'),
            data: (overview) {
              final (language, unit) = overview;
              final levelSuffix =
                  unit.level == null ? '' : ' · ${unit.level!.name.toUpperCase()}';
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    language.nativeName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('${unit.title}$levelSuffix'),
                  const SizedBox(height: 32),
                  FilledButton(
                    key: const Key('start-review-button'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              ReviewScreen(languageCode: languageCode),
                        ),
                      );
                    },
                    child: const Text('Start review'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
