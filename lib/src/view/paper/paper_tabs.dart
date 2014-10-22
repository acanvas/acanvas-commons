part of stagexl_commons;


class PaperTabs extends SpriteComponent {

  int bgColor;
  int highlightColor;
  bool distributeTabs;

  Sprite _bg;
  Sprite _slideBar;

  HBox leftBox;
  HBox rightBox;
  HBox tabBox;
  
  int _activeButtonIndex = 0;

  PaperTabs({this.highlightColor : PaperColor.WHITE, this.bgColor: PaperColor.BLACK, this.distributeTabs : true}) : super() {
    _bg = new Sprite();
    addChild(_bg);

    leftBox = new HBox(20, true);
    leftBox.ignoreCallSetSize = true;
    addChild(leftBox);

    rightBox = new HBox(20, true);
    rightBox.ignoreCallSetSize = true;
    addChild(rightBox);

    tabBox = new HBox(0, true);
    addChild(tabBox);
    
    _slideBar = new Sprite();
    addChild(_slideBar);
  }
  
  void addToTL(InteractiveObject spr){
    leftBox.addChild(spr);
  }

  void addToTR(InteractiveObject spr){
    rightBox.addChild(spr);
  }

  void addTab(Button btn){
    tabBox.addChild(btn);
    btn.submitCallback = _onTabClick;
    btn.submitCallbackParams = [btn, tabBox.numChildren];
  }

  void _onTabClick(Button btn, int index){
    _activeButtonIndex = index;
    stage.juggler.tween(_slideBar, .3, TransitionFunction.easeOutCubic).animate
      ..x.to(btn.x);
    _slideBar.width = btn.widthAsSet;
  }

  @override void redraw() {
    super.redraw();
    
    GraphicsUtil.rectangle(0, 0, widthAsSet, heightAsSet, sprite: _bg, color : bgColor);

    leftBox.x = 20;
    leftBox.y = 20;

    rightBox.x = widthAsSet - rightBox.width - 20;
    rightBox.y = 20;

    tabBox.x = 0;

    if(tabBox.numChildren > 0){
      tabBox.y = heightAsSet - tabBox.height;
     
      if(distributeTabs){
        for(int i = 0; i<tabBox.numChildren;i++){
          Button btn = tabBox.getChildAt(i);
          btn.setSize((widthAsSet/tabBox.numChildren).round(), 0);
        }
        tabBox.update();
      }

      GraphicsUtil.line((tabBox.getChildAt(_activeButtonIndex) as Button).widthAsSet, 0, strength: 2, sprite: _slideBar, color : highlightColor);
      
      _slideBar.y = heightAsSet - 2;
    }
    else{
      _slideBar.visible = false;
    }
  }

}
