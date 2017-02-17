part of rockdot_commons;

class MdWrap extends BoxSprite {
  int bgColor;
  int panelColor;
  Sprite panelSprite;
  UITextField _title;
  Flow flow;
  SpriteScrollifier _scrollManager;

  MdWrap(UITextField title,
      {this.panelColor: MdColor.WHITE,
      this.bgColor: MdColor.WHITE,
      int spacing: 20,
      int padding: 20,
      AlignH align: AlignH.CENTER,
      bool reflow: false})
      : super() {
    inheritSpan = false;
    autoRefresh = false;
    this.padding = padding;

    super.addChild(new MdShadow(type: MdShadow.RECTANGLE, bgColor: bgColor, respondToClick: false));

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

    _scrollManager = new SpriteScrollifier(flow, new DefaultScrollbar(), new DefaultScrollbar());
    super.addChild(_scrollManager);
  }

  @override
  void addChild(DisplayObject child) {
    flow.addChild(child);
  }

  @override
  void refresh() {
    panelSprite.x = 0;
    panelSprite.y = 0;

    _title.x = padding;
    _title.y = padding;
    _title.width = spanWidth - 2 * padding;

    int marginTop = MdDimensions.HEIGHT_APP_BAR;

    _scrollManager.y = marginTop;
    _scrollManager.span(spanWidth, spanHeight - marginTop - 2 * padding);
    flow.span(spanWidth - 2 * padding, spanHeight - marginTop - 2 * padding);
    flow.x = padding;
    flow.y = padding;

    super.refresh();
    RdGraphics.rectangle(0, 0, spanWidth, MdDimensions.HEIGHT_APP_BAR, sprite: panelSprite, color: panelColor);
  }
}
