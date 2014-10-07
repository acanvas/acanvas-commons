part of stagexl_commons;


class PaperButton extends Button {
  static const int SPACER = 10;

  static const int PRESET_WHITE = 1;
  static const int PRESET_GREY = 2;
  static const int PRESET_BLUE = 3;
  static const int PRESET_GREEN = 4;
  static const int PRESET_RED = 5;

  static const int LABEL_MAX_WIDTH = 400;

  PaperText _label;
  int _color;

  PaperButton(String text, {num width: 120, num height: 32, 
                            int fontSize: 14, String fontName: PaperText.DEFAULT_FONT, int fontColor : 0,
                            int preset: PRESET_WHITE,
                            bool shadow : true}) : super() {
    int fontColorPreset;
    switch (preset) {
      case PRESET_WHITE:
        _color = PaperColor.WHITE;
        fontColorPreset = 0xFF646464;
        break;
      case PRESET_GREY:
        _color = PaperColor.GREY;
        fontColorPreset = 0xFF646464;
        break;
      case PRESET_BLUE:
        _color = PaperColor.BLUE;
        fontColorPreset = 0xFFFFFFFF;
        break;
      case PRESET_GREEN:
        _color = PaperColor.GREEN;
        fontColorPreset = 0xFFFFFFFF;
        break;
      case PRESET_RED:
        _color = PaperColor.RED;
        fontColorPreset = 0xFFFFFFFF;
        break;
    }
    
    if(fontColor != 0){
      fontColorPreset = fontColor;
    }

    if(shadow){
      PaperShadow paperShadow = new PaperShadow(type : PaperShadow.RECTANGLE, bgColor: _color);
      addChild(paperShadow);
    }
    
    PaperRipple paperRipple = new PaperRipple(color: fontColorPreset);
    addChild(paperRipple);

    _label = new PaperText(text, size: fontSize, color: fontColorPreset, fontName: fontName);
    _label.width = LABEL_MAX_WIDTH;
    addChild(_label);


    setSize(width, height);
    //enabled = true;
  }


  @override void redraw() {

    if (widthAsSet > 30) {
      _label.x = (widthAsSet / 2 - _label.textWidth / 2).round() - 3;
    } else {
      widthAsSet = _label.textWidth + 4 * SPACER;
      _label.x = (widthAsSet / 2 - _label.textWidth / 2).round() - 3;
    }

    _label.width = widthAsSet - SPACER;
    _label.y = (heightAsSet / 2 - _label.textHeight / 2).round();

    super.redraw();
  }

  @override void setLabel(String label) {
    super.setLabel(label);
    _label.text = label;
    redraw();
  }

}
