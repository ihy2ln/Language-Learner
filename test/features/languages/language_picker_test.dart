import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/data/db/database.dart';
import 'package:linguaforge/data/db/database_provider.dart';
import 'package:linguaforge/features/languages/language_home_screen.dart';
import 'package:linguaforge/features/languages/language_picker_screen.dart';

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
      child: const MaterialApp(home: LanguagePickerScreen()),
    );
  }

  testWidgets('lists all four seeded languages', (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('language-tile-es-419')), findsOneWidget);
    expect(find.byKey(const Key('language-tile-en')), findsOneWidget);
    expect(find.byKey(const Key('language-tile-ja')), findsOneWidget);
    expect(find.byKey(const Key('language-tile-aig')), findsOneWidget);
  });

  testWidgets('a language with curated content opens its language home screen',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('language-tile-ja')));
    await tester.pumpAndSettle();

    expect(find.byType(LanguageHomeScreen), findsOneWidget);
    expect(find.text('日本語'), findsOneWidget);
  });

  testWidgets('Antiguan Creole is shown but disabled, with no content yet',
      (tester) async {
    await tester.pumpWidget(appUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Content coming soon'), findsOneWidget);

    await tester.tap(find.byKey(const Key('language-tile-aig')));
    await tester.pumpAndSettle();

    expect(find.byType(LanguageHomeScreen), findsNothing);
  });
}
