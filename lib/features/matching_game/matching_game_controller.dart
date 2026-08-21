import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/content/seed_loader.dart';
import '../../data/db/database_provider.dart';
import '../../data/repositories/repository_providers.dart';
import '../../domain/exercise/exercise.dart';
import 'matching_game_state.dart';

/// Drives one word-matching round: tap a target-language tile, then its
/// native-language partner. No FSRS grading, no progress writes.
class MatchingGameController
    extends FamilyAsyncNotifier<MatchingGameState, String> {
  static const pairCount = 6;

  @override
  Future<MatchingGameState> build(String languageCode) async {
    final db = ref.watch(databaseProvider);
    await ensureSeedContent(db);

    final languageRepository = ref.watch(languageRepositoryProvider);
    final contentRepository = ref.watch(contentRepositoryProvider);

    final language = (await languageRepository.getByCode(languageCode))
        .when(ok: (l) => l, err: (e) => throw StateError(e.message));
    final bundle = (await contentRepository.getBundle(languageCode))
        .when(ok: (b) => b, err: (e) => throw StateError(e.message));
    final unit = bundle.units.single;

    final items = [
      for (final itemId in unit.itemIds)
        (await contentRepository.getItem(languageCode, itemId))
            .when(ok: (item) => item, err: (e) => throw StateError(e.message)),
    ];
    final selected = pickRandomItems(items, count: pairCount);

    final tiles = [
      for (final item in selected)
        MatchTile(
          id: 'target-${item.id}',
          text: item.target,
          itemId: item.id,
          isTarget: true,
        ),
      for (final item in selected)
        MatchTile(
          id: 'native-${item.id}',
          text: item.native,
          itemId: item.id,
          isTarget: false,
        ),
    ]..shuffle();

    return MatchingGameState(
      language: language,
      tiles: tiles,
      matchedItemIds: const {},
      selectedTileId: null,
      mismatchTileIds: null,
      mistakes: 0,
    );
  }

  void selectTile(String tileId) {
    final current = state.valueOrNull;
    // Wait for a mismatch flash to clear before accepting new taps.
    if (current == null || current.mismatchTileIds != null) return;

    final tile = current.tiles.firstWhere((t) => t.id == tileId);
    if (current.matchedItemIds.contains(tile.itemId)) return;

    final selectedId = current.selectedTileId;
    if (selectedId == null) {
      state = AsyncData(MatchingGameState(
        language: current.language,
        tiles: current.tiles,
        matchedItemIds: current.matchedItemIds,
        selectedTileId: tileId,
        mismatchTileIds: null,
        mistakes: current.mistakes,
      ));
      return;
    }
    if (selectedId == tileId) return;

    final first = current.tiles.firstWhere((t) => t.id == selectedId);
    final isMatch = first.itemId == tile.itemId;

    state = AsyncData(MatchingGameState(
      language: current.language,
      tiles: current.tiles,
      matchedItemIds: isMatch
          ? {...current.matchedItemIds, tile.itemId}
          : current.matchedItemIds,
      selectedTileId: null,
      mismatchTileIds: isMatch ? null : (selectedId, tileId),
      mistakes: isMatch ? current.mistakes : current.mistakes + 1,
    ));
  }

  void clearMismatchHighlight() {
    final current = state.valueOrNull;
    if (current == null || current.mismatchTileIds == null) return;

    state = AsyncData(MatchingGameState(
      language: current.language,
      tiles: current.tiles,
      matchedItemIds: current.matchedItemIds,
      selectedTileId: null,
      mismatchTileIds: null,
      mistakes: current.mistakes,
    ));
  }
}

final matchingGameControllerProvider = AsyncNotifierProvider.family<
    MatchingGameController, MatchingGameState, String>(
  MatchingGameController.new,
);
