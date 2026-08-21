import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/data/content/fun_facts.dart';
import 'package:linguaforge/data/db/database.dart';
import 'package:linguaforge/data/db/database_provider.dart';
import 'package:linguaforge/features/languages/language_home_screen.dart';

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
        home: LanguageHomeScreen(languageCode: 'es-419'),
      ),
    );
  }

  testWidgets(
      'a fresh language starts at a zero streak, not checked in, and offers '
      'the placement test', (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('0-day streak'), findsOneWidget);
    expect(find.text('Check in'), findsOneWidget);
    expect(find.text('Take placement test'), findsOneWidget);
  });

  testWidgets('checking in marks the goal complete and starts a 1-day streak',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('check-in-button')));
    await tester.pumpAndSettle();

    expect(find.text('1-day streak'), findsOneWidget);
    expect(find.text('Checked in'), findsOneWidget);
    // The check-in button becomes disabled once today is done.
    final button =
        tester.widget<OutlinedButton>(find.byKey(const Key('check-in-button')));
    expect(button.onPressed, isNull);
  });

  testWidgets('the button reads Continue review once there is prior progress',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('start-review-button')));
    await tester.pumpAndSettle();
    // First item, fresh session: multiple choice. Answer it (correct or
    // not doesn't matter here) to record progress, then head back.
    await tester.tap(find.byKey(const Key('mc-option-good morning')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('continue-button')));
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Continue review'), findsOneWidget);
  });

  testWidgets('shows today\'s fun fact for the language', (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    final expected = factOfTheDay(funFactsFor('es-419'), DateTime.now());
    expect(find.byKey(const Key('fun-fact-text')), findsOneWidget);
    expect(find.text(expected!), findsOneWidget);
  });

  testWidgets('Take a quiz opens the quiz screen', (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('start-quiz-button')));
    await tester.pumpAndSettle();

    expect(find.text('Question 1 / 8'), findsOneWidget);
  });

  testWidgets('Speed round opens the speed game screen', (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('start-speed-game-button')));
    await tester.pumpAndSettle();

    expect(find.text('60s'), findsOneWidget);
    // Let the round finish so no Timer is left pending when the test ends.
    await tester.pump(const Duration(seconds: 60));
    await tester.pumpAndSettle();
  });

  testWidgets('Word match opens the matching game screen', (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    final button = find.byKey(const Key('start-matching-game-button'));
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.text('0 / 6 matched · 0 mistake(s)'), findsOneWidget);
  });
}
