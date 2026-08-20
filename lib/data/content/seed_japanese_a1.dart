import '../../domain/entities/entities.dart';

/// Japanese A1 "Greetings and introductions". Native gloss is English —
/// see seed_english_a1.dart's doc comment on why each course picks a
/// gloss language without a real learner-L1 selector yet.
///
/// CONTENT-AUTHORING.md: "Every item containing kanji requires a
/// furigana field. No exceptions." Applied below — kana-only items
/// correctly have no furigana field at all rather than a redundant one.
const _unitId = 'ja-a1-01';

final List<Item> japaneseA1GreetingsItems = [
  const Item(
    id: '$_unitId-i001',
    type: ItemType.vocab,
    target: 'おはようございます',
    native: 'good morning',
    tags: ['jlpt-n5', 'register-polite'],
  ),
  const Item(
    id: '$_unitId-i002',
    type: ItemType.vocab,
    target: 'こんにちは',
    native: 'hello / good afternoon',
    tags: ['jlpt-n5', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i003',
    type: ItemType.vocab,
    target: 'こんばんは',
    native: 'good evening',
    tags: ['jlpt-n5', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i004',
    type: ItemType.vocab,
    target: 'さようなら',
    native: 'goodbye',
    tags: ['jlpt-n5', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i005',
    type: ItemType.vocab,
    target: 'ありがとうございます',
    native: 'thank you',
    tags: ['jlpt-n5', 'register-polite'],
  ),
  const Item(
    id: '$_unitId-i006',
    type: ItemType.vocab,
    target: 'すみません',
    native: "excuse me / I'm sorry",
    tags: ['jlpt-n5', 'register-polite'],
  ),
  const Item(
    id: '$_unitId-i007',
    type: ItemType.vocab,
    target: 'お願いします',
    furigana: 'おねがいします',
    native: 'please',
    tags: ['jlpt-n5', 'register-polite'],
  ),
  const Item(
    id: '$_unitId-i008',
    type: ItemType.vocab,
    target: '私の名前は...',
    furigana: 'わたしのなまえは...',
    native: 'my name is...',
    tags: ['jlpt-n5', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i009',
    type: ItemType.vocab,
    target: 'はじめまして',
    native: 'nice to meet you',
    tags: ['jlpt-n5', 'register-polite'],
  ),
  const Item(
    id: '$_unitId-i010',
    type: ItemType.vocab,
    target: 'お元気ですか',
    furigana: 'おげんきですか',
    native: 'how are you',
    tags: ['jlpt-n5', 'register-polite'],
  ),
  const Item(
    id: '$_unitId-i011',
    type: ItemType.vocab,
    target: '元気です',
    furigana: 'げんきです',
    native: "I'm fine",
    tags: ['jlpt-n5', 'register-polite'],
  ),
  const Item(
    id: '$_unitId-i012',
    type: ItemType.vocab,
    target: 'どういたしまして',
    native: "you're welcome",
    tags: ['jlpt-n5', 'register-neutral'],
  ),
];

Language japaneseLanguage() {
  return const Language(
    code: 'ja',
    name: 'Japanese',
    nativeName: '日本語',
    tier: Tier.tier1Full,
    hasCuratedContent: true,
    hasTts: true,
    hasAsr: false,
    hasPronunciationScoring: false,
    llmCorpusConstrained: false,
    // ARCHITECTURE.md's Script enum holds one value per language, but the
    // wiki's own capability table lists Japanese script handling as
    // "Kana, Han" — this content mixes both (see the furigana fields
    // above). Picking Han here since kanji glyphs are the ones most
    // likely to render as tofu on an incomplete font fallback chain; kana
    // coverage is close to universal on any Japanese-aware font. A real
    // fix would let a language declare more than one script.
    script: Script.han,
    rtl: false,
    ttsVoiceHint: 'ja-JP',
  );
}

Unit japaneseA1GreetingsUnit() {
  return Unit(
    id: _unitId,
    title: 'Greetings and introductions',
    level: Cefr.a1,
    itemIds: [for (final item in japaneseA1GreetingsItems) item.id],
  );
}

ContentBundle japaneseA1GreetingsBundle() {
  return ContentBundle(
    languageCode: 'ja',
    schemaVersion: 1,
    contentVersion: '2026.01-seed',
    units: [japaneseA1GreetingsUnit()],
    checksum: 'seed',
  );
}
