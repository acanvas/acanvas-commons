part of stagexl_commons;

class Logger implements logging.Logger {
  final logging.Logger _delegate;

  Logger(String name) : _delegate = new logging.Logger(name);

  //noSuchMethod(Invocation invocation) => reflect(_delegate).delegate(invocation);
  String get name => _delegate.name;

  @override
  void log(logging.Level logLevel, String message, [Object error, StackTrace stackTrace, Zone zone]) {
    message = "${name}: ${message}";

    if (error is List) {
      int i = 0;
      error.forEach((element) {
        String str = element.toString();
        i++;
        message = message.replaceFirst(new RegExp('\\{${i.toString()}\\}'), str);
      });
    }

    _delegate.log(logLevel, message);
  }

  /* Proxies for ascommons-logging compatibility */
  void debug(String message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.FINEST, message, error, stackTrace);

  void warn(String message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.WARNING, message, error, stackTrace);

  void error(String message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.SEVERE, message, error, stackTrace);

  /** Log message at level [logging.Level.FINEST]. */
  @override
  void finest(String message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.FINEST, message, error, stackTrace);

  /** Log message at level [logging.Level.FINER]. */
  @override
  void finer(String message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.FINER, message, error, stackTrace);

  /** Log message at level [logging.Level.FINE]. */
  @override
  void fine(String message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.FINE, message, error, stackTrace);

  /** Log message at level [logging.Level.CONFIG]. */
  @override
  void config(String message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.CONFIG, message, error, stackTrace);

  /** Log message at level [logging.Level.INFO]. */
  @override
  void info(String message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.INFO, message, error, stackTrace);

  /** Log message at level [logging.Level.WARNING]. */
  @override
  void warning(String message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.WARNING, message, error, stackTrace);

  /** Log message at level [logging.Level.SEVERE]. */
  @override
  void severe(String message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.SEVERE, message, error, stackTrace);

  /** Log message at level [logging.Level.SHOUT]. */
  @override
  void shout(String message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.SHOUT, message, error, stackTrace);
}
