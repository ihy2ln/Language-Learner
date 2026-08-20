import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/scheduler/grade.dart';
import 'review_session_controller.dart';
import 'review_session_state.dart';

/// Flashcard review session. Always prompts target -> native
/// (Recognition) — this slice doesn't yet vary the prompt direction by
/// the entry's available exercise types (Recall would prompt the other
/// way), which is a real simplification, not an oversight.
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
            return _SessionComplete(reviewedCount: session.reviewedCount);
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

class _Flashcard extends ConsumerWidget {
  const _Flashcard({required this.languageCode, required this.session});

  final String languageCode;
  final ReviewSessionState session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = session.currentItem;
    final controller =
        ref.read(reviewSessionControllerProvider(languageCode).notifier);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            '${session.currentIndex + 1} / ${session.entries.length}',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const Spacer(),
          if (item == null)
            const Text('This entry has no content yet.')
          else ...[
            Text(
              item.target,
              key: const Key('review-target-text'),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            if (session.revealed) ...[
              const SizedBox(height: 16),
              Text(
                item.native,
                key: const Key('review-native-text'),
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              if (item.note != null) ...[
                const SizedBox(height: 8),
                Text(
                  item.note!,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ],
          const Spacer(),
          if (!session.revealed)
            FilledButton(
              key: const Key('reveal-button'),
              onPressed: controller.reveal,
              child: const Text('Show answer'),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _GradeButton(
                  gradeKey: const Key('grade-again'),
                  label: 'Again',
                  onPressed: () => controller.grade(Grade.again),
                ),
                _GradeButton(
                  gradeKey: const Key('grade-hard'),
                  label: 'Hard',
                  onPressed: () => controller.grade(Grade.hard),
                ),
                _GradeButton(
                  gradeKey: const Key('grade-good'),
                  label: 'Good',
                  onPressed: () => controller.grade(Grade.good),
                ),
                _GradeButton(
                  gradeKey: const Key('grade-easy'),
                  label: 'Easy',
                  onPressed: () => controller.grade(Grade.easy),
                ),
              ],
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _GradeButton extends StatelessWidget {
  const _GradeButton({
    required this.gradeKey,
    required this.label,
    required this.onPressed,
  });

  final Key gradeKey;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      key: gradeKey,
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
