part of stagexl_commons;


class PaperWrap extends BoxSprite {

  num bgColor;
  PaperText _title;
  Flow _vbox;

  PaperWrap(UITextField title, {num fontColor : PaperColor.BLACK, this.bgColor: PaperColor.WHITE, String fontName : PaperText.DEFAULT_FONT, int fontSize: 22, int padding : 20, bool center : false}) : super() {
    inheritSpan = false;

    super.addChild( new PaperShadow(type : PaperShadow.RECTANGLE, bgColor: bgColor, respondToClick: false) );

    _title = title;
    super.addChild(_title);
    
    _vbox = new Flow()
              ..spacing = padding
              ..snapToPixels = true
              ..inverted = false
              ..flowOrientation = FlowOrientation.VERTICAL
              ..alignH = AlignH.CENTER
              ..inheritSpan = false;
    super.addChild(_vbox);

    new ScrollifySprite(_vbox, new DefaultScrollbar(), new DefaultScrollbar());
  }

  @override
  void addChild(DisplayObject child) {
    _vbox.addChild(child);
  }

  @override void refresh() {
    super.refresh();
    
    _title.x = 20;
    _title.y = 20;
    _title.width = spanWidth - 40;
    
    _vbox.x = 20;
    _vbox.y = _title.y + _title.textHeight + 22;
    _vbox.span(spanWidth - 40, spanHeight - _vbox.y - 20);

  }

}
