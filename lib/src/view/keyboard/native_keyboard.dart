part of rockdot_commons;

class NativeKeyboard extends BoxSprite {
  static const DEFAULT_FONT = "Roboto, Helvetica, Arial";

  /* Parameters */
  int bgColor;
  int textColor;
  int fontSize;
  int rows;
  String fontName;
  bool password;
  bool multiline;
  String text;

  /* The color to be used by active indicators (line, box, floating label) */
  int _highlightColor;

  html.InputElement _htmlElement;
  HtmlObject _htmlTextField;
  StreamSubscription _onKeyDownSubscriber;


  NativeKeyboard(this.text,
                 {this.fontSize: 14,
                this.textColor: MdColor.BLACK,
                this.fontName: DEFAULT_FONT,
                this.multiline: false,
                this.rows: 1,
                this.password: false})
      : super() {
  }

  void createKeyboard() {

    _htmlElement = new html.InputElement();
    _htmlElement.value = text;
    _htmlElement.size = 80;
    _htmlElement.style.fontSize = fontSize.toString();
    _htmlElement.style.font = fontName;

    _onKeyDownSubscriber = _htmlElement.onKeyDown.listen((e){
      dispatchEvent(new KeyEvent(KeyEvent.KEY_UP_VISIBLE, e.keyCode, new String.fromCharCode(e.keyCode)));
    });

    html.querySelector('body').append(_htmlElement);
    _htmlElement.focus();

    _htmlTextField = new HtmlObject(_htmlElement);
    _htmlTextField.visible = true;

    addChild(_htmlTextField);

  }

  String get value => _htmlElement.value;

  @override
  void dispose() {
    removeChild(_htmlTextField);
    _onKeyDownSubscriber.cancel();
    _htmlElement.remove();
    _htmlElement = null;
  }

}
