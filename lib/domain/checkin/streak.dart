/// Pure streak arithmetic over a set of calendar days a learner checked in
/// on — no I/O, no clock reads beyond the [asOf] parameter callers pass in.
///
/// A streak counts unbroken consecutive days ending at [asOf] (today) or,
/// if today hasn't been checked in yet, at yesterday — a streak isn't
/// broken until a full day is skipped with no check-in.
int currentStreak(List<DateTime> checkInDates, {required DateTime asOf}) {
  final days = checkInDates.map(_dateOnly).toSet();
  var cursor = _dateOnly(asOf);

  if (!days.contains(cursor)) {
    final yesterday = cursor.subtract(const Duration(days: 1));
    if (!days.contains(yesterday)) return 0;
    cursor = yesterday;
  }

  var streak = 0;
  while (days.contains(cursor)) {
    streak++;
    cursor = cursor.subtract(const Duration(days: 1));
  }
  return streak;
}

DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
