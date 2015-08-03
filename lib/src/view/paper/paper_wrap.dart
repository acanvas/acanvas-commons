part of stagexl_commons;


class PaperWrap extends BoxSprite {

  num bgColor;
  PaperText _title;
  Flow _vbox;
  ScrollifySprite _scrollManager;

  PaperWrap(UITextField title, {num fontColor : PaperColor.BLACK, this.bgColor: PaperColor.WHITE, String fontName : PaperText.DEFAULT_FONT, int fontSize: 22, int spacing : 20, AlignH align : AlignH.LEFT, bool reflow: false}) : super() {
    inheritSpan = false;
    autoRefresh = false;

    super.addChild(new PaperShadow(type : PaperShadow.RECTANGLE, bgColor: bgColor, respondToClick: false));

    _title = title;
    super.addChild(_title);

    _vbox = new Flow()
      ..autoRefresh = false
      ..reflow = reflow
      ..spacing = spacing
      ..flowOrientation = FlowOrientation.VERTICAL
      ..alignH = align;
    super.addChild(_vbox);

    _scrollManager = new ScrollifySprite(_vbox, new DefaultScrollbar(), new DefaultScrollbar());
  }

  @override
  void addChild(DisplayObject child) {
    _vbox.addChild(child);
  }

  @override void refresh() {

    _title.x = padding;
    _title.y = padding;
    _title.width = spanWidth - 2*padding;

    _vbox.x = padding;
    _vbox.y = _title.y + _title.textHeight + padding;

    if(_vbox.reflow){
      _vbox.span(spanWidth - 2 * padding, spanHeight - _vbox.y - padding);
    }
    else{
      _vbox.refresh();
    }

    _scrollManager.span(spanWidth - 2 * padding, spanHeight - _vbox.y - padding);


    super.refresh();
  }

}
