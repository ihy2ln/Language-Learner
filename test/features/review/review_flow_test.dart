import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/data/db/database.dart';
import 'package:linguaforge/data/db/database_provider.dart';
import 'package:linguaforge/features/languages/language_home_screen.dart';

/// End-to-end widget coverage of the one real user flow this build has:
/// open the app, start a review session for the seeded Spanish unit, work
/// through every card, and land on a completion screen. This is the
/// substitute for manually tapping through the app on a device — this
/// sandbox has no Android SDK/emulator to do that with.
void main() {
  // Each test opens its own AppDatabase(NativeDatabase.memory()) for
  // isolation, which is exactly the pattern Drift warns about (it assumes
  // one long-lived instance in production, which databaseProvider does
  // provide there — this file just doesn't share a database across tests
  // on purpose).
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

  testWidgets('home screen shows the seeded language and a start button',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Español'), findsOneWidget);
    expect(find.text('Greetings and introductions · A1'), findsOneWidget);
    expect(find.byKey(const Key('start-review-button')), findsOneWidget);
  });

  testWidgets('starting a review shows the first seeded item, target first',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-review-button')));
    await tester.pumpAndSettle();

    expect(find.text('1 / 12'), findsOneWidget);
    expect(find.byKey(const Key('review-target-text')), findsOneWidget);
    expect(find.text('buenos días'), findsOneWidget);
    // Not revealed yet.
    expect(find.byKey(const Key('review-native-text')), findsNothing);
    expect(find.byKey(const Key('reveal-button')), findsOneWidget);
  });

  testWidgets('revealing shows the native gloss and grade buttons',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-review-button')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('reveal-button')));
    await tester.pump();

    expect(find.byKey(const Key('review-native-text')), findsOneWidget);
    expect(find.text('good morning'), findsOneWidget);
    expect(find.byKey(const Key('reveal-button')), findsNothing);
    for (final key in [
      'grade-again',
      'grade-hard',
      'grade-good',
      'grade-easy'
    ]) {
      expect(find.byKey(Key(key)), findsOneWidget);
    }
  });

  testWidgets('grading advances to the next card, unrevealed', (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-review-button')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('reveal-button')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('grade-good')));
    await tester.pumpAndSettle();

    expect(find.text('2 / 12'), findsOneWidget);
    expect(find.text('buenas tardes'), findsOneWidget);
    expect(find.byKey(const Key('review-native-text')), findsNothing);
    expect(find.byKey(const Key('reveal-button')), findsOneWidget);
  });

  testWidgets(
      'working through all 12 seeded items reaches the completion screen',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-review-button')));
    await tester.pumpAndSettle();

    for (var i = 0; i < 12; i++) {
      expect(find.byKey(const Key('session-complete')), findsNothing);
      await tester.tap(find.byKey(const Key('reveal-button')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('grade-good')));
      await tester.pumpAndSettle();
    }

    expect(find.byKey(const Key('session-complete')), findsOneWidget);
    expect(
      find.text('Session complete — reviewed 12 item(s).'),
      findsOneWidget,
    );
  });

  testWidgets('Done on the completion screen returns to the home screen',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-review-button')));
    await tester.pumpAndSettle();

    for (var i = 0; i < 12; i++) {
      await tester.tap(find.byKey(const Key('reveal-button')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('grade-good')));
      await tester.pumpAndSettle();
    }

    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('start-review-button')), findsOneWidget);
  });
}
