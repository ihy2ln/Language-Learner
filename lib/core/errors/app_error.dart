/// Base type for errors that cross a layer boundary.
///
/// Layers return `Result<T, AppError>` instead of throwing so that callers
/// are forced to handle failure explicitly. See `core/errors/result.dart`.
sealed class AppError {
  const AppError(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

class NetworkError extends AppError {
  const NetworkError(super.message);
}

class StorageError extends AppError {
  const StorageError(super.message);
}

class ValidationError extends AppError {
  const ValidationError(super.message);
}

class NotFoundError extends AppError {
  const NotFoundError(super.message);
}

class UnknownError extends AppError {
  const UnknownError(super.message);
}
