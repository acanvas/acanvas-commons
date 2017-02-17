part of rockdot_commons;

class Logger implements logging.Logger {
  final logging.Logger _delegate;

  Logger(String name) : _delegate = new logging.Logger(name);

  @override
  String get name => _delegate.name;

  @override
  void log(logging.Level logLevel, dynamic message, [Object error, StackTrace stackTrace, Zone zone]) {
    message = "${name}: ${message}";

    if (error is List) {
      int i = 0;
      error.forEach((Object element) {
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
  void finest(dynamic message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.FINEST, message, error, stackTrace);

  /** Log message at level [logging.Level.FINER]. */
  @override
  void finer(dynamic message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.FINER, message, error, stackTrace);

  /** Log message at level [logging.Level.FINE]. */
  @override
  void fine(dynamic message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.FINE, message, error, stackTrace);

  /** Log message at level [logging.Level.CONFIG]. */
  @override
  void config(dynamic message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.CONFIG, message, error, stackTrace);

  /** Log message at level [logging.Level.INFO]. */
  @override
  void info(dynamic message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.INFO, message, error, stackTrace);

  /** Log message at level [logging.Level.WARNING]. */
  @override
  void warning(dynamic message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.WARNING, message, error, stackTrace);

  /** Log message at level [logging.Level.SEVERE]. */
  @override
  void severe(dynamic message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.SEVERE, message, error, stackTrace);

  /** Log message at level [logging.Level.SHOUT]. */
  @override
  void shout(dynamic message, [Object error, StackTrace stackTrace]) =>
      log(logging.Level.SHOUT, message, error, stackTrace);

  @override
  void clearListeners() => _delegate.clearListeners();

  @override
  bool isLoggable(logging.Level value) => _delegate.isLoggable(value);

  @override
  String get fullName => _delegate.fullName;

  @override
  logging.Level get level => _delegate.level;

  @override
  void set level(logging.Level value) {
    _delegate.level = value;
  }

  @override
  Stream<logging.LogRecord> get onRecord => _delegate.onRecord;

  @override
  Map<String, logging.Logger> get children => _delegate.children;

  @override
  logging.Logger get parent => _delegate.parent;
}
