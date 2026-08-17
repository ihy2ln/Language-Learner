import '../../core/errors/app_error.dart';
import '../../core/errors/result.dart';
import '../entities/content_bundle.dart';
import '../entities/item.dart';
import '../entities/unit.dart';

/// Abstract read access to downloaded content bundles.
abstract interface class ContentRepository {
  Future<Result<ContentBundle, AppError>> getBundle(String languageCode);
  Future<Result<Unit, AppError>> getUnit(String languageCode, String unitId);
  Future<Result<Item, AppError>> getItem(String languageCode, String itemId);
}
