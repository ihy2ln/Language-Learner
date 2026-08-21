import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/content/fun_facts.dart';
import '../../data/content/seed_loader.dart';
import '../../data/db/database_provider.dart';
import '../../data/repositories/repository_providers.dart';
import '../../domain/checkin/streak.dart';
import '../../domain/entities/entities.dart';
import '../../domain/goals/daily_goal.dart';
import '../matching_game/matching_game_screen.dart';
import '../quiz/quiz_screen.dart';
import '../review/review_screen.dart';
import '../settings/settings_screen.dart';
import '../speed_game/speed_game_screen.dart';

class LanguageDashboard {
  const LanguageDashboard({
    required this.language,
    required this.unit,
    required this.hasPriorProgress,
    required this.itemsReviewedToday,
    required this.streak,
    required this.checkedInToday,
  });

  final Language language;
  final Unit unit;
  final bool hasPriorProgress;
  final int itemsReviewedToday;
  final int streak;
  final bool checkedInToday;
}

/// Fetches everything [LanguageHomeScreen] needs to render: the language
/// and its current unit, plus today's real activity — nothing here is
/// stored UI state, it's all derived fresh from the repositories.
final languageDashboardProvider =
    FutureProvider.family<LanguageDashboard, String>((ref, languageCode) async {
  await ensureSeedContent(ref.watch(databaseProvider));

  final languageRepository = ref.watch(languageRepositoryProvider);
  final contentRepository = ref.watch(contentRepositoryProvider);
  final progressRepository = ref.watch(progressRepositoryProvider);
  final checkInRepository = ref.watch(checkInRepositoryProvider);

  final language = (await languageRepository.getByCode(languageCode))
      .when(ok: (l) => l, err: (e) => throw StateError(e.message));
  final bundle = (await contentRepository.getBundle(languageCode))
      .when(ok: (b) => b, err: (e) => throw StateError(e.message));
  final unit = bundle.units.single;

  final progress = (await progressRepository.getAllForLanguage(languageCode))
      .when(ok: (p) => p, err: (e) => throw StateError(e.message));
  final checkInDates = (await checkInRepository.getCheckInDates(languageCode))
      .when(ok: (d) => d, err: (e) => throw StateError(e.message));

  final now = DateTime.now();
  bool isToday(DateTime d) =>
      d.year == now.year && d.month == now.month && d.day == now.day;

  return LanguageDashboard(
    language: language,
    unit: unit,
    hasPriorProgress: progress.isNotEmpty,
    itemsReviewedToday: progress.where((p) => isToday(p.lastReview)).length,
    streak: currentStreak(checkInDates, asOf: now),
    checkedInToday: checkInDates.any(isToday),
  );
});

/// A language's home screen: today's goals, streak, a check-in button,
/// and Start. Start always opens the same [ReviewScreen] — whether that
/// session turns out to be a placement test or an ordinary review is
/// decided by ReviewSessionController from real prior-progress data, not
/// by anything chosen here (this screen just labels the button
/// accordingly).
class LanguageHomeScreen extends ConsumerWidget {
  const LanguageHomeScreen({super.key, required this.languageCode});

  final String languageCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(languageDashboardProvider(languageCode));

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
      body: dashboardAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          key: const Key('language-home-error'),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Could not load language: $error'),
          ),
        ),
        data: (dashboard) => _DashboardBody(
          languageCode: languageCode,
          dashboard: dashboard,
        ),
      ),
    );
  }
}

class _DashboardBody extends ConsumerWidget {
  const _DashboardBody({required this.languageCode, required this.dashboard});

  final String languageCode;
  final LanguageDashboard dashboard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = dashboard.language;
    final unit = dashboard.unit;
    final levelSuffix =
        unit.level == null ? '' : ' · ${unit.level!.name.toUpperCase()}';
    final goals = computeDailyGoals(
      checkedInToday: dashboard.checkedInToday,
      itemsReviewedToday: dashboard.itemsReviewedToday,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            language.nativeName,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text('${unit.title}$levelSuffix'),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.local_fire_department, color: Colors.orange),
              const SizedBox(width: 4),
              Text(
                '${dashboard.streak}-day streak',
                key: const Key('streak-text'),
              ),
              const Spacer(),
              OutlinedButton(
                key: const Key('check-in-button'),
                onPressed: dashboard.checkedInToday
                    ? null
                    : () async {
                        final checkInRepository =
                            ref.read(checkInRepositoryProvider);
                        await checkInRepository.checkIn(
                          languageCode,
                          DateTime.now(),
                        );
                        ref.invalidate(languageDashboardProvider(languageCode));
                      },
                child: Text(
                  dashboard.checkedInToday ? 'Checked in' : 'Check in',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text("Today's goals", style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          for (final goal in goals)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                key: Key('goal-${goal.label}'),
                children: [
                  Icon(
                    goal.isComplete
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: goal.isComplete ? Colors.green : null,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(goal.label),
                ],
              ),
            ),
          _FunFactCard(languageCode: language.code),
          const SizedBox(height: 28),
          FilledButton(
            key: const Key('start-review-button'),
            onPressed: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (_) => ReviewScreen(languageCode: languageCode),
                ),
              )
                  // Progress/streak may have changed while the review screen
                  // was open — refetch rather than show stale numbers.
                  .then((_) {
                ref.invalidate(languageDashboardProvider(languageCode));
              });
            },
            child: Text(
              dashboard.hasPriorProgress
                  ? 'Continue review'
                  : 'Take placement test',
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            key: const Key('start-quiz-button'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => QuizScreen(languageCode: languageCode),
                ),
              );
            },
            child: const Text('Take a quiz'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            key: const Key('start-speed-game-button'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SpeedGameScreen(languageCode: languageCode),
                ),
              );
            },
            child: const Text('Speed round'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            key: const Key('start-matching-game-button'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      MatchingGameScreen(languageCode: languageCode),
                ),
              );
            },
            child: const Text('Word match'),
          ),
        ],
      ),
    );
  }
}

class _FunFactCard extends StatelessWidget {
  const _FunFactCard({required this.languageCode});

  final String languageCode;

  @override
  Widget build(BuildContext context) {
    final fact = factOfTheDay(funFactsFor(languageCode), DateTime.now());
    if (fact == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.lightbulb_outline),
              const SizedBox(width: 12),
              Expanded(
                child: Text(fact, key: const Key('fun-fact-text')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
