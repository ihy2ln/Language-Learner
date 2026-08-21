import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/data/db/database.dart';
import 'package:linguaforge/data/db/database_provider.dart';
import 'package:linguaforge/features/speed_game/speed_game_screen.dart';

void main() {
  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  Widget appUnderTest() {
    return ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(
          AppDatabase(NativeDatabase.memory()),
        ),
      ],
      child: const MaterialApp(
        home: SpeedGameScreen(languageCode: 'es-419'),
      ),
    );
  }

  testWidgets('starts a 60-second round at score 0', (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('60s'), findsOneWidget);
    expect(find.text('Score: 0'), findsOneWidget);
    expect(find.byKey(const Key('speed-game-target-text')), findsOneWidget);
    expect(find.byKey(const Key('speed-game-reveal-button')), findsOneWidget);
  });

  testWidgets('the countdown ticks down every second', (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 3));

    expect(find.text('57s'), findsOneWidget);
  });

  testWidgets('revealing shows the gloss and Got it/Missed it buttons',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('speed-game-reveal-button')));
    await tester.pump();

    expect(find.byKey(const Key('speed-game-native-text')), findsOneWidget);
    expect(find.byKey(const Key('speed-game-known-button')), findsOneWidget);
    expect(find.byKey(const Key('speed-game-missed-button')), findsOneWidget);
  });

  testWidgets('marking a card known increases the score and shows a new card',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    final firstWord = tester
        .widget<Text>(find.byKey(const Key('speed-game-target-text')))
        .data;

    await tester.tap(find.byKey(const Key('speed-game-reveal-button')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('speed-game-known-button')));
    await tester.pump();

    expect(find.text('Score: 1'), findsOneWidget);
    expect(find.byKey(const Key('speed-game-reveal-button')), findsOneWidget);
    final secondWord = tester
        .widget<Text>(find.byKey(const Key('speed-game-target-text')))
        .data;
    expect(secondWord, isNot(firstWord));
  });

  testWidgets('marking a card missed does not increase the score',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('speed-game-reveal-button')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('speed-game-missed-button')));
    await tester.pump();

    expect(find.text('Score: 0'), findsOneWidget);
  });

  testWidgets('the round ends and shows a score screen when time runs out',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 60));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('speed-game-results')), findsOneWidget);
    expect(find.byKey(const Key('speed-game-score')), findsOneWidget);
  });

  testWidgets('Done on the score screen returns to the caller',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 60));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    expect(find.byType(SpeedGameScreen), findsNothing);
  });
}
