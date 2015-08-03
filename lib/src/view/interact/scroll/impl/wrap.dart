part of stagexl_commons;


class Wrap extends BoxSprite {

  Flow _vbox;
  ScrollifySprite _scrollManager;

  Wrap({int spacing : 20, AlignH align : AlignH.CENTER, bool reflow: true}) : super() {

    inheritSpan = true;
    autoRefresh = true;

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

    _vbox.x = padding;
    _vbox.y = padding;

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
