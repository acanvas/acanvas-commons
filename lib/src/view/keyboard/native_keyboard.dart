part of acanvas_commons;

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
  String text = "";
  String label = "";

  /* The color to be used by active indicators (line, box, floating label) */
  int _highlightColor;

  html.InputElement _htmlInputElement;
  html.TextAreaElement _htmlTextAreaElement;
  HtmlObject _htmlSprite;
  StreamSubscription _onKeyDownSubscriber;

  NativeKeyboard(this.text, this.label,
      {this.fontSize: 14,
      this.textColor: MdColor.BLACK,
      this.fontName: DEFAULT_FONT,
      this.multiline: false,
      this.rows: 3,
      this.password: false})
      : super() {}

  void refresh() {
    super.refresh();

    if (_htmlTextAreaElement != null) {
      _htmlTextAreaElement.style.width = "${spanWidth}px";
      // _htmlTextAreaElement.style.height = "${spanHeight}px";
    } else if (_htmlInputElement != null) {
      _htmlInputElement.style.width = "${spanWidth}px";
      //_htmlInputElement.style.height = "${spanHeight}px";
    }
  }

  void createKeyboard() {
    html.HtmlElement htmlElement;

    if (multiline) {
      _htmlTextAreaElement = new html.TextAreaElement();
      _htmlTextAreaElement.rows = rows;
      if (text == "") {
        _htmlTextAreaElement.placeholder = label;
      } else {
        _htmlTextAreaElement.value = text;
      }
      htmlElement = _htmlTextAreaElement;
    } else {
      _htmlInputElement = new html.InputElement();
      _htmlInputElement.size = 60;
      if (text == "") {
        _htmlInputElement.placeholder = label;
      } else {
        _htmlInputElement.value = text;
      }
      htmlElement = _htmlInputElement;
    }

    htmlElement.style.fontSize = fontSize.toString();
    htmlElement.style.font = fontName;
    //_htmlElement.value = text;

    _onKeyDownSubscriber = htmlElement.onKeyUp.listen((e) {
      dispatchEvent(new KeyEvent(KeyEvent.KEY_UP_VISIBLE, e.keyCode,
          new String.fromCharCode(e.keyCode)));
    });

    html.querySelector('body').append(htmlElement);
    htmlElement.focus();

    _htmlSprite = new HtmlObject(htmlElement);
    _htmlSprite.visible = true;

    addChild(_htmlSprite);
  }

  String get value {
    if (_htmlInputElement != null) {
      return _htmlInputElement.value;
    } else if (_htmlTextAreaElement != null) {
      return _htmlTextAreaElement.value;
    } else {
      return "";
    }
  }

  @override
  void dispose({bool removeSelf: true}) {
    removeChild(_htmlSprite);
    _onKeyDownSubscriber.cancel();
    _htmlInputElement?.remove();
    _htmlTextAreaElement?.remove();
    _htmlInputElement = null;
  }

  void setWidth(num spanWidth) {
    if (_htmlTextAreaElement != null) {
      _htmlTextAreaElement.cols = spanWidth.ceil();
    }
  }
}
