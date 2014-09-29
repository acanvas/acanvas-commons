part of dart_commons;



class ContextTool {

  /* internals */
  Stage _stage;
  bool _webgl = false;
  static final ContextTool _singleton = new ContextTool._internal();
  ContextTool._internal() {
  }

  factory ContextTool() {
      return _singleton;
  }
  
  static bool get WEBGL {
    return _singleton._webgl;
  }
  static void set WEBGL(bool gl) {
    _singleton._webgl = gl;
  }

  static Stage get STAGE {
    return _singleton._stage;
  }
  static void set STAGE(Stage stage) {
    _singleton._stage = stage;
  }

}
