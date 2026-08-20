import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/repositories.dart';
import '../db/database_provider.dart';
import 'repositories.dart';

final languageRepositoryProvider = Provider<LanguageRepository>((ref) {
  return DriftLanguageRepository(ref.watch(databaseProvider));
});

final contentRepositoryProvider = Provider<ContentRepository>((ref) {
  return DriftContentRepository(ref.watch(databaseProvider));
});

final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  return DriftProgressRepository(ref.watch(databaseProvider));
});

final checkInRepositoryProvider = Provider<CheckInRepository>((ref) {
  return DriftCheckInRepository(ref.watch(databaseProvider));
});
