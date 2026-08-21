import 'package:flutter_test/flutter_test.dart';
import 'package:linguaforge/domain/exercise/answer_matching.dart';

void main() {
  test('an exact match is correct', () {
    expect(isCorrectAnswer('hi', ['hi', 'hello']), isTrue);
  });

  test('any accepted variation is correct', () {
    expect(isCorrectAnswer('hello', ['hi', 'hello']), isTrue);
  });

  test('is case-insensitive', () {
    expect(isCorrectAnswer('HELLO', ['hello']), isTrue);
  });

  test('ignores surrounding whitespace', () {
    expect(isCorrectAnswer('  hello  ', ['hello']), isTrue);
  });

  test('ignores apostrophes and terminal punctuation', () {
    expect(isCorrectAnswer('youre welcome', ["you're welcome"]), isTrue);
    expect(isCorrectAnswer("you're welcome!", ["you're welcome"]), isTrue);
    expect(isCorrectAnswer('how are you', ['how are you?']), isTrue);
  });

  test('collapses internal whitespace runs', () {
    expect(isCorrectAnswer('good   morning', ['good morning']), isTrue);
  });

  test('a real misspelling is wrong', () {
    expect(isCorrectAnswer('helo', ['hello']), isFalse);
  });

  test('an unrelated word is wrong', () {
    expect(isCorrectAnswer('goodbye', ['hi', 'hello']), isFalse);
  });

  test('empty accepted-answer list never matches', () {
    expect(isCorrectAnswer('anything', []), isFalse);
  });
}
