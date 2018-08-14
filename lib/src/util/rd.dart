part of acanvas_commons;

class Ac {
  /* internals */
  Logger _logger;
  Stage _stage;
  static final Ac _singleton = new Ac._internal();

  Ac._internal() {
    _logger = new Logger('Ac');
  }

  factory Ac() {
    return _singleton;
  }

  static Logger get log => _singleton._logger;

  static bool get FIREFOX {
    return html.window.navigator.userAgent
        .toLowerCase()
        .contains(new RegExp('firefox'));
  }

  static bool get MOBILE {
    return html.window.navigator.userAgent.contains(new RegExp(
        'Android|OPiOS|CriOS|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini'));
  }

  static bool get IOS {
    return html.window.navigator.userAgent
        .contains(new RegExp('iOS|iPhone|iPad|iPod'));
  }

  static bool get CHROME_IOS {
    return html.window.navigator.userAgent.contains(new RegExp('CriOS'));
  }

  static bool get OPERA_IOS {
    return html.window.navigator.userAgent.contains(new RegExp('OPiOS'));
  }

  static bool get TOUCH {
    return MOBILE; //html.TouchEvent.supported; <-- always returns true in SDK 1.24.1
  }

  static bool get WEBGL {
    return _singleton._stage.renderEngine == RenderEngine.WebGL ? true : false;
  }

  static Stage get STAGE {
    return _singleton._stage;
  }

  static void set STAGE(Stage stage) {
    _singleton._stage = stage;
  }

  static Juggler get JUGGLER {
    return _singleton._stage.juggler;
  }

  static void set MATERIALIZE_REQUIRED(bool b) {
    if (b && STAGE.renderMode != StageRenderMode.AUTO) {
      STAGE.renderMode = StageRenderMode.ONCE;
    }
    ;
  }
}
