part of acanvas_commons;

class AcFontUtil {
  /* internals */
  List<String> _fonts = new List();
  static final AcFontUtil _singleton = new AcFontUtil._internal();

  AcFontUtil._internal() {}

  factory AcFontUtil() {
    return _singleton;
  }

  static void addFont(String font) {
    _singleton._fonts.add(font /* + ":300"*/);
  }

  static Future loadFonts() async {
    Completer completer = new Completer<dynamic>();
    var googleFontFamilies = _singleton._fonts;

    js.JsObject webFont = js.context["WebFont"] as js.JsObject;
    js.JsObject webFontConfig = new js.JsObject.jsify({
      "google": {"families": googleFontFamilies},
      "loading": () => print("loading fonts"),
      "active": () => completer.complete(null),
      "inactive": () => completer.completeError("Error loading fonts"),
    });

    //TODO have this not throw ERR_INTERNET_DISCONNECTED when offline
    webFont.callMethod("load", <dynamic>[webFontConfig]);

    await completer.future.catchError((Error e) {
      throw ("Error while loading fonts. ${e}");
    });
  }
}
