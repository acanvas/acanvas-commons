part of stagexl_commons;

class PaperKeyboard extends BoxSprite {
  static const DEFAULT_FONT = "Roboto, Helvetica, Arial";

  /* Parameters */
  int bgColor;
  int textColor;
  int fontSize;

  PaperKeyboard({this.fontSize: 14,
                this.textColor: PaperColor.BLACK,
                String fontName: DEFAULT_FONT})
      : super() {
    _createKeyboard();
  }

  SoftKeyboard _softKeyboard;

  void _createKeyboard() {

    Layout layout = new Qwerty();
    _softKeyboard = new SoftKeyboard([layout]);

    ContextTool.STAGE.addChild(_softKeyboard);
    ContextTool.STAGE.addEventListener(Event.RESIZE, _resizeKeyboard);
    _resizeKeyboard();
  }

  void _resizeKeyboard([Event e = null]) {
    _softKeyboard.span(ContextTool.STAGE.stageWidth, min(ContextTool.STAGE.stageHeight / 2, 400));
    _softKeyboard.y = ContextTool.STAGE.stageHeight - _softKeyboard.spanHeight;
  }

  @override
  void dispose() {
    ContextTool.STAGE.removeEventListener(Event.RESIZE, _resizeKeyboard);
    disposeChild(_softKeyboard);
    _softKeyboard = null;
  }

}
