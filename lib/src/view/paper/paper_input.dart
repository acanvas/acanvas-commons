part of stagexl_commons;

class PaperInput extends SpriteComponent {
  static const DEFAULT_FONT = "Roboto, Helvetica, Arial";

  /* Parameters */
  int textColor;
  int fontSize;
  bool floating;
  bool keyboard;
  String required;

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

  PaperInput(String text, {this.fontSize: 14, this.textColor: PaperColor.BLACK, String fontName: DEFAULT_FONT, bool multiline: false, int rows: 1, this.floating: false, this.required: "", this.keyboard: false}) : super() {
    ignoreCallSetSize = false;

    _defaultTextField = new UITextField(text, new TextFormat(fontName, fontSize, PaperColor.GREY_DARK));
    addChild(_defaultTextField);

    /* if Mandatory Textfield */
    if (required != "") {
      /* Add TextField below line explaining why it's mandatory */
      _requiredTextField = new UITextField(required, new TextFormat(fontName, fontSize - 2, PaperColor.GREY_DARK));
      addChild(_requiredTextField);

      /* Add Warning Icons: inactive=grey, active=red */
      _requiredIconInactive = PaperIcon.grey(PaperIconSet.warning);
      _requiredIconInactive.scaleX = .8;
      _requiredIconInactive.scaleY = .8;
      addChild(_requiredIconInactive);

      _requiredIconActive = PaperIcon.red(PaperIconSet.warning);
      _requiredIconActive.scaleX = .8;
      _requiredIconActive.scaleY = .8;
      addChild(_requiredIconActive);
      _requiredIconActive.alpha = 0;

      /* set highlight color for other items to red */
      _highlightColor = PaperColor.RED;
    } else {
      /* set highlight color for other items to blue */
      _highlightColor = PaperColor.BLUE;
    }

    _cursorBox = new Shape();
    addChild(_cursorBox);
    _cursorBox.alpha = 0;

    _inputTextField = new UITextFieldInput("", new TextFormat(fontName, fontSize, textColor));
    _inputTextField.multiline = multiline;
    _inputTextField.height = (rows * (fontSize + 1)).round();
    addChild(_inputTextField);

    _inactiveLine = new Shape();
    addChild(_inactiveLine);

    _activeLine = new Shape();
    addChild(_activeLine);
    _activeLine.alpha = 0;

    if (ContextTool.TOUCH) {
      addEventListener(TouchEvent.TOUCH_BEGIN, mouseDownAction);
    } else {
      addEventListener(MouseEvent.MOUSE_DOWN, mouseDownAction);
    }

    addEventListener(TextEvent.TEXT_INPUT, textInputAction);
    addEventListener(KeyboardEvent.KEY_UP, keyUpAction);
  }


  /*
   * Redraws and adjusts lines and textfield widths
   */
  @override redraw() {
    _inputTextField.width = widthAsSet;

    _drawLine(_inactiveLine, textColor, 0.2);
    _drawLine(_activeLine, _highlightColor, 2);
    _drawBox(_cursorBox, _highlightColor);

    _inactiveLine.y = _inputTextField.textHeight + 5;
    _activeLine.y = _inputTextField.textHeight + 5;

    if (required != "") {
      _requiredTextField.y = _inactiveLine.y + 5;
      _requiredIconActive.x = _requiredIconInactive.x = widthAsSet - 24;
      _requiredIconActive.y = _requiredIconInactive.y = _requiredTextField.y;
    }

    super.redraw();
  }

  /* User clicks into TextField */
  void mouseDownAction([Event event = null]) {
    /* Animate active line */
    if (_activeLine.alpha == 0) {
      _activeLine.scaleX = 0.01;
      _activeLine.alpha = 1;
      _activeLine.x = widthAsSet / 2;
      ContextTool.STAGE.juggler.tween(_activeLine, .2).animate
          ..x.to(0)
          ..scaleX.to(1);
    }

    /* Animate cursor box */
    if (ContextTool.STAGE.focus != _inputTextField) {
      _cursorBox.scaleX = 1;
      _cursorBox.x = 80;
      _cursorBox.alpha = 1;

      Tween tw = new Tween(_cursorBox, .1);
      tw.animate
          ..x.to(0)
          ..scaleX.to(0.2);
      tw.onComplete = () => _cursorBox.alpha = 0;
      ContextTool.STAGE.juggler.add(tw);
    }

    /* If the label is currently floating, color it blue or red again */
    if (_currentlyFloating) {
      _defaultTextField.color = _highlightColor;
    }

    /* If this textfield is mandatory, make explanatory text red */
    if (required != "") {
      _requiredTextField.color = PaperColor.RED;
      ContextTool.STAGE.juggler.tween(_requiredIconActive, .1).animate..alpha.to(1);
    }

    /* Set Focus to InputField, otherwise Keyboard Events won't work */
    ContextTool.STAGE.focus = _inputTextField;

   if (keyboard && _softKeyboard == null) {
      _createKeyboard();
    }

   /* Add a listener to Stage to manage intention to Focus out */
   ContextTool.STAGE.addEventListener(MouseEvent.MOUSE_DOWN, stageMouseDownAction);

  }

  /**
   * Manages focusOut
   */
  void stageMouseDownAction(MouseEvent event) {
    if (event.target == _inputTextField) {
      return;
    }
    if (event.target is! UITextFieldInput) {
      ContextTool.STAGE.focus = null;
    }
    ContextTool.STAGE.removeEventListener(MouseEvent.MOUSE_DOWN, stageMouseDownAction);
    /* Make active blue line invisible */
    ContextTool.STAGE.juggler.tween(_activeLine, .1).animate..alpha.to(0);

    /* Make floating label grey again */
    if (_currentlyFloating) {
      _defaultTextField.color = PaperColor.GREY_DARK;
    }

    /* Make explanatory text grey again */
    if (required != "") {
      _requiredTextField.color = PaperColor.GREY_DARK;
      ContextTool.STAGE.juggler.tween(_requiredIconActive, .1).animate..alpha.to(0);
    }
    
    if(keyboard){
      _destroyKeyboard();
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
          Transition tr = new Transition(0, 1, .2)
              ..onUpdate = (num val) {
                _defaultTextField.y = val * -(fontSize + 3);
                _defaultTextField.scaleX = 1 - val / 4;
                _defaultTextField.scaleY = 1 - val / 4;
              }
              ..onComplete = () {
                _defaultTextField.color = _highlightColor;
              };
          ContextTool.STAGE.juggler.add(tr);
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
          Transition tr = new Transition(1, 0, .2)
              ..onUpdate = (num val) {
                _defaultTextField.y = val * -(fontSize + 3);
                _defaultTextField.scaleX = 1 - val / 4;
                _defaultTextField.scaleY = 1 - val / 4;
              }
              ..onComplete = () {
                _defaultTextField.color = PaperColor.GREY_DARK;
              };
          ContextTool.STAGE.juggler.add(tr);
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
    line.graphics.lineTo(widthAsSet, 0);
    line.graphics.strokeColor(color, strength);
    line.graphics.closePath();
    if (ContextTool.WEBGL) {
      line.applyCache(0, 0, widthAsSet.ceil(), strength.ceil());
    }
  }

  void _drawBox(Shape box, int color) {
    box.graphics.clear();
    box.graphics.rect(0, 0, 20, _inputTextField.textHeight);
    box.graphics.fillColor(color);
    if (ContextTool.WEBGL) {
      box.applyCache(0, 0, 20, _inputTextField.textHeight.ceil());
    }
  }
  
  SoftKeyboard _softKeyboard;
  void _createKeyboard() {
    Layout layout = new Qwerty();
    _softKeyboard = new SoftKeyboard([layout]);
    _softKeyboard.addEventListener(KeyEvent.KEY_UP_VISIBLE, (KeyEvent e) {
      softKeyboardInputAction(e.char != null ? e.char : new String.fromCharCode(e.charCode));
    });
    _softKeyboard.addEventListener(KeyEvent.KEY_UP, (KeyEvent e) {
      softKeyboardDownAction(e.charCode);
    });
   
    ContextTool.STAGE.addChild(_softKeyboard);
    ContextTool.STAGE.addEventListener(Event.RESIZE, _resizeKeyboard);
    _resizeKeyboard();
    _softKeyboard.init();
  }
  
  void _resizeKeyboard([Event e = null]){
    _softKeyboard.setSize(ContextTool.STAGE.stageWidth, min(ContextTool.STAGE.stageHeight/2, 400));
    _softKeyboard.y = ContextTool.STAGE.stageHeight - _softKeyboard.heightAsSet;
  }
  
  void _destroyKeyboard(){
    ContextTool.STAGE.removeEventListener(Event.RESIZE, _resizeKeyboard);
    disposeChild(_softKeyboard);
    _softKeyboard = null;
  }


}
