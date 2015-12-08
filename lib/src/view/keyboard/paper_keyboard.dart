part of stagexl_commons;

class MdKeyboard extends BoxSprite {
  static const DEFAULT_FONT = "Roboto, Helvetica, Arial";

  /* Parameters */
  int bgColor;
  int textColor;
  int fontSize;

  MdKeyboard({this.fontSize: 14,
                this.textColor: MdColor.BLACK,
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

    Rd.STAGE.addChild(_softKeyboard);
    Rd.STAGE.addEventListener(Event.RESIZE, _resizeKeyboard);
    _resizeKeyboard();
  }

  void _resizeKeyboard([Event e = null]) {
    _softKeyboard.span(Rd.STAGE.stageWidth, min(Rd.STAGE.stageHeight / 2, 400));
    _softKeyboard.y = Rd.STAGE.stageHeight - _softKeyboard.spanHeight;
  }

  @override
  void dispose() {
    Rd.STAGE.removeEventListener(Event.RESIZE, _resizeKeyboard);
    _softKeyboard.removeEventListeners(KeyEvent.KEY_UP_VISIBLE);
    _softKeyboard.removeEventListeners(KeyEvent.KEY_UP);
    disposeChild(_softKeyboard);
    _softKeyboard = null;
  }

}
