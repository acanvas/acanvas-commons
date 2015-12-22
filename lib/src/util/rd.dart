part of rockdot_commons;

class Rd {
  /* internals */
  Stage _stage;
  bool _materializeRequired = false;
  static final Rd _singleton = new Rd._internal();

  Rd._internal() {}

  factory Rd() {
    return _singleton;
  }

  static bool get FIREFOX {
    return html.window.navigator.userAgent.toLowerCase().contains(new RegExp('firefox'));
  }

  static bool get MOBILE {
    return html.window.navigator.userAgent
        .contains(new RegExp('Android|OPiOS|CriOS|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini'));
  }

  static bool get CHROME_IOS {
    return html.window.navigator.userAgent.contains(new RegExp('CriOS'));
  }

  static bool get OPERA_IOS {
    return html.window.navigator.userAgent.contains(new RegExp('OPiOS'));
  }

  static bool get TOUCH {
    return html.TouchEvent.supported;
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

  static bool get MATERIALIZE_REQUIRED {
    return _singleton._materializeRequired;
  }

  static void set MATERIALIZE_REQUIRED(bool b) {
    _singleton._materializeRequired = b;
  }
}
