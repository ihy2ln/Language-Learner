/// Minimal logging seam — lets tests capture output instead of writing to
/// stdout, and keeps callers from depending on `print` directly.
abstract interface class Logger {
  void log(String message);
}

class PrintLogger implements Logger {
  const PrintLogger();

  @override
  void log(String message) {
    // ignore: avoid_print
    print(message);
  }
}
