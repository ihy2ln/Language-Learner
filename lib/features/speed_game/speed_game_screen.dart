import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'speed_game_controller.dart';
import 'speed_game_state.dart';

/// A 60-second flashcard speed round: reveal, self-report known/missed,
/// keep going until the clock runs out. Practice, not spaced repetition —
/// nothing here is persisted.
class SpeedGameScreen extends ConsumerWidget {
  const SpeedGameScreen({super.key, required this.languageCode});

  final String languageCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameAsync = ref.watch(speedGameControllerProvider(languageCode));

    return Scaffold(
      appBar: AppBar(title: const Text('Speed round')),
      body: gameAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          key: const Key('speed-game-error'),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Could not load speed round: $error'),
          ),
        ),
        data: (game) {
          if (game.isFinished) {
            return _SpeedGameResults(score: game.score);
          }
          return _SpeedGameCard(languageCode: languageCode, game: game);
        },
      ),
    );
  }
}

class _SpeedGameResults extends StatelessWidget {
  const _SpeedGameResults({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Center(
      key: const Key('speed-game-results'),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.bolt, size: 48, color: Colors.amber),
            const SizedBox(height: 16),
            const Text(
              "Time's up!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '$score known',
              key: const Key('speed-game-score'),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpeedGameCard extends ConsumerWidget {
  const _SpeedGameCard({required this.languageCode, required this.game});

  final String languageCode;
  final SpeedGameState game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller =
        ref.read(speedGameControllerProvider(languageCode).notifier);
    final word = game.currentWord;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${game.secondsRemaining}s',
            key: const Key('speed-game-timer'),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Score: ${game.score}',
            key: const Key('speed-game-score-live'),
          ),
          const SizedBox(height: 32),
          Text(
            word.target,
            key: const Key('speed-game-target-text'),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          if (game.revealed) ...[
            const SizedBox(height: 16),
            Text(
              word.native,
              key: const Key('speed-game-native-text'),
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 32),
          if (!game.revealed)
            FilledButton(
              key: const Key('speed-game-reveal-button'),
              onPressed: controller.reveal,
              child: const Text('Show answer'),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  key: const Key('speed-game-missed-button'),
                  onPressed: () => controller.markCard(knew: false),
                  child: const Text('Missed it'),
                ),
                FilledButton(
                  key: const Key('speed-game-known-button'),
                  onPressed: () => controller.markCard(knew: true),
                  child: const Text('Got it'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
