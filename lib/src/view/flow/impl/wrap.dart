part of rockdot_commons;

class Wrap extends BoxSprite {
  Flow flow;
  SpriteScrollifier _scrollManager;

  Wrap(
      {int spacing: 20,
      AlignH align: AlignH.LEFT,
      bool reflow: true,
      ScrollOrientation scrollOrientation: ScrollOrientation.BOTH,
      enableMask: true})
      : super() {
    inheritSpan = true;
    autoRefresh = true;

    flow = new Flow()
      ..autoRefresh = false
      ..reflow = reflow
      ..spacing = spacing
      ..flowOrientation = reflow ? FlowOrientation.HORIZONTAL : FlowOrientation.VERTICAL
      ..alignH = align;
    super.addChild(flow);

    _scrollManager = new SpriteScrollifier(flow, new DefaultScrollbar(), new DefaultScrollbar())
      ..maskEnabled = enableMask;
    _scrollManager.scrollOrientation = scrollOrientation;
    //_scrollManager.useNativeWidth = false;
    //_scrollManager.useNativeHeight = false;
    //super.addChild(_scrollManager);
  }

  @override
  void addChild(DisplayObject child) {
    flow.addChild(child);
  }

  /*
  @override
  void addChildAt(DisplayObject child, int index) {
    flow.addChildAt(child, index);
  }
  */

  @override void refresh() {
    flow.x = padding;
    flow.y = padding;

    flow.span(spanWidth - 2 * padding, spanHeight - flow.y - padding);
    _scrollManager.span(spanWidth, spanHeight - flow.y - padding);

    super.refresh();
  }
}
