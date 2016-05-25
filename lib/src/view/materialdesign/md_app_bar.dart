part of rockdot_commons;

class MdAppBar extends BoxSprite {
  int bgColor;
  int highlightColor;
  bool extended = false;

  Sprite _headline;

  Flow leftBox;
  Flow rightBox;
  MdTabs tabs;

  MdAppBar({this.highlightColor: MdColor.WHITE, this.bgColor: MdColor.BLACK, this.extended: false}) : super() {
    inheritSpan = true;

    leftBox = new Flow()..spacing = 20;
    addChild(leftBox);

    rightBox = new Flow()..spacing = 20;
    addChild(rightBox);
  }

  void addToTL(InteractiveObject spr) {
    leftBox.addChild(spr);
  }

  void addHeadline(InteractiveObject spr) {
    _headline = spr;
    addChild(_headline);
  }

  void addToTR(InteractiveObject spr) {
    rightBox.addChild(spr);
  }

  void addMdTabs(MdTabs spr) {
    tabs = spr;
    addChild(tabs);
  }

  @override void span(num w, num h, {bool refresh: true}) {
    h = MdDimensions.HEIGHT_APP_BAR;
    if (extended == true) {
      h += MdDimensions.HEIGHT_APP_BAR_EXTENDED_AREA;
    }
    if (tabs != null) {
      //tabs.span(spanWidth, MdDimensions.HEIGHT_BUTTON);
      h += MdDimensions.HEIGHT_BUTTON;
    }
    super.span(w, h, refresh: refresh);
  }

  @override void refresh() {
    leftBox.refresh();
    rightBox.refresh();

    leftBox.x = 10;
    leftBox.y = (MdDimensions.HEIGHT_APP_BAR / 2 - (leftBox.height - 0) / 2).round();

    if (_headline != null) {
      if (extended == true) {
        _headline.x = MdDimensions.HEIGHT_APP_BAR_EXTENDED_AREA - 2;
        _headline.y = MdDimensions.HEIGHT_APP_BAR + 20;
      } else {
        _headline.x = leftBox.x + leftBox.width + 20;
        _headline.y = (MdDimensions.HEIGHT_APP_BAR / 2 - _headline.height / 2 + 0).round();
      }
    }

    rightBox.x = spanWidth - rightBox.width - 20;
    rightBox.y = (MdDimensions.HEIGHT_APP_BAR / 2 - (rightBox.height - 0) / 2).round();

    if (tabs != null && tabs.numChildren > 0) {
      tabs.span(spanWidth, MdDimensions.HEIGHT_BUTTON);
      tabs.x = 0;
      tabs.y = spanHeight - tabs.height;
    }

    RdGraphics.rectangle(0, 0, spanWidth, spanHeight, sprite: this, color: bgColor);
    super.refresh();
  }
}
