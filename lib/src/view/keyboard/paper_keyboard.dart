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

    _softKeyboard.addEventListener(KeyEvent.KEY_UP_VISIBLE, (KeyEvent e) {
      dispatchEvent(e);
    });
    _softKeyboard.addEventListener(KeyEvent.KEY_UP, (KeyEvent e) {
      dispatchEvent(e);
    });

    RdEnvironment.STAGE.addChild(_softKeyboard);
    RdEnvironment.STAGE.addEventListener(Event.RESIZE, _resizeKeyboard);
    _resizeKeyboard();
  }

  void _resizeKeyboard([Event e = null]) {
    _softKeyboard.span(RdEnvironment.STAGE.stageWidth, min(RdEnvironment.STAGE.stageHeight / 2, 400));
    _softKeyboard.y = RdEnvironment.STAGE.stageHeight - _softKeyboard.spanHeight;
  }

  @override
  void dispose() {
    RdEnvironment.STAGE.removeEventListener(Event.RESIZE, _resizeKeyboard);
    _softKeyboard.removeEventListeners(KeyEvent.KEY_UP_VISIBLE);
    _softKeyboard.removeEventListeners(KeyEvent.KEY_UP);
    disposeChild(_softKeyboard);
    _softKeyboard = null;
  }

}
