import '../../domain/entities/entities.dart';

/// Minimal hand-authored Spanish A1 "Greetings and introductions" unit,
/// used to seed the database on first launch so the review loop has
/// something real to exercise end to end.
///
/// This stands in for the real content-bundle pipeline (JSON download,
/// checksum, versioning — CONTENT-AUTHORING.md), which is out of scope
/// here. IDs follow that doc's convention (`es-a1-01-i001`, ...) so
/// swapping this for a downloaded bundle later doesn't require
/// renumbering anything a learner has already reviewed.
const _unitId = 'es-a1-01';

final List<Item> spanishA1GreetingsItems = [
  const Item(
    id: '$_unitId-i001',
    type: ItemType.vocab,
    target: 'buenos días',
    native: 'good morning',
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i002',
    type: ItemType.vocab,
    target: 'buenas tardes',
    native: 'good afternoon',
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i003',
    type: ItemType.vocab,
    target: 'buenas noches',
    native: 'good night',
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i004',
    type: ItemType.vocab,
    target: 'hola',
    native: 'hi',
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i005',
    type: ItemType.vocab,
    target: 'adiós',
    native: 'goodbye',
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i006',
    type: ItemType.vocab,
    target: 'por favor',
    native: 'please',
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i007',
    type: ItemType.vocab,
    target: 'gracias',
    native: 'thank you',
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i008',
    type: ItemType.vocab,
    target: 'de nada',
    native: "you're welcome",
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i009',
    type: ItemType.vocab,
    target: '¿cómo estás?',
    native: 'how are you',
    note: 'Informal — tú.',
    tags: ['dialect-universal', 'register-informal'],
  ),
  const Item(
    id: '$_unitId-i010',
    type: ItemType.vocab,
    target: '¿cómo está usted?',
    native: 'how are you',
    note: 'Formal — usted.',
    tags: ['dialect-universal', 'register-formal'],
  ),
  const Item(
    id: '$_unitId-i011',
    type: ItemType.vocab,
    target: 'mucho gusto',
    native: 'nice to meet you',
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i012',
    type: ItemType.vocab,
    target: 'me llamo...',
    native: 'my name is...',
    tags: ['dialect-universal', 'register-neutral'],
  ),
];

Language spanishLanguage() {
  return const Language(
    code: 'es-419',
    name: 'Spanish',
    nativeName: 'Español',
    tier: Tier.tier1Full,
    hasCuratedContent: true,
    // Device TTS is wired up (providers/speech); ASR/pronunciation scoring
    // are not — false there is honest, not a placeholder, per CLAUDE.md
    // hard rule #6: capability is read from data.
    hasTts: true,
    hasAsr: false,
    hasPronunciationScoring: false,
    llmCorpusConstrained: false,
    script: Script.latin,
    rtl: false,
    ttsVoiceHint: 'es-MX',
  );
}

Unit spanishA1GreetingsUnit() {
  return Unit(
    id: _unitId,
    title: 'Greetings and introductions',
    level: Cefr.a1,
    itemIds: [for (final item in spanishA1GreetingsItems) item.id],
  );
}

ContentBundle spanishA1GreetingsBundle() {
  return ContentBundle(
    languageCode: 'es-419',
    schemaVersion: 1,
    contentVersion: '2026.01-seed',
    units: [spanishA1GreetingsUnit()],
    checksum: 'seed',
  );
}
