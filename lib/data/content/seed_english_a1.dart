import '../../domain/entities/entities.dart';

/// English A1 "Greetings and introductions" — the same 12 concepts as
/// the Spanish seed unit, mirrored the other direction.
///
/// The domain model's `Item.native` is "the learner-language gloss", but
/// this app has no learner-L1 selection yet, so there's no single correct
/// gloss language for an English *target* course — English can't sensibly
/// gloss into English. Rather than invent a fake L1 picker for this pass,
/// this course glosses into Spanish (the app's other populated language),
/// which reads as a real, common pairing (a Spanish speaker learning
/// English) instead of an arbitrary placeholder. Swap this for the real
/// per-learner L1 pairing once that exists.
const _unitId = 'en-a1-01';

final List<Item> englishA1GreetingsItems = [
  const Item(
    id: '$_unitId-i001',
    type: ItemType.vocab,
    target: 'Good morning',
    native: 'buenos días',
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i002',
    type: ItemType.vocab,
    target: 'Good afternoon',
    native: 'buenas tardes',
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i003',
    type: ItemType.vocab,
    target: 'Good evening',
    native: 'buenas noches',
    note: 'English distinguishes "good evening" (greeting) from '
        '"good night" (farewell); Spanish "buenas noches" covers both.',
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i004',
    type: ItemType.vocab,
    target: 'Hi',
    native: 'hola',
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i005',
    type: ItemType.vocab,
    target: 'Goodbye',
    native: 'adiós',
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i006',
    type: ItemType.vocab,
    target: 'Please',
    native: 'por favor',
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i007',
    type: ItemType.vocab,
    target: 'Thank you',
    native: 'gracias',
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i008',
    type: ItemType.vocab,
    target: "You're welcome",
    native: 'de nada',
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i009',
    type: ItemType.vocab,
    target: 'How are you?',
    native: '¿cómo estás?',
    note: 'Informal, matching Spanish tú.',
    tags: ['dialect-universal', 'register-informal'],
  ),
  const Item(
    id: '$_unitId-i010',
    type: ItemType.vocab,
    target: 'How are you?',
    native: '¿cómo está usted?',
    note: 'Formal, matching Spanish usted. Accent is a TTS setting, not '
        'a content fork (CONTENT-AUTHORING.md), so the target text is '
        'identical to the informal item above.',
    tags: ['dialect-universal', 'register-formal'],
  ),
  const Item(
    id: '$_unitId-i011',
    type: ItemType.vocab,
    target: 'Nice to meet you',
    native: 'mucho gusto',
    tags: ['dialect-universal', 'register-neutral'],
  ),
  const Item(
    id: '$_unitId-i012',
    type: ItemType.vocab,
    target: 'My name is...',
    native: 'me llamo...',
    tags: ['dialect-universal', 'register-neutral'],
  ),
];

Language englishLanguage() {
  return const Language(
    code: 'en',
    name: 'English',
    nativeName: 'English',
    tier: Tier.tier1Full,
    hasCuratedContent: true,
    hasTts: true,
    hasAsr: false,
    hasPronunciationScoring: false,
    llmCorpusConstrained: false,
    script: Script.latin,
    rtl: false,
    ttsVoiceHint: 'en-US',
  );
}

Unit englishA1GreetingsUnit() {
  return Unit(
    id: _unitId,
    title: 'Greetings and introductions',
    level: Cefr.a1,
    itemIds: [for (final item in englishA1GreetingsItems) item.id],
  );
}

ContentBundle englishA1GreetingsBundle() {
  return ContentBundle(
    languageCode: 'en',
    schemaVersion: 1,
    contentVersion: '2026.01-seed',
    units: [englishA1GreetingsUnit()],
    checksum: 'seed',
  );
}
