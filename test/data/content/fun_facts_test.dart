import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/data/content/fun_facts.dart';

void main() {
  test('every seeded curated language has fun facts', () {
    for (final code in ['es-419', 'en', 'ja']) {
      expect(funFactsFor(code), isNotEmpty);
    }
  });

  test('an unknown language code has no facts', () {
    expect(funFactsFor('xx'), isEmpty);
  });

  group('factOfTheDay', () {
    const facts = ['a', 'b', 'c'];

    test('is null for an empty list', () {
      expect(factOfTheDay(const [], DateTime(2026, 1, 1)), isNull);
    });

    test('is the same fact all day', () {
      final morning = factOfTheDay(facts, DateTime(2026, 3, 10, 6));
      final night = factOfTheDay(facts, DateTime(2026, 3, 10, 23));
      expect(morning, night);
    });

    test('picks deterministically by day of year', () {
      // Jan 1 is day 0 -> facts[0].
      expect(factOfTheDay(facts, DateTime(2026, 1, 1)), 'a');
      // Jan 2 is day 1 -> facts[1].
      expect(factOfTheDay(facts, DateTime(2026, 1, 2)), 'b');
      // Jan 4 is day 3 -> wraps back to facts[0].
      expect(factOfTheDay(facts, DateTime(2026, 1, 4)), 'a');
    });
  });
}
