part of stagexl_commons;


class PaperWrap extends SpriteComponent {

  num bgColor;
  PaperText _title;
  VBoxScrollable _vbox;

  PaperWrap(UITextField title, {num fontColor : PaperColor.BLACK, this.bgColor: PaperColor.WHITE, String fontName : PaperText.DEFAULT_FONT, int fontSize: 22, int padding : 20, bool center : false}) : super() {
    ignoreCallSetSize = true;

    super.addChild( new PaperShadow(type : PaperShadow.RECTANGLE, bgColor: bgColor, respondToClick: false) );

    _title = title;
    super.addChild(_title);
    
    _vbox = new VBoxScrollable(padding, true, false, center);
    _vbox.ignoreCallSetSize = true;
    super.addChild(_vbox);
  }

  @override
  void addChild(DisplayObject child) {
    _vbox.addChild(child);
  }

  @override void redraw() {
    super.redraw();
    
    _title.x = 20;
    _title.y = 20;
    _title.width = widthAsSet - 40;
    
    _vbox.x = 20;
    _vbox.y = _title.y + _title.textHeight + 22;
    _vbox.setSize(widthAsSet - 40, heightAsSet - _vbox.y - 20);

  }

}
