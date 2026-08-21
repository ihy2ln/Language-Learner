/// A short, rotating set of real facts about each language, shown on its
/// dashboard. This is general-interest trivia in English, not vocabulary
/// or exercise content — it doesn't touch the native-speaker-authoring
/// requirement CONTENT-AUTHORING.md holds actual course content to.
const Map<String, List<String>> funFactsByLanguage = {
  'es-419': [
    'Spanish is the second most-spoken native language in the world, '
        'after Mandarin Chinese.',
    'More native Spanish speakers live in Mexico than in Spain.',
    'Spanish has a letter English doesn\'t: ñ.',
    'The upside-down ¿ and ¡ were introduced by the Royal Spanish '
        'Academy in the 18th century, so readers know a question or '
        'exclamation is coming before they reach the end of it.',
  ],
  'en': [
    'English has borrowed words from more than 350 other languages.',
    'Counting both native and second-language speakers, English is the '
        'most widely spoken language in the world.',
    '"Set" has more dictionary definitions than any other English word.',
    'A lot of English spelling looks irregular today because of the '
        'Great Vowel Shift — pronunciation changed a lot between the '
        '1400s and 1700s, but spelling mostly didn\'t.',
  ],
  'ja': [
    'Japanese is written with three scripts used together: hiragana, '
        'katakana, and kanji.',
    'Japanese nouns have no grammatical gender and usually no separate '
        'plural form.',
    'Japanese has formal levels of politeness (keigo) built into verb '
        'conjugation itself, not just word choice.',
    'Regional dialects (hōgen) can differ enough from standard Tokyo '
        'Japanese that speakers sometimes can\'t understand each other.',
  ],
};

List<String> funFactsFor(String languageCode) =>
    funFactsByLanguage[languageCode] ?? const [];

/// Picks a deterministic "fact of the day" from [facts] — the same fact
/// all day, a different one (probably) tomorrow, no state to persist.
String? factOfTheDay(List<String> facts, DateTime asOf) {
  if (facts.isEmpty) return null;
  final startOfYear = DateTime(asOf.year, 1, 1);
  final dayOfYear = asOf.difference(startOfYear).inDays;
  return facts[dayOfYear % facts.length];
}
