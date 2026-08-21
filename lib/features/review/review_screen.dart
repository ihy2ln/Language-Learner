import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/exercise/exercise.dart';
import '../../domain/placement/placement_result.dart';
import '../../providers/speech/speech_providers.dart';
import 'review_session_controller.dart';
import 'review_session_state.dart';

/// Review session. Always prompts target -> native (Recognition) — this
/// slice doesn't yet vary the prompt direction by the entry's available
/// exercise types (Recall would prompt the other way), a real
/// simplification, not an oversight.
///
/// The exercise format adapts to how many times the item has been lapsed
/// (domain/exercise/exercise_format.dart): easy/medium items (never
/// lapsed) are multiple choice, hard/very hard items (lapsed at least
/// once) require typing the answer. Correctness is detected
/// automatically rather than self-reported, and maps straight to a
/// Good/Again grade.
class ReviewScreen extends ConsumerWidget {
  const ReviewScreen({super.key, required this.languageCode});

  final String languageCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync =
        ref.watch(reviewSessionControllerProvider(languageCode));

    return Scaffold(
      appBar: AppBar(title: const Text('Review')),
      body: sessionAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          key: const Key('review-error'),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Could not load review session: $error'),
          ),
        ),
        data: (session) {
          if (session.isFinished) {
            return session.isPlacementTest
                ? _PlacementResults(session: session)
                : _SessionComplete(reviewedCount: session.reviewedCount);
          }
          return _Flashcard(languageCode: languageCode, session: session);
        },
      ),
    );
  }
}

class _SessionComplete extends StatelessWidget {
  const _SessionComplete({required this.reviewedCount});

  final int reviewedCount;

  @override
  Widget build(BuildContext context) {
    return Center(
      key: const Key('session-complete'),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 48, color: Colors.green),
            const SizedBox(height: 16),
            Text('Session complete — reviewed $reviewedCount item(s).'),
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

class _PlacementResults extends StatelessWidget {
  const _PlacementResults({required this.session});

  final ReviewSessionState session;

  @override
  Widget build(BuildContext context) {
    final result = computePlacementResult(
      correctCount: session.correctCount,
      totalCount: session.reviewedCount,
    );
    final bandLabel = switch (result.band) {
      PlacementBand.beginner => 'Beginner — just getting started',
      PlacementBand.developing => 'Developing — you know some of this',
      PlacementBand.confident => 'Confident — you know most of this',
    };

    return Center(
      key: const Key('placement-results'),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.flag_circle, size: 48, color: Colors.blue),
            const SizedBox(height: 16),
            const Text(
              'Placement test complete',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              '${session.correctCount} / ${session.reviewedCount} correct',
              key: const Key('placement-score'),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              bandLabel,
              key: const Key('placement-band'),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 16),
            Text(
              result.planSummary,
              key: const Key('placement-plan'),
              textAlign: TextAlign.center,
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

class _Flashcard extends ConsumerStatefulWidget {
  const _Flashcard({required this.languageCode, required this.session});

  final String languageCode;
  final ReviewSessionState session;

  @override
  ConsumerState<_Flashcard> createState() => _FlashcardState();
}

class _FlashcardState extends ConsumerState<_Flashcard> {
  String? _selectedOption;
  bool? _wasCorrect;
  List<String>? _mcOptions;
  final _typedController = TextEditingController();

  @override
  void didUpdateWidget(covariant _Flashcard oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldItemId = oldWidget.session.currentEntry?.itemId;
    final newItemId = widget.session.currentEntry?.itemId;
    if (oldItemId != newItemId) {
      _selectedOption = null;
      _wasCorrect = null;
      _mcOptions = null;
      _typedController.clear();
    }
  }

  @override
  void dispose() {
    _typedController.dispose();
    super.dispose();
  }

  void _selectOption(String option, String correctAnswer) {
    if (_wasCorrect != null) return;
    setState(() {
      _selectedOption = option;
      _wasCorrect = option == correctAnswer;
    });
  }

  void _submitTyped(List<String> acceptedAnswers) {
    if (_wasCorrect != null) return;
    setState(() {
      _wasCorrect = isCorrectAnswer(_typedController.text, acceptedAnswers);
    });
  }

  void _continue() {
    final wasCorrect = _wasCorrect;
    if (wasCorrect == null) return;
    ref
        .read(reviewSessionControllerProvider(widget.languageCode).notifier)
        .submitAnswer(wasCorrect: wasCorrect);
  }

  @override
  Widget build(BuildContext context) {
    final session = widget.session;
    final item = session.currentItem;
    final language = session.language;

    if (item == null) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: Text('This entry has no content yet.')),
      );
    }

    final format = exerciseFormatFor(lapses: session.currentLapses);
    if (format == ExerciseFormat.multipleChoice) {
      _mcOptions ??= buildMultipleChoiceOptions(
        correctAnswer: item.native,
        pool: [
          for (final other in session.itemsById.values)
            if (other.id != item.id) other.native,
        ],
      );
    }

    final answered = _wasCorrect != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${session.currentIndex + 1} / ${session.entries.length}',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 24),
          Text(
            item.target,
            key: const Key('review-target-text'),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          // Capability is read from data (CLAUDE.md hard rule #6) — no TTS
          // button at all for a language with hasTts: false, not a
          // disabled one.
          if (language.hasTts) ...[
            const SizedBox(height: 4),
            IconButton(
              key: const Key('tts-button'),
              icon: const Icon(Icons.volume_up),
              tooltip: 'Play pronunciation',
              onPressed: () {
                ref.read(ttsAdapterProvider).speak(
                      item.target,
                      voiceHint: language.ttsVoiceHint ?? language.code,
                    );
              },
            ),
          ],
          const SizedBox(height: 24),
          if (format == ExerciseFormat.multipleChoice)
            _MultipleChoiceOptions(
              options: _mcOptions!,
              correctAnswer: item.native,
              selected: _selectedOption,
              onSelect: (option) => _selectOption(option, item.native),
            )
          else
            _TypedAnswerField(
              controller: _typedController,
              enabled: !answered,
              onSubmit: () => _submitTyped(item.answerVariants),
            ),
          if (answered) ...[
            const SizedBox(height: 16),
            _AnswerFeedback(wasCorrect: _wasCorrect!, correctAnswer: item.native),
            if (item.note != null) ...[
              const SizedBox(height: 8),
              Text(
                item.note!,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 16),
            FilledButton(
              key: const Key('continue-button'),
              onPressed: _continue,
              child: const Text('Continue'),
            ),
          ],
        ],
      ),
    );
  }
}

class _MultipleChoiceOptions extends StatelessWidget {
  const _MultipleChoiceOptions({
    required this.options,
    required this.correctAnswer,
    required this.selected,
    required this.onSelect,
  });

  final List<String> options;
  final String correctAnswer;
  final String? selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final answered = selected != null;
    return Column(
      children: [
        for (final option in options)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                key: Key('mc-option-$option'),
                onPressed: answered ? null : () => onSelect(option),
                style: !answered
                    ? null
                    : OutlinedButton.styleFrom(
                        backgroundColor: option == correctAnswer
                            ? Colors.green.withValues(alpha: 0.15)
                            : option == selected
                                ? Colors.red.withValues(alpha: 0.15)
                                : null,
                      ),
                child: Text(option),
              ),
            ),
          ),
      ],
    );
  }
}

class _TypedAnswerField extends StatelessWidget {
  const _TypedAnswerField({
    required this.controller,
    required this.enabled,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final bool enabled;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          key: const Key('typed-answer-field'),
          controller: controller,
          enabled: enabled,
          textAlign: TextAlign.center,
          onSubmitted: enabled ? (_) => onSubmit() : null,
          decoration: const InputDecoration(hintText: 'Type the answer'),
        ),
        const SizedBox(height: 12),
        FilledButton(
          key: const Key('submit-typed-button'),
          onPressed: enabled ? onSubmit : null,
          child: const Text('Check'),
        ),
      ],
    );
  }
}

class _AnswerFeedback extends StatelessWidget {
  const _AnswerFeedback({required this.wasCorrect, required this.correctAnswer});

  final bool wasCorrect;
  final String correctAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          wasCorrect ? Icons.check_circle : Icons.cancel,
          color: wasCorrect ? Colors.green : Colors.red,
          size: 32,
        ),
        const SizedBox(height: 4),
        Text(
          wasCorrect ? 'Correct!' : 'Not quite — it\'s "$correctAnswer".',
          key: const Key('answer-feedback'),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
