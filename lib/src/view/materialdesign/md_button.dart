part of acanvas_commons;

enum IconPosition { LEFT, RIGHT }

class MdButton extends SelectableButton {
  static const int SPACER = 10;

  static const int PRESET_WHITE = 1;
  static const int PRESET_GREY = 2;
  static const int PRESET_BLUE = 3;
  static const int PRESET_GREEN = 4;
  static const int PRESET_RED = 5;

  static const int LABEL_MAX_WIDTH = 400;

  MdText _label;
  int _bgColor;
  MdShadow _paperShadow;
  MdRipple _paperRipple;
  SvgDisplayObject icon;
  bool shadow;
  IconPosition iconPosition;

  MdButton(String text,
      {num width: 120,
      num height: MdDimensions.HEIGHT_BUTTON,
      int bgColor: -1,
      int fontColor: -1,
      int rippleColor: -1,
      String fontName: MdText.DEFAULT_FONT,
      int fontSize: 14,
      int preset: PRESET_WHITE,
      this.shadow: true,
      bool background: true,
      bool ripple: true,
      this.icon,
      this.iconPosition: IconPosition.LEFT})
      : super() {
    selfSelect = false;
    int _fontColor;
    int _rippleColor;

    switch (preset) {
      case PRESET_WHITE:
        _bgColor = MdColor.WHITE;
        _fontColor = 0xFF646464;
        break;
      case PRESET_GREY:
        _bgColor = MdColor.GREY;
        _fontColor = _rippleColor = 0xFF646464;
        break;
      case PRESET_BLUE:
        _bgColor = MdColor.BLUE;
        _fontColor = _rippleColor = 0xFFFFFFFF;
        break;
      case PRESET_GREEN:
        _bgColor = MdColor.GREEN;
        _fontColor = _rippleColor = 0xFFFFFFFF;
        break;
      case PRESET_RED:
        _bgColor = MdColor.RED;
        _fontColor = _rippleColor = 0xFFFFFFFF;
        break;
    }

    if (bgColor != -1) {
      _bgColor = bgColor;
    }

    if (fontColor != -1) {
      _fontColor = _rippleColor = fontColor;
    }

    if (rippleColor != -1) {
      _rippleColor = rippleColor;
    }

    if (background) {
      _paperShadow = new MdShadow(
          type: MdShadow.RECTANGLE,
          bgColor: _bgColor,
          shadowEnabled: shadow /*, target: this*/);
      addChild(_paperShadow);
    }

    if (ripple) {
      _paperRipple = new MdRipple(color: _rippleColor);
      addChild(_paperRipple);
    }

    if (icon != null) {
      addChild(icon);
    }

    _label = new MdText(text.toUpperCase(),
        size: fontSize, color: _fontColor, fontName: fontName, weight: 300);
    _label.width = LABEL_MAX_WIDTH;
    addChild(_label);

    autoSpan = false;
    span(width, height);
  }

  @override
  void refresh() {
    if (spanWidth > 0) {
      _label.x = (spanWidth / 2 - _label.textWidth / 2).round() - 3;
    } else {
      spanWidth = _label.textWidth + 4 * SPACER;
      _label.x = (spanWidth / 2 - _label.textWidth / 2).round() - 3;
    }

    _label.width = spanWidth - SPACER;
    _label.y = (spanHeight / 2 - _label.textHeight / 2 + 2).floor();

    if (icon != null) {
      switch (iconPosition) {
        case IconPosition.LEFT:
          icon.x = (_label.x - icon.width / 2 - 12).round();
          _label.x += (14 + icon.width).round();
          break;
        case IconPosition.RIGHT:
          icon.x = (_label.x + _label.textWidth + icon.width / 2 - 12).round();
          _label.x -= (14 + icon.width).round();
          break;
      }

      icon.y = _label.y - 4;
    }

    super.refresh();
  }

  @override
  selectAction() {
    // _paperRipple.disableUpAction = true;
    if (_paperRipple != null) {
      _paperRipple.downAction();
    }

    if (_paperShadow != null) {
      _paperShadow.downAction();
    }
  }

  @override
  deselectAction() {
    // _paperRipple.disableUpAction = false;

    if (_paperRipple != null) {
      _paperRipple.upAction();
    }
    if (_paperShadow != null) {
      _paperShadow.upAction();
    }
  }

  @override
  void set labelText(String labelText) {
    super.labelText = labelText;
    _label.text = labelText;
    refresh();
  }
}
