/// Primary writing system of a [Language].
///
/// Matches the set named in ARCHITECTURE.md's data model comment. The font
/// fallback chain (ui/tokens, later milestone) must cover a broader set
/// (also Greek and Hebrew) — that's an app-wide rendering concern, not a
/// per-language field.
enum Script {
  latin,
  kana,
  han,
  hangul,
  cyrillic,
  arabic,
  devanagari,
}
