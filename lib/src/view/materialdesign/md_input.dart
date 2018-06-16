part of acanvas_commons;

class MdInput extends BehaveSprite {
  static const DEFAULT_FONT = "Roboto, Helvetica, Arial";

  /* Parameters */
  int textColor;
  int fontSize;
  bool floating;
  bool keyboard;
  bool password;
  bool multiline;
  String required;
  int rows;
  String fontName;

  /* The color to be used by active indicators (line, box, floating label) */
  int _highlightColor;

  /* TextFields */
  UITextFieldInput _inputTextField;
  UITextField _defaultTextField;
  UITextField _requiredTextField;

  /* Warning Icons for mandatory fields */
  SvgDisplayObject _requiredIconInactive;
  SvgDisplayObject _requiredIconActive;

  /* Lines, Box */
  Shape _activeLine;
  Shape _inactiveLine;
  Shape _cursorBox;

  /* bool to indicate if label is currently floating */
  bool _currentlyFloating = false;

  bool KEYBOARD_NATIVE = true;

  String label = "";

  StreamSubscription<Event> _enterFrameListener;

  MdInput(this.label,
      {this.fontSize: 14,
      this.textColor: MdColor.BLACK,
      this.fontName: DEFAULT_FONT,
      this.multiline: false,
      this.rows: 3,
      this.floating: false,
      this.required: "",
      this.keyboard: false,
      this.password: false})
      : super() {
    inheritSpan = true;

    //force onscreen keyboard on mobile devices
    if (Ac.MOBILE) {
      keyboard = true;
    } else if (keyboard == true) {
      KEYBOARD_NATIVE = false;
    }

    _defaultTextField = new UITextField(label, new TextFormat(fontName, fontSize, MdColor.GREY_DARK));
    addChild(_defaultTextField);

    /* if Mandatory Textfield */
    if (required != "") {
      /* Add TextField below line explaining why it's mandatory */
      _requiredTextField = new UITextField(required, new TextFormat(fontName, fontSize - 2, MdColor.GREY_DARK));
      addChild(_requiredTextField);

      /* Add Warning Icons: inactive=grey, active=red */
      _requiredIconInactive = MdIcon.color(MdIconSet.warning, MdColor.GREY_DARK);
      _requiredIconInactive.scaleX = .8;
      _requiredIconInactive.scaleY = .8;
      addChild(_requiredIconInactive);

      _requiredIconActive = MdIcon.color(MdIconSet.warning, MdColor.RED);
      _requiredIconActive.scaleX = .8;
      _requiredIconActive.scaleY = .8;
      addChild(_requiredIconActive);
      _requiredIconActive.alpha = 0;

      /* set highlight color for other items to red */
      _highlightColor = MdColor.RED;
    } else {
      /* set highlight color for other items to blue */
      _highlightColor = MdColor.BLUE;
    }

    _cursorBox = new Shape();
    addChild(_cursorBox);
    _cursorBox.alpha = 0;

    _inputTextField = new UITextFieldInput("", new TextFormat(fontName, fontSize, textColor));
    _inputTextField.displayAsPassword = password;
    _inputTextField.multiline = multiline;
    _inputTextField.height = (rows * (fontSize + 1)).round();
    addChild(_inputTextField);

    _inactiveLine = new Shape();
    addChild(_inactiveLine);

    _activeLine = new Shape();
    addChild(_activeLine);
    _activeLine.alpha = 0;

    if (Ac.TOUCH) {
      addEventListener(TouchEvent.TOUCH_BEGIN, mouseDownAction);
    } else {
      addEventListener(MouseEvent.MOUSE_DOWN, mouseDownAction);
    }

    addEventListener(TextEvent.TEXT_INPUT, textInputAction);
    addEventListener(KeyboardEvent.KEY_UP, keyUpAction);
  }

  @override
  void enable() {
    if (_enabled) return;

    if (alpha == 0.6) alpha = 1;
    filters = [];
    mouseChildren = true;

    super.enable();
  }

  @override
  void disable() {
    if (!_enabled) return;

    if (alpha == 1.0) alpha = .6;
    filters = [new ColorMatrixFilter.grayscale()];
    mouseChildren = false;

    super.disable();
  }

  /*
   * Redraws and adjusts lines and textfield widths
   */
  @override
  refresh() {
    _inputTextField.width = spanWidth;

    _drawLine(_inactiveLine, textColor, 0.2);
    _drawLine(_activeLine, _highlightColor, 2);
    _drawBox(_cursorBox, _highlightColor);

    _inactiveLine.y = _inputTextField.textHeight + 5;
    _activeLine.y = _inputTextField.textHeight + 5;

    if (required != "") {
      _requiredTextField.y = _inactiveLine.y + 5;
      _requiredIconActive.x = _requiredIconInactive.x = spanWidth - 24;
      _requiredIconActive.y = _requiredIconInactive.y = _requiredTextField.y;
    }

    if (_nativeKeyboard != null) {
      //  _nativeKeyboard.x = _inputTextField.x + int.parse(html.querySelector('body').style.left, onError: (e) => 0);
      //  _nativeKeyboard.y = _inputTextField.y + int.parse(html.querySelector('body').style.top, onError: (e) => 0);
      _nativeKeyboard.span(spanWidth, spanHeight);
    }

    super.refresh();
    spanHeight = height;
  }

  /* User clicks into TextField */
  void mouseDownAction([InputEvent event = null]) {
    _enterFrameListener = addEventListener(Event.ENTER_FRAME, (e) => Ac.MATERIALIZE_REQUIRED = true);

    /* Animate active line */
    if (_activeLine.alpha == 0) {
      _activeLine.scaleX = 0.01;
      _activeLine.alpha = 1;
      _activeLine.x = spanWidth / 2;
      Ac.JUGGLER.addTween(_activeLine, .2).animate..x.to(0)..scaleX.to(1);
    }

    /* Animate cursor box */
    if (Ac.STAGE.focus != _inputTextField) {
      _cursorBox.scaleX = 1;
      _cursorBox.x = 80;
      _cursorBox.alpha = 1;

      Tween tw = new Tween(_cursorBox, .1);
      tw.animate..x.to(0)..scaleX.to(0.2);
      tw.onComplete = () => _cursorBox.alpha = 0;
      Ac.JUGGLER.add(tw);
    }

    /* If the label is currently floating, color it blue or red again */
    if (_currentlyFloating) {
      _defaultTextField.color = _highlightColor;
    }

    /* If this textfield is mandatory, make explanatory text red */
    validate();

    /* Set Focus to InputField, otherwise Keyboard Events won't work */
    Ac.STAGE.focus = _inputTextField;

    if (keyboard && _softKeyboard == null && _nativeKeyboard == null) {
      _createKeyboard();
    }

    /* Add a listener to Stage to manage intention to Focus out */
    if (Ac.TOUCH) {
      Ac.STAGE.addEventListener(TouchEvent.TOUCH_BEGIN, stageMouseDownAction);
    } else {
      Ac.STAGE.addEventListener(MouseEvent.MOUSE_DOWN, stageMouseDownAction);
    }
  }

  bool validate() {
    if (required != "") {
      _requiredTextField.color = MdColor.RED;
      Ac.JUGGLER.addTween(_requiredIconActive, .1).animate..alpha.to(1);
      return false;
    }
    return true;
  }

  /**
   * Manages focusOut
   */
  void stageMouseDownAction(InputEvent event) {
    if (event.target == _inputTextField || event.target == this) {
      return;
    }
    if (event.target is! UITextFieldInput && event.target is! MdInput) {
      Ac.STAGE.focus = null;
    } else {
      _enterFrameListener.cancel();
      _enterFrameListener = null;
    }
    if (Ac.TOUCH) {
      Ac.STAGE.removeEventListener(TouchEvent.TOUCH_BEGIN, stageMouseDownAction);
    } else {
      Ac.STAGE.removeEventListener(MouseEvent.MOUSE_DOWN, stageMouseDownAction);
    }
    /* Make active blue line invisible */
    Ac.JUGGLER.addTween(_activeLine, .1).animate..alpha.to(0);

    /* Make floating label grey again */
    if (_currentlyFloating) {
      _defaultTextField.color = MdColor.GREY_DARK;
    }

    /* Make explanatory text grey again */
    if (required != "") {
      _requiredTextField.color = MdColor.GREY_DARK;
      Ac.JUGGLER.addTween(_requiredIconActive, .1).animate..alpha.to(0);
    }

    if (keyboard) {
      _disposeKeyboard();
    }
  }

  void softKeyboardDownAction(int keyCode) {
    _inputTextField.keyDownAction(keyCode);
    keyUpAction();
  }

  void softKeyboardInputAction(String text) {
    _inputTextField.textInputAction(text);
    textInputAction();
  }

  /**
   * Manages behaviour of Labels
   */
  void textInputAction([TextEvent event = null]) {
    if (_inputTextField.text != "") {
      if (floating) {
        /* Float the Label above the Input Field */
        if (!_currentlyFloating) {
          _currentlyFloating = true;
          Translation tr = new Translation(0, 1, .2)
            ..onUpdate = (num val) {
              _defaultTextField.y = val * -(fontSize + 3);
              _defaultTextField.scaleX = 1 - val / 4;
              _defaultTextField.scaleY = 1 - val / 4;
            }
            ..onComplete = () {
              _defaultTextField.color = _highlightColor;
            };
          Ac.JUGGLER.add(tr);
        }
      } else {
        _defaultTextField.alpha = 0;
      }
    }
  }

  /**
   * Manages behaviour of Labels
   */
  void keyUpAction([KeyboardEvent event = null]) {
    if (_inputTextField.text == "") {
      if (floating) {
        if (_currentlyFloating) {
          /* Animate the Label back to original position */
          _currentlyFloating = false;
          Translation tr = new Translation(1, 0, .2)
            ..onUpdate = (num val) {
              _defaultTextField.y = val * -(fontSize + 3);
              _defaultTextField.scaleX = 1 - val / 4;
              _defaultTextField.scaleY = 1 - val / 4;
            }
            ..onComplete = () {
              _defaultTextField.color = MdColor.GREY_DARK;
            };
          Ac.JUGGLER.add(tr);
        }
      } else {
        _defaultTextField.alpha = 1;
      }
    }
    _inactiveLine.y = _inputTextField.textHeight + 5;
    _activeLine.y = _inputTextField.textHeight + 5;
  }

  void _drawLine(Shape line, int color, num strength) {
    line.graphics.clear();
    line.graphics.beginPath();
    line.graphics.moveTo(0, 0);
    line.graphics.lineTo(spanWidth, 0);
    line.graphics.strokeColor(color, strength);
    line.graphics.closePath();
    if (Ac.WEBGL) {
      //line.applyCache(0, 0, spanWidth.ceil(), strength.ceil());
    }
  }

  void _drawBox(Shape box, int color) {
    box.graphics.clear();
    box.graphics.rect(0, 0, 20, _inputTextField.textHeight);
    box.graphics.fillColor(color);
  }

  MdKeyboard _softKeyboard;
  NativeKeyboard _nativeKeyboard;

  void _createKeyboard() {
    if (KEYBOARD_NATIVE == false) {
      _softKeyboard = new MdKeyboard();
      _softKeyboard.addEventListener(KeyEvent.KEY_UP_VISIBLE, (KeyEvent e) {
        softKeyboardInputAction(e.char != null ? e.char : new String.fromCharCode(e.charCode));
      });
      _softKeyboard.addEventListener(KeyEvent.KEY_UP, (KeyEvent e) {
        softKeyboardDownAction(e.charCode);
      });
    } else {
      _nativeKeyboard = new NativeKeyboard(_inputTextField.text, label,
          multiline: multiline, rows: rows, fontSize: fontSize, fontName: fontName);
      _nativeKeyboard.addEventListener(KeyEvent.KEY_UP_VISIBLE, (KeyEvent e) {
        softKeyboardInputAction(e.char != null ? e.char : new String.fromCharCode(e.charCode));
        _inputTextField.text = _nativeKeyboard.value;
      });
      addChild(_nativeKeyboard);
      _nativeKeyboard.x = _inputTextField.x;
      _nativeKeyboard.y = _inputTextField.y;
      _nativeKeyboard.createKeyboard();
      _nativeKeyboard.span(spanWidth, spanHeight);
    }
  }

  void _disposeKeyboard() {
    if (KEYBOARD_NATIVE == false) {
      _softKeyboard.removeEventListeners(KeyEvent.KEY_UP_VISIBLE);
      _softKeyboard.removeEventListeners(KeyEvent.KEY_UP);
      _softKeyboard.dispose();
      _softKeyboard = null;
    } else {
      _nativeKeyboard.removeEventListeners(KeyEvent.KEY_UP_VISIBLE);
      _nativeKeyboard.dispose();
      _nativeKeyboard = null;
    }
  }

  ///addresses a sizing bug with Graphics tool
  num get width => super.width - 2;

  num get spanWidth => super.spanWidth - 2;

  String getText() {
    return _inputTextField.text;
  }

  void setText(String txt) {
    _inputTextField.text = txt;
  }
}
