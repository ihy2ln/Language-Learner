import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/core/errors/app_error.dart';
import 'package:linguaforge/core/errors/result.dart';

void main() {
  group('Result', () {
    test('Ok reports isOk/isErr correctly', () {
      const result = Result<int, AppError>.ok(1);
      expect(result.isOk, isTrue);
      expect(result.isErr, isFalse);
      expect(result.valueOrNull, 1);
      expect(result.errorOrNull, isNull);
    });

    test('Err reports isOk/isErr correctly', () {
      const error = ValidationError('bad');
      const result = Result<int, AppError>.err(error);
      expect(result.isOk, isFalse);
      expect(result.isErr, isTrue);
      expect(result.valueOrNull, isNull);
      expect(result.errorOrNull, error);
    });

    test('when dispatches to the matching branch', () {
      const ok = Result<int, AppError>.ok(2);
      const err = Result<int, AppError>.err(NotFoundError('x'));

      expect(ok.when(ok: (v) => v * 10, err: (_) => -1), 20);
      expect(err.when(ok: (v) => v * 10, err: (_) => -1), -1);
    });

    test('map transforms only the Ok value', () {
      const ok = Result<int, AppError>.ok(3);
      const err = Result<int, AppError>.err(NotFoundError('x'));

      expect(ok.map((v) => v + 1).valueOrNull, 4);
      expect(err.map((v) => v + 1).isErr, isTrue);
    });

    test('mapError transforms only the Err value', () {
      const ok = Result<int, AppError>.ok(3);
      const err = Result<int, AppError>.err(NotFoundError('x'));

      expect(ok.mapError((e) => const UnknownError('wrapped')).valueOrNull, 3);
      expect(
        err.mapError((e) => UnknownError('wrapped: ${e.message}')).errorOrNull,
        isA<UnknownError>(),
      );
    });

    test('equality is value-based', () {
      expect(
        const Result<int, AppError>.ok(1),
        const Result<int, AppError>.ok(1),
      );
      expect(
        const Result<int, AppError>.err(NotFoundError('a')),
        const Result<int, AppError>.err(NotFoundError('a')),
      );
    });
  });
}
