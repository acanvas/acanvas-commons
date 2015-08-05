part of stagexl_commons;


class Wrap extends BoxSprite {

  Flow flow;
  ScrollifySprite _scrollManager;

  Wrap({int spacing : 20, AlignH align : AlignH.LEFT, bool reflow: true}) : super() {

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
  }

  @override
  void addChild(DisplayObject child) {
    flow.addChild(child);
  }

  @override void refresh() {

    flow.x = padding;
    flow.y = padding;

   flow.span(spanWidth - 2 * padding, spanHeight - flow.y - padding);
    _scrollManager.span(spanWidth - 2 * padding, spanHeight - flow.y - padding);

    super.refresh();
  }

}
