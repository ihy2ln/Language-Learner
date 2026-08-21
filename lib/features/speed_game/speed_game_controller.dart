import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/content/seed_loader.dart';
import '../../data/db/database_provider.dart';
import '../../data/repositories/repository_providers.dart';
import 'speed_game_state.dart';

/// Drives one speed-flashcard round: a one-second countdown timer plus
/// self-reported known/missed on each card. No FSRS grading, no progress
/// writes — a round's score exists only for that round.
class SpeedGameController extends FamilyAsyncNotifier<SpeedGameState, String> {
  static const roundSeconds = 60;

  Timer? _timer;

  @override
  Future<SpeedGameState> build(String languageCode) async {
    final db = ref.watch(databaseProvider);
    await ensureSeedContent(db);

    final languageRepository = ref.watch(languageRepositoryProvider);
    final contentRepository = ref.watch(contentRepositoryProvider);

    final language = (await languageRepository.getByCode(languageCode))
        .when(ok: (l) => l, err: (e) => throw StateError(e.message));
    final bundle = (await contentRepository.getBundle(languageCode))
        .when(ok: (b) => b, err: (e) => throw StateError(e.message));
    final unit = bundle.units.single;

    final words = [
      for (final itemId in unit.itemIds)
        (await contentRepository.getItem(languageCode, itemId))
            .when(ok: (item) => item, err: (e) => throw StateError(e.message)),
    ]..shuffle();

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    ref.onDispose(() => _timer?.cancel());

    return SpeedGameState(
      language: language,
      words: words,
      currentIndex: 0,
      revealed: false,
      score: 0,
      secondsRemaining: roundSeconds,
      isRunning: true,
    );
  }

  void _tick() {
    final current = state.valueOrNull;
    if (current == null || !current.isRunning) return;

    final remaining = current.secondsRemaining - 1;
    if (remaining <= 0) {
      _timer?.cancel();
      state = AsyncData(
        current.copyWith(secondsRemaining: 0, isRunning: false),
      );
    } else {
      state = AsyncData(current.copyWith(secondsRemaining: remaining));
    }
  }

  void reveal() {
    final current = state.valueOrNull;
    if (current == null || !current.isRunning || current.revealed) return;
    state = AsyncData(current.copyWith(revealed: true));
  }

  void markCard({required bool knew}) {
    final current = state.valueOrNull;
    if (current == null || !current.isRunning || !current.revealed) return;

    state = AsyncData(current.copyWith(
      currentIndex: current.currentIndex + 1,
      revealed: false,
      score: current.score + (knew ? 1 : 0),
    ));
  }
}

final speedGameControllerProvider = AsyncNotifierProvider.family<
    SpeedGameController, SpeedGameState, String>(
  SpeedGameController.new,
);
