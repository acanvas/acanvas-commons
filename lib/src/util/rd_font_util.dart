part of rockdot_commons;

class RdFontUtil {
  /* internals */
  List<String> _fonts = new List();
  static final RdFontUtil _singleton = new RdFontUtil._internal();

  RdFontUtil._internal() {}

  factory RdFontUtil() {
    return _singleton;
  }

  static void addFont(String font) {
    _singleton._fonts.add(font /* + ":300"*/);
  }

  static Future<bool> loadFonts() async {
    Completer completer = new Completer<dynamic>();
    var googleFontFamilies = _singleton._fonts;

    js.JsObject webFont = js.context["WebFont"] as js.JsObject;
    js.JsObject webFontConfig = new js.JsObject.jsify({
      "google": {"families": googleFontFamilies},
      "loading": () => print("loading fonts"),
      "active": () => completer.complete(null),
      "inactive": () => completer.completeError("Error loading fonts"),
    });

    if (webFont == null) {
      return false;
    }
    webFont.callMethod("load", [webFontConfig]);

    await completer.future.catchError((Error e) {
      throw("Error while loading fonts. ${e}");
    });

    return true;

  }

}
