/// A review outcome, matching the Again/Hard/Good/Easy buttons in the
/// review UI mock in the wiki.
enum Grade {
  again(1),
  hard(2),
  good(3),
  easy(4);

  const Grade(this.value);

  /// 1-4, as used directly in the FSRS weight-vector indexing.
  final int value;
}
