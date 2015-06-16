part of stagexl_commons;

class PaperAppBar extends SpriteComponent {

  int bgColor;
  int highlightColor;
  bool extended = false;

  Sprite _bg;
  Sprite _headline;

  HBox leftBox;
  HBox rightBox;
  PaperTabs tabs;
  
  PaperAppBar({this.highlightColor : PaperColor.WHITE, this.bgColor: PaperColor.BLACK, this.extended : false}) : super() {
    ignoreCallSetSize = false;

    _bg = new Sprite();
    addChild(_bg);

    leftBox = new HBox(20, true);
    leftBox.ignoreCallSetSize = true;
    addChild(leftBox);

    rightBox = new HBox(20, true);
    rightBox.ignoreCallSetSize = true;
    addChild(rightBox);

  }
  
  void addToTL(InteractiveObject spr){
    leftBox.addChild(spr);
  }

  void addHeadline(InteractiveObject spr){
    _headline = spr;
    addChild(_headline);
  }

  void addToTR(InteractiveObject spr){
    rightBox.addChild(spr);
  }

  void addPaperTabs(PaperTabs spr){
    tabs = spr;
    addChild(tabs);
  }

  @override void setSize(int w, int h) {
    h = PaperDimensions.HEIGHT_APP_BAR;
    if(extended == true){
      h += PaperDimensions.HEIGHT_APP_BAR_EXTENDED_AREA;
    }
    if(tabs != null){
      tabs.setSize(w, PaperDimensions.HEIGHT_BUTTON);
      h += tabs.heightAsSet;
    }
    super.setSize(w, h);
  }

  @override void redraw() {
    super.redraw();

    leftBox.x = 10;
    leftBox.y = (PaperDimensions.HEIGHT_APP_BAR/2 - (leftBox.height - 8)/2).round();

    if(_headline != null){
      if(extended == true){
        _headline.x = PaperDimensions.HEIGHT_APP_BAR_EXTENDED_AREA - 2;
        _headline.y = PaperDimensions.HEIGHT_APP_BAR + 20;
      }
      else{
        _headline.x = leftBox.x + leftBox.width + 20;
        _headline.y = (PaperDimensions.HEIGHT_APP_BAR/2 - _headline.height/2).round();
      }
    }

    rightBox.x = widthAsSet - rightBox.width - 20;
    rightBox.y = (PaperDimensions.HEIGHT_APP_BAR/2 - (rightBox.height - 8)/2).round();

    if(tabs != null && tabs.numChildren > 0){
      tabs.x = 0;
      tabs.y = heightAsSet - tabs.height;
    }

    GraphicsUtil.rectangle(0, 0, widthAsSet, heightAsSet, sprite: _bg, color : bgColor);
  }

}
