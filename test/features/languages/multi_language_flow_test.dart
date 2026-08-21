import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/data/db/database.dart';
import 'package:linguaforge/data/db/database_provider.dart';
import 'package:linguaforge/features/languages/language_home_screen.dart';
import 'package:linguaforge/providers/speech/speech_providers.dart';

import '../../providers/speech/fake_tts_adapter.dart';

/// The Spanish flow gets exhaustive end-to-end coverage in
/// review_flow_test.dart. This file just proves the same machinery
/// (ReviewSessionController, LanguageHomeScreen, the TTS button, and the
/// adaptive multiple-choice exercise format) actually generalizes to the
/// other seeded languages, each with a different script and voice hint —
/// not just to the one language it happened to be built against.
void main() {
  setUpAll(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  Widget appUnderTest(String languageCode, {required FakeTtsAdapter tts}) {
    return ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(
          AppDatabase(NativeDatabase.memory()),
        ),
        ttsAdapterProvider.overrideWithValue(tts),
      ],
      child: MaterialApp(
        home: LanguageHomeScreen(languageCode: languageCode),
      ),
    );
  }

  /// Taps the multiple-choice option matching [correctAnswer], then
  /// Continue. The card scrolls (SingleChildScrollView), so
  /// ensureVisible before each tap in case a button lands below the test
  /// viewport.
  Future<void> answerCorrectly(WidgetTester tester, String correctAnswer) async {
    final optionFinder = find.byKey(Key('mc-option-$correctAnswer'));
    await tester.ensureVisible(optionFinder);
    await tester.tap(optionFinder);
    await tester.pump();
    final continueFinder = find.byKey(const Key('continue-button'));
    await tester.ensureVisible(continueFinder);
    await tester.tap(continueFinder);
    await tester.pumpAndSettle();
  }

  testWidgets('English: placement test runs and speaks with the en-US voice',
      (tester) async {
    final tts = FakeTtsAdapter();
    await tester.pumpWidget(appUnderTest('en', tts: tts));
    await tester.pumpAndSettle();

    expect(find.text('English'), findsOneWidget);
    expect(find.text('Take placement test'), findsOneWidget);

    await tester.tap(find.byKey(const Key('start-review-button')));
    await tester.pumpAndSettle();

    expect(find.text('Good morning'), findsOneWidget);
    await tester.tap(find.byKey(const Key('tts-button')));
    await tester.pump();
    expect(tts.spokenCalls.single.voiceHint, 'en-US');

    const natives = [
      'buenos días',
      'buenas tardes',
      'buenas noches',
      'hola',
      'adiós',
      'por favor',
      'gracias',
      'de nada',
      '¿cómo estás?',
      '¿cómo está usted?',
      'mucho gusto',
      'me llamo...',
    ];
    for (final native in natives) {
      await answerCorrectly(tester, native);
    }

    expect(find.byKey(const Key('placement-results')), findsOneWidget);
    expect(find.text('12 / 12 correct'), findsOneWidget);
  });

  testWidgets(
      'Japanese: placement test runs over kanji/kana content and speaks '
      'with the ja-JP voice', (tester) async {
    final tts = FakeTtsAdapter();
    await tester.pumpWidget(appUnderTest('ja', tts: tts));
    await tester.pumpAndSettle();

    expect(find.text('日本語'), findsOneWidget);

    await tester.tap(find.byKey(const Key('start-review-button')));
    await tester.pumpAndSettle();

    expect(find.text('おはようございます'), findsOneWidget);
    await tester.tap(find.byKey(const Key('tts-button')));
    await tester.pump();
    expect(tts.spokenCalls.single, (
      text: 'おはようございます',
      voiceHint: 'ja-JP',
    ));

    // Walk to the first kanji item (i007, お願いします) to confirm it
    // renders like any other item — furigana isn't surfaced in this UI
    // yet, but the kanji target text itself must still round-trip.
    const natives = [
      'good morning',
      'hello / good afternoon',
      'good evening',
      'goodbye',
      'thank you',
      "excuse me / I'm sorry",
    ];
    for (final native in natives) {
      await answerCorrectly(tester, native);
    }
    expect(find.text('お願いします'), findsOneWidget);
  });
}
