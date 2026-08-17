import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database.dart';

/// Singleton [AppDatabase] connection, closed when the provider is
/// disposed (effectively app lifetime).
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
