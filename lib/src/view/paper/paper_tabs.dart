part of stagexl_commons;


class PaperTabs extends SpriteComponent {

  int bgColor;
  int highlightColor;
  bool distributeTabs;

  Sprite _bg;
  Sprite _slideBar;

  HBox _tlBox;
  HBox _trBox;
  HBox _tabBox;
  
  int _activeButtonIndex = 0;

  PaperTabs({this.highlightColor : PaperColor.WHITE, this.bgColor: PaperColor.BLACK, this.distributeTabs : true}) : super() {
    _bg = new Sprite();
    addChild(_bg);

    _tlBox = new HBox(20, true);
    _tlBox.ignoreCallSetSize = true;
    addChild(_tlBox);

    _trBox = new HBox(20, true);
    _trBox.ignoreCallSetSize = true;
    addChild(_trBox);

    _tabBox = new HBox(0, true);
    addChild(_tabBox);
    
    _slideBar = new Sprite();
    addChild(_slideBar);
    
  }
  
  void addToTL(InteractiveObject spr){
    _tlBox.addChild(spr);
  }

  void addToTR(InteractiveObject spr){
    _trBox.addChild(spr);
  }

  void addTab(Button btn){
    _tabBox.addChild(btn);
    btn.submitCallback = _onTabClick;
    btn.submitCallbackParams = [btn, _tabBox.numChildren];
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

    _tlBox.x = 20;
    _tlBox.y = 20;

    _trBox.x = widthAsSet - _trBox.width - 20;
    _trBox.y = 20;

    _tabBox.x = 0;
    if(_tlBox.numChildren == 0 && _trBox.numChildren == 0){
      //needed?
    }
    _tabBox.y = heightAsSet - _tabBox.height;
   
    if(distributeTabs){
      for(int i = 0; i<_tabBox.numChildren;i++){
        Button btn = _tabBox.getChildAt(i);
        btn.setSize((widthAsSet/_tabBox.numChildren).round(), 0);
      }
      _tabBox.update();
    }

    GraphicsUtil.line((_tabBox.getChildAt(_activeButtonIndex) as Button).widthAsSet, 0, strength: 2, sprite: _slideBar, color : highlightColor);
    _slideBar.y = heightAsSet - 2;
  }

}
