part of stagexl_commons;

class FontTool {

  /* internals */
  List _fonts = [];
  static final FontTool _singleton = new FontTool._internal();
  FontTool._internal() {
  }

  factory FontTool() {
    return _singleton;
  }
  
  static void addFont(String font) {
    _singleton._fonts.add(font /* + ":300"*/);
  }

  static void loadFonts(Function callback) {
    var completer = new Completer();
    var googleFontFamilies = _singleton._fonts;

    js.JsObject webFont = js.context["WebFont"];
    js.JsObject webFontConfig = new js.JsObject.jsify({
      "google": {
        "families": googleFontFamilies
      },
      "loading": () => print("loading fonts"),
      "active": () => completer.complete(null),
      "inactive": () => completer.completeError("Error loading fonts"),
    });

    if(webFont == null){
      callback.call();
      return;
    }
    webFont.callMethod("load", [webFontConfig]);
    completer.future.then((_) => callback.call());
  }

}
