import 'dart:math';

/// Picks up to [count] items at random from [items], without repeats —
/// the question set for one standalone quiz round. Shorter than [count]
/// only when [items] itself is shorter.
///
/// [random] is injectable for deterministic tests; production callers
/// leave it unset.
List<T> pickRandomItems<T>(List<T> items, {int count = 8, Random? random}) {
  final pool = List<T>.from(items)..shuffle(random ?? Random());
  return pool.take(count).toList();
}
