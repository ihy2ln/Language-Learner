import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/data/db/database.dart';
import 'package:linguaforge/data/db/database_provider.dart';
import 'package:linguaforge/features/matching_game/matching_game_controller.dart';
import 'package:linguaforge/features/matching_game/matching_game_screen.dart';

void main() {
  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  /// The 12-tile board is taller than the test viewport, so scroll a
  /// tile into view before tapping it.
  Future<void> tapTile(WidgetTester tester, String tileId) async {
    final finder = find.byKey(Key('match-tile-$tileId'));
    await tester.ensureVisible(finder);
    await tester.tap(finder);
    await tester.pump();
  }

  testWidgets('the board has 6 pairs (12 tiles)', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(
          AppDatabase(NativeDatabase.memory()),
        ),
      ],
      child: const MaterialApp(
        home: MatchingGameScreen(languageCode: 'es-419'),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text('0 / 6 matched · 0 mistake(s)'), findsOneWidget);
    expect(find.byType(OutlinedButton), findsNWidgets(12));
  });

  testWidgets('tapping a correct pair marks both tiles matched',
      (tester) async {
    final container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(AppDatabase(NativeDatabase.memory())),
    ]);
    addTearDown(container.dispose);

    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(
        home: MatchingGameScreen(languageCode: 'es-419'),
      ),
    ));
    await tester.pumpAndSettle();

    final game = container.read(matchingGameControllerProvider('es-419')).value!;
    final firstItemId = game.tiles.first.itemId;

    await tapTile(tester, 'target-$firstItemId');
    await tapTile(tester, 'native-$firstItemId');

    expect(find.text('1 / 6 matched · 0 mistake(s)'), findsOneWidget);
  });

  testWidgets('tapping a wrong pair counts a mistake and clears the '
      'selection shortly after', (tester) async {
    final container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(AppDatabase(NativeDatabase.memory())),
    ]);
    addTearDown(container.dispose);

    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(
        home: MatchingGameScreen(languageCode: 'es-419'),
      ),
    ));
    await tester.pumpAndSettle();

    final game = container.read(matchingGameControllerProvider('es-419')).value!;
    // Two target tiles from different items never match each other.
    final wrongTileA = game.tiles.firstWhere((t) => t.isTarget);
    final wrongTileB =
        game.tiles.firstWhere((t) => t.isTarget && t.itemId != wrongTileA.itemId);

    await tapTile(tester, wrongTileA.id);
    await tapTile(tester, wrongTileB.id);

    expect(find.text('0 / 6 matched · 1 mistake(s)'), findsOneWidget);

    final midState =
        container.read(matchingGameControllerProvider('es-419')).value!;
    expect(midState.mismatchTileIds, isNotNull);

    // The flash clears itself (Future.delayed(500ms)) without another tap.
    await tester.pump(const Duration(milliseconds: 600));

    final clearedState =
        container.read(matchingGameControllerProvider('es-419')).value!;
    expect(clearedState.mismatchTileIds, isNull);
  });

  testWidgets('matching every pair reaches the results screen',
      (tester) async {
    final container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(AppDatabase(NativeDatabase.memory())),
    ]);
    addTearDown(container.dispose);

    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(
        home: MatchingGameScreen(languageCode: 'es-419'),
      ),
    ));
    await tester.pumpAndSettle();

    final game = container.read(matchingGameControllerProvider('es-419')).value!;
    final itemIds = game.tiles.map((t) => t.itemId).toSet();

    for (final itemId in itemIds) {
      await tapTile(tester, 'target-$itemId');
      await tapTile(tester, 'native-$itemId');
    }
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('matching-game-results')), findsOneWidget);
    expect(find.text('No mistakes'), findsOneWidget);
  });

  testWidgets('Done on the results screen returns to the caller',
      (tester) async {
    final container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(AppDatabase(NativeDatabase.memory())),
    ]);
    addTearDown(container.dispose);

    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(
        home: MatchingGameScreen(languageCode: 'es-419'),
      ),
    ));
    await tester.pumpAndSettle();

    final game = container.read(matchingGameControllerProvider('es-419')).value!;
    final itemIds = game.tiles.map((t) => t.itemId).toSet();
    for (final itemId in itemIds) {
      await tapTile(tester, 'target-$itemId');
      await tapTile(tester, 'native-$itemId');
    }
    await tester.pumpAndSettle();

    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    expect(find.byType(MatchingGameScreen), findsNothing);
  });
}
