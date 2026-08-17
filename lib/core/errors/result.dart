/// A value that is either a success (`Ok`) or a failure (`Err`).
///
/// Layer boundaries return `Result<T, E>` rather than throwing, per the
/// project convention in CLAUDE.md.
sealed class Result<T, E> {
  const Result();

  const factory Result.ok(T value) = Ok<T, E>;
  const factory Result.err(E error) = Err<T, E>;

  bool get isOk => this is Ok<T, E>;
  bool get isErr => this is Err<T, E>;

  /// Returns the success value, or `null` if this is an [Err].
  T? get valueOrNull => switch (this) {
        Ok<T, E>(value: final v) => v,
        Err<T, E>() => null,
      };

  /// Returns the error, or `null` if this is an [Ok].
  E? get errorOrNull => switch (this) {
        Ok<T, E>() => null,
        Err<T, E>(error: final e) => e,
      };

  R when<R>({
    required R Function(T value) ok,
    required R Function(E error) err,
  }) =>
      switch (this) {
        Ok<T, E>(value: final v) => ok(v),
        Err<T, E>(error: final e) => err(e),
      };

  Result<R, E> map<R>(R Function(T value) transform) => switch (this) {
        Ok<T, E>(value: final v) => Result.ok(transform(v)),
        Err<T, E>(error: final e) => Result.err(e),
      };

  Result<T, R> mapError<R>(R Function(E error) transform) => switch (this) {
        Ok<T, E>(value: final v) => Result.ok(v),
        Err<T, E>(error: final e) => Result.err(transform(e)),
      };
}

final class Ok<T, E> extends Result<T, E> {
  const Ok(this.value);
  final T value;

  @override
  bool operator ==(Object other) => other is Ok<T, E> && other.value == value;

  @override
  int get hashCode => Object.hash(Ok, value);
}

final class Err<T, E> extends Result<T, E> {
  const Err(this.error);
  final E error;

  @override
  bool operator ==(Object other) => other is Err<T, E> && other.error == error;

  @override
  int get hashCode => Object.hash(Err, error);
}
