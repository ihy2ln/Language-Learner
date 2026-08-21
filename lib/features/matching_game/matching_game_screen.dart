import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'matching_game_controller.dart';
import 'matching_game_state.dart';

/// A word-matching board: tap a target-language tile, then its native
/// meaning. No FSRS grading, no progress writes.
class MatchingGameScreen extends ConsumerWidget {
  const MatchingGameScreen({super.key, required this.languageCode});

  final String languageCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameAsync = ref.watch(matchingGameControllerProvider(languageCode));

    return Scaffold(
      appBar: AppBar(title: const Text('Word match')),
      body: gameAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          key: const Key('matching-game-error'),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Could not load word match: $error'),
          ),
        ),
        data: (game) => game.isFinished
            ? _MatchingGameResults(mistakes: game.mistakes)
            : _MatchingBoard(languageCode: languageCode, game: game),
      ),
    );
  }
}

class _MatchingGameResults extends StatelessWidget {
  const _MatchingGameResults({required this.mistakes});

  final int mistakes;

  @override
  Widget build(BuildContext context) {
    return Center(
      key: const Key('matching-game-results'),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.grid_view, size: 48, color: Colors.purple),
            const SizedBox(height: 16),
            const Text(
              'All matched!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              mistakes == 0 ? 'No mistakes' : '$mistakes mistake(s)',
              key: const Key('matching-game-mistakes'),
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

class _MatchingBoard extends ConsumerStatefulWidget {
  const _MatchingBoard({required this.languageCode, required this.game});

  final String languageCode;
  final MatchingGameState game;

  @override
  ConsumerState<_MatchingBoard> createState() => _MatchingBoardState();
}

class _MatchingBoardState extends ConsumerState<_MatchingBoard> {
  @override
  void didUpdateWidget(covariant _MatchingBoard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.game.mismatchTileIds != null &&
        oldWidget.game.mismatchTileIds != widget.game.mismatchTileIds) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted) return;
        ref
            .read(matchingGameControllerProvider(widget.languageCode).notifier)
            .clearMismatchHighlight();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;
    final controller =
        ref.read(matchingGameControllerProvider(widget.languageCode).notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            '${game.matchedItemIds.length} / ${game.tiles.length ~/ 2} matched'
            ' · ${game.mistakes} mistake(s)',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 2.4,
            children: [
              for (final tile in game.tiles)
                _Tile(tile: tile, game: game, onTap: controller.selectTile),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.tile, required this.game, required this.onTap});

  final MatchTile tile;
  final MatchingGameState game;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final matched = game.matchedItemIds.contains(tile.itemId);
    final selected = game.selectedTileId == tile.id;
    final mismatched = game.mismatchTileIds != null &&
        (game.mismatchTileIds!.$1 == tile.id ||
            game.mismatchTileIds!.$2 == tile.id);

    Color? backgroundColor;
    if (matched) {
      backgroundColor = Colors.green.withValues(alpha: 0.15);
    } else if (mismatched) {
      backgroundColor = Colors.red.withValues(alpha: 0.15);
    } else if (selected) {
      backgroundColor = Colors.blue.withValues(alpha: 0.15);
    }

    return OutlinedButton(
      key: Key('match-tile-${tile.id}'),
      onPressed: matched ? null : () => onTap(tile.id),
      style: OutlinedButton.styleFrom(backgroundColor: backgroundColor),
      child: Text(
        tile.text,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
