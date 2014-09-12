part of dart_commons;


class RockdotLogger implements Logger {


  final Logger _delegate;

  RockdotLogger(String name) : _delegate = new Logger(name);

  noSuchMethod(Invocation invocation) => reflect(_delegate).delegate(invocation);

  @override
  void log(Level logLevel, String message, [Object error, StackTrace stackTrace]) {

    message = name + ": " + message;

    if (error is List) {
      List list = error;
      for (int i = 0; i < list.length; i++) {
        //message.split("{"+i.toString()+"}").join(list.elementAt(i).toString());
        String str = list.elementAt(i).toString();
        String istr = i.toString();
        
        message = message.replaceFirst(new RegExp('\\{'+i.toString()+'\\}'), str);
      }
    }

    _delegate.log(logLevel, message);
  }
  
  /* Proxies for ascommons-logging compatibility */
  void debug(String message, [Object error, StackTrace stackTrace]) => log(Level.FINEST, message, error, stackTrace); 
  void warn(String message, [Object error, StackTrace stackTrace]) => log(Level.WARNING, message, error, stackTrace); 
  void error(String message, [Object error, StackTrace stackTrace]) => log(Level.SEVERE, message, error, stackTrace); 


  /** Log message at level [Level.FINEST]. */
  @override
  void finest(String message, [Object error, StackTrace stackTrace]) => log(Level.FINEST, message, error, stackTrace);

  /** Log message at level [Level.FINER]. */
  @override
  void finer(String message, [Object error, StackTrace stackTrace]) => log(Level.FINER, message, error, stackTrace);

  /** Log message at level [Level.FINE]. */
  @override
  void fine(String message, [Object error, StackTrace stackTrace]) => log(Level.FINE, message, error, stackTrace);

  /** Log message at level [Level.CONFIG]. */
  @override
  void config(String message, [Object error, StackTrace stackTrace]) => log(Level.CONFIG, message, error, stackTrace);

  /** Log message at level [Level.INFO]. */
  @override
  void info(String message, [Object error, StackTrace stackTrace]) => log(Level.INFO, message, error, stackTrace);

  /** Log message at level [Level.WARNING]. */
  @override
  void warning(String message, [Object error, StackTrace stackTrace]) => log(Level.WARNING, message, error, stackTrace);

  /** Log message at level [Level.SEVERE]. */
  @override
  void severe(String message, [Object error, StackTrace stackTrace]) => log(Level.SEVERE, message, error, stackTrace);

  /** Log message at level [Level.SHOUT]. */
  @override
  void shout(String message, [Object error, StackTrace stackTrace]) => log(Level.SHOUT, message, error, stackTrace);

}
