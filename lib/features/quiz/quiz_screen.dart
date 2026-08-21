import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'quiz_controller.dart';
import 'quiz_state.dart';

/// On-demand multiple-choice quiz: a fixed set of questions, a score at
/// the end, no effect on spaced-repetition progress.
class QuizScreen extends ConsumerWidget {
  const QuizScreen({super.key, required this.languageCode});

  final String languageCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizAsync = ref.watch(quizControllerProvider(languageCode));

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: quizAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          key: const Key('quiz-error'),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Could not load quiz: $error'),
          ),
        ),
        data: (quiz) {
          if (quiz.isFinished) {
            return _QuizResults(
              correctCount: quiz.correctCount,
              totalCount: quiz.questions.length,
            );
          }
          return _QuizQuestionCard(languageCode: languageCode, quiz: quiz);
        },
      ),
    );
  }
}

class _QuizResults extends StatelessWidget {
  const _QuizResults({required this.correctCount, required this.totalCount});

  final int correctCount;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Center(
      key: const Key('quiz-results'),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.quiz, size: 48, color: Colors.blue),
            const SizedBox(height: 16),
            Text(
              '$correctCount / $totalCount correct',
              key: const Key('quiz-score'),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuizQuestionCard extends ConsumerStatefulWidget {
  const _QuizQuestionCard({required this.languageCode, required this.quiz});

  final String languageCode;
  final QuizState quiz;

  @override
  ConsumerState<_QuizQuestionCard> createState() => _QuizQuestionCardState();
}

class _QuizQuestionCardState extends ConsumerState<_QuizQuestionCard> {
  String? _selected;

  @override
  void didUpdateWidget(covariant _QuizQuestionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.quiz.currentIndex != widget.quiz.currentIndex) {
      _selected = null;
    }
  }

  void _select(String option) {
    if (_selected != null) return;
    setState(() => _selected = option);
  }

  void _next() {
    final selected = _selected;
    if (selected == null) return;
    final correctAnswer = widget.quiz.currentQuestion!.item.native;
    ref
        .read(quizControllerProvider(widget.languageCode).notifier)
        .answer(wasCorrect: selected == correctAnswer);
  }

  @override
  Widget build(BuildContext context) {
    final quiz = widget.quiz;
    final question = quiz.currentQuestion!;
    final answered = _selected != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Question ${quiz.currentIndex + 1} / ${quiz.questions.length}',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 24),
          Text(
            question.item.target,
            key: const Key('quiz-target-text'),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          for (final option in question.options)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  key: Key('quiz-option-$option'),
                  onPressed: answered ? null : () => _select(option),
                  style: !answered
                      ? null
                      : OutlinedButton.styleFrom(
                          backgroundColor: option == question.item.native
                              ? Colors.green.withValues(alpha: 0.15)
                              : option == _selected
                                  ? Colors.red.withValues(alpha: 0.15)
                                  : null,
                        ),
                  child: Text(option),
                ),
              ),
            ),
          if (answered) ...[
            const SizedBox(height: 16),
            FilledButton(
              key: const Key('quiz-next-button'),
              onPressed: _next,
              child: Text(
                quiz.currentIndex + 1 == quiz.questions.length
                    ? 'See results'
                    : 'Next',
              ),
            ),
          ],
        ],
      ),
    );
  }
}
