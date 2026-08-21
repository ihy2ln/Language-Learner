import 'item_type.dart';

/// A single content item (vocab word, sentence, grammar point, listening
/// clip, or pronunciation prompt) within a [Unit].
///
/// **Item IDs are permanent.** [UserProgress] references them by id;
/// renumbering discards a learner's review history
/// (CONTENT-AUTHORING.md). Correcting an item's content in place is fine.
class Item {
  const Item({
    required this.id,
    required this.type,
    required this.target,
    required this.native,
    this.audioRef,
    this.altSpelling,
    this.furigana,
    this.pinyin,
    this.pitchAccent,
    this.tags = const [],
    this.note,
    this.acceptedAnswers = const [],
  });

  final String id;
  final ItemType type;

  /// Text in the language being learned.
  final String target;

  /// Learner-language gloss.
  final String native;

  /// Other typed-answer spellings/phrasings that count as correct for this
  /// item (e.g. "hi" and "hello" both glossing the same target word).
  /// Usually left empty — [answerVariants] falls back to [native] alone,
  /// so authoring this is opt-in, not required for every item.
  final List<String> acceptedAnswers;

  /// What a typed answer is actually checked against — [acceptedAnswers]
  /// when authored, otherwise just [native].
  List<String> get answerVariants =>
      acceptedAnswers.isEmpty ? [native] : acceptedAnswers;

  /// Asset or downloaded file path, relative to the bundle root.
  final String? audioRef;

  /// Antiguan Creole: English-etymological reference spelling, alongside
  /// the frozen Cassidy-JLU orthography in [target].
  final String? altSpelling;

  /// Japanese: required on every item containing kanji.
  final String? furigana;

  /// Mandarin.
  final String? pinyin;

  /// Japanese, where contrastive.
  final String? pitchAccent;

  /// e.g. jlpt-n5, register-formal, dialect-latam.
  final List<String> tags;

  final String? note;
}
