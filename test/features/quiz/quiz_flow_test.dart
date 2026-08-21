import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/data/db/database.dart';
import 'package:linguaforge/data/db/database_provider.dart';
import 'package:linguaforge/features/quiz/quiz_controller.dart';
import 'package:linguaforge/features/quiz/quiz_screen.dart';

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
        home: QuizScreen(languageCode: 'es-419'),
      ),
    );
  }

  /// Taps whichever option renders first, then Next — enough to drive
  /// navigation forward without caring whether the answer was right.
  Future<void> answerAndAdvance(WidgetTester tester) async {
    await tester.tap(find.byType(OutlinedButton).first);
    await tester.pump();
    final nextButton = find.byKey(const Key('quiz-next-button'));
    await tester.ensureVisible(nextButton);
    await tester.tap(nextButton);
    await tester.pumpAndSettle();
  }

  testWidgets('a quiz has 8 questions with 4 options each', (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Question 1 / 8'), findsOneWidget);
    expect(find.byKey(const Key('quiz-target-text')), findsOneWidget);
    expect(find.byType(OutlinedButton), findsNWidgets(4));
  });

  testWidgets('selecting an option shows Next, then advances the question',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('quiz-next-button')), findsNothing);
    await answerAndAdvance(tester);

    expect(find.text('Question 2 / 8'), findsOneWidget);
  });

  testWidgets('answering all 8 questions reaches a score screen',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    for (var i = 0; i < 8; i++) {
      expect(find.byKey(const Key('quiz-results')), findsNothing);
      await answerAndAdvance(tester);
    }

    expect(find.byKey(const Key('quiz-results')), findsOneWidget);
    expect(find.byKey(const Key('quiz-score')), findsOneWidget);
  });

  testWidgets('Done on the score screen returns to the caller',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    for (var i = 0; i < 8; i++) {
      await answerAndAdvance(tester);
    }
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    expect(find.byType(QuizScreen), findsNothing);
  });

  testWidgets('always answering correctly scores full marks', (tester) async {
    final container = ProviderContainer(overrides: [
      databaseProvider.overrideWithValue(AppDatabase(NativeDatabase.memory())),
    ]);
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: QuizScreen(languageCode: 'es-419')),
      ),
    );
    await tester.pumpAndSettle();

    for (var i = 0; i < 8; i++) {
      final quiz = container.read(quizControllerProvider('es-419')).value!;
      final correctAnswer = quiz.currentQuestion!.item.native;

      final optionFinder = find.byKey(Key('quiz-option-$correctAnswer'));
      await tester.ensureVisible(optionFinder);
      await tester.tap(optionFinder);
      await tester.pump();

      final nextButton = find.byKey(const Key('quiz-next-button'));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
    }

    expect(find.text('8 / 8 correct'), findsOneWidget);
  });
}
