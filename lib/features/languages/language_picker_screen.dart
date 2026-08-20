import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/content/seed_loader.dart';
import '../../data/db/database_provider.dart';
import '../../data/repositories/repository_providers.dart';
import '../../domain/entities/entities.dart';
import 'language_home_screen.dart';

final languageListProvider = FutureProvider<List<Language>>((ref) async {
  await ensureSeedContent(ref.watch(databaseProvider));
  final languageRepository = ref.watch(languageRepositoryProvider);
  return (await languageRepository.getAll())
      .when(ok: (languages) => languages, err: (e) => throw StateError(e.message));
});

/// App entry point: every known language, honestly labeled. A language
/// with no curated content (Antiguan Creole, currently) is shown, not
/// hidden — CLAUDE.md hard rule #6 — but can't be tapped into, since
/// there's no unit to start a session with.
class LanguagePickerScreen extends ConsumerWidget {
  const LanguagePickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languagesAsync = ref.watch(languageListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('LinguaForge')),
      body: languagesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          key: const Key('language-list-error'),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Could not load languages: $error'),
          ),
        ),
        data: (languages) => ListView.builder(
          itemCount: languages.length,
          itemBuilder: (context, index) {
            final language = languages[index];
            final available = language.hasCuratedContent;
            return ListTile(
              key: Key('language-tile-${language.code}'),
              enabled: available,
              title: Text(language.name),
              subtitle: Text(
                available ? language.nativeName : 'Content coming soon',
              ),
              trailing: available ? const Icon(Icons.chevron_right) : null,
              onTap: !available
                  ? null
                  : () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              LanguageHomeScreen(languageCode: language.code),
                        ),
                      );
                    },
            );
          },
        ),
      ),
    );
  }
}
