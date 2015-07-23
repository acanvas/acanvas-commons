part of stagexl_commons;


class PaperTabs extends BoxSprite {

  int bgColor;
  int highlightColor;
  bool distributeTabs;

  Sprite _bg;
  Sprite _slideBar;

  Flow tabBox;
  
  int _activeButtonIndex = 0;

  PaperTabs({this.highlightColor : PaperColor.WHITE, this.bgColor: PaperColor.BLACK, this.distributeTabs : true}) : super() {
    _bg = new Sprite();
    addChild(_bg);

    tabBox = new Flow()
      ..spacing = 0
      ..snapToPixels = true
      ..flowOrientation = FlowOrientation.HORIZONTAL;
    addChild(tabBox);
    
    _slideBar = new Sprite();
    addChild(_slideBar);
  }
  
  void addTab(Button btn){
    btn.submitCallback = _onTabClick;
    btn.submitCallbackParams = [btn, tabBox.numChildren];
    tabBox.addChild(btn);
  }

  void activateTabByUrl(String url){
    for(int i=0;i<tabBox.numChildren;i++){
      if((tabBox.getChildAt(i) as Button).submitEvent.data == url){
        _onTabClick(tabBox.getChildAt(i) as Button, i);
      }
    }
  }

  void _onTabClick(Button btn, int index){
    _activeButtonIndex = index;
    ContextTool.STAGE.juggler.addTween(_slideBar, .3, Transition.easeOutCubic).animate
      ..x.to(btn.x);
    _slideBar.width = btn.spanWidth;
  }

  @override void refresh() {
    super.refresh();
    
    GraphicsUtil.rectangle(0, 0, spanWidth, spanHeight, sprite: _bg, color : bgColor);

    tabBox.x = 0;

    if(tabBox.numChildren > 0){
      tabBox.y = spanHeight - tabBox.height;
     
      if(distributeTabs){
        for(int i = 0; i<tabBox.numChildren;i++){
          Button btn = tabBox.getChildAt(i);
          btn.span((spanWidth/tabBox.numChildren).ceil(), 0);
        }
        tabBox.refresh();
      }

      GraphicsUtil.line((tabBox.getChildAt(_activeButtonIndex) as Button).spanWidth, 0, strength: 2, sprite: _slideBar, color : highlightColor);
      
      _slideBar.x = tabBox.getChildAt(_activeButtonIndex).x;
      _slideBar.y = spanHeight - 1;
    }
    else{
      _slideBar.visible = false;
    }
  }

  ///addresses a sizing bug with Graphics tool
  num get width => super.width - 2;
  num get spanWidth => super.spanWidth - 2;

}
