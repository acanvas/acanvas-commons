part of stagexl_commons;


class Wrap extends BoxSprite {

  Flow flow;
  ScrollifySprite _scrollManager;

  Wrap({int spacing : 20, AlignH align : AlignH.LEFT, bool reflow: true, ScrollOrientation scrollOrientation : ScrollOrientation.BOTH}) : super() {

    inheritSpan = true;
    autoRefresh = true;

    flow = new Flow()
      ..autoRefresh = false
      ..reflow = reflow
      ..spacing = spacing
      ..flowOrientation = reflow ? FlowOrientation.HORIZONTAL : FlowOrientation.VERTICAL
      ..alignH = align;
    super.addChild(flow);

    _scrollManager = new ScrollifySprite(flow, new DefaultScrollbar(), new DefaultScrollbar());
    _scrollManager.scrollOrientation = scrollOrientation;
    //_scrollManager.useNativeWidth = false;
    //_scrollManager.useNativeHeight = false;
    //super.addChild(_scrollManager);
  }

  @override
  void addChild(DisplayObject child) {
    flow.addChild(child);
  }

  @override void refresh() {

    flow.x = padding;
    flow.y = padding;

    flow.span(spanWidth - 2 * padding, spanHeight - flow.y - padding);
    _scrollManager.span(spanWidth, spanHeight - flow.y - padding);

    super.refresh();
  }

}
