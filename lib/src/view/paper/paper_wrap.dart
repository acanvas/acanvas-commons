part of stagexl_commons;

class PaperWrap extends BoxSprite {
  int bgColor;
  int panelColor;
  Sprite panelSprite;
  PaperText _title;
  Flow flow;
  ScrollifySprite _scrollManager;

  PaperWrap(UITextField title,
      {this.panelColor: PaperColor.WHITE,
      this.bgColor: PaperColor.WHITE,
      int spacing: 20,
      int padding: 20,
      AlignH align: AlignH.CENTER,
      bool reflow: false})
      : super() {
    inheritSpan = false;
    autoRefresh = false;
    this.padding = padding;

    super.addChild(new PaperShadow(type: PaperShadow.RECTANGLE, bgColor: bgColor, respondToClick: false));

    panelSprite = new Sprite();
    super.addChild(panelSprite);

    _title = title;
    super.addChild(_title);

    flow = new Flow()
      ..autoRefresh = false
      ..reflow = reflow
      ..spacing = spacing
      ..flowOrientation = FlowOrientation.VERTICAL
      ..alignH = align;

    _scrollManager = new ScrollifySprite(flow, new DefaultScrollbar(), new DefaultScrollbar());
    super.addChild(_scrollManager);
  }

  @override
  void addChild(DisplayObject child) {
    flow.addChild(child);
  }

  @override void refresh() {
    panelSprite.x = 0;
    panelSprite.y = 0;

    _title.x = padding;
    _title.y = padding;
    _title.width = spanWidth - 2 * padding;

    int marginTop = PaperDimensions.HEIGHT_APP_BAR;

    _scrollManager.y = marginTop;
    _scrollManager.span(spanWidth, spanHeight - marginTop - 2 * padding);
    flow.span(spanWidth - 2 * padding, spanHeight - marginTop - 2 * padding);
    flow.x = padding;
    flow.y = padding;

    super.refresh();
    RdGraphicsUtil.rectangle(0, 0, spanWidth, PaperDimensions.HEIGHT_APP_BAR, sprite: panelSprite, color: panelColor);
  }
}
