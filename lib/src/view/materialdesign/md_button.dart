part of rockdot_commons;

class MdButton extends Button {
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
  SvgDisplayObject icon;
  bool shadow;

  MdButton(String text,
      {num width: 120,
      num height: MdDimensions.HEIGHT_BUTTON,
      int bgColor: -1,
      int fontColor: -1,
      String fontName: MdText.DEFAULT_FONT,
      int fontSize: 14,
      int preset: PRESET_WHITE,
      this.shadow: true,
      bool background: true,
      bool ripple: true,
      this.icon})
      : super() {
    int _fontAndRippleColor;
    switch (preset) {
      case PRESET_WHITE:
        _bgColor = MdColor.WHITE;
        _fontAndRippleColor = 0xFF646464;
        break;
      case PRESET_GREY:
        _bgColor = MdColor.GREY;
        _fontAndRippleColor = 0xFF646464;
        break;
      case PRESET_BLUE:
        _bgColor = MdColor.BLUE;
        _fontAndRippleColor = 0xFFFFFFFF;
        break;
      case PRESET_GREEN:
        _bgColor = MdColor.GREEN;
        _fontAndRippleColor = 0xFFFFFFFF;
        break;
      case PRESET_RED:
        _bgColor = MdColor.RED;
        _fontAndRippleColor = 0xFFFFFFFF;
        break;
    }

    if (bgColor != -1) {
      _bgColor = bgColor;
    }

    if (fontColor != -1) {
      _fontAndRippleColor = fontColor;
    }

    if (background) {
      _paperShadow =
          new MdShadow(type: MdShadow.RECTANGLE, bgColor: _bgColor, shadowEnabled: shadow /*, target: this*/);
      addChild(_paperShadow);
    }

    if (ripple) {
      MdRipple paperRipple = new MdRipple(color: _fontAndRippleColor);
      addChild(paperRipple);
    }

    if (icon != null) {
      addChild(icon);
    }

    _label =
        new MdText(text.toUpperCase(), size: fontSize, color: _fontAndRippleColor, fontName: fontName, weight: 300);
    _label.width = LABEL_MAX_WIDTH;
    addChild(_label);

    autoSpan = false;
    span(width, height);
  }

  @override void refresh() {
    if (spanWidth > 0) {
      _label.x = (spanWidth / 2 - _label.textWidth / 2).round() - 3;
    } else {
      spanWidth = _label.textWidth + 4 * SPACER;
      _label.x = (spanWidth / 2 - _label.textWidth / 2).round() - 3;
    }

    _label.width = spanWidth - SPACER;
    _label.y = (spanHeight / 2 - _label.textHeight / 2).floor();

    if (icon != null) {
      icon.x = (_label.x - icon.width / 2 - 12).round();
      _label.x += (14 + icon.width).round();
      icon.y = _label.y - 4;
    }

    super.refresh();
  }

  @override void set labelText(String labelText) {
    super.labelText = labelText;
    _label.text = labelText;
    refresh();
  }
}
