part of stagexl_commons;

class PaperShadow extends SpriteComponent implements IPaperButtonComponent{
  static const int RECTANGLE = 1;
  static const int CIRCLE = 2;

  static int QUALITY = ContextTool.MOBILE ? 5 : 5;

  int _initialBlur = 10;
  int _initialDistance = 2;
  int _activeDistance = 6;
  Timer _timer;
  DropShadowFilter _shadow;
  Translation _trans;

  num type;
  num bgColor;
  bool shadowEnabled;
  num shadowColor;
  bool respondToClick;
  SpriteComponent _bg;

  PaperShadow({this.type : RECTANGLE, this.bgColor: 0xFFFFFFFF, this.shadowEnabled : true, this.shadowColor: PaperColor.GREY_SHADOW, this.respondToClick: true}):super() {
    ignoreCallSetSize = false;

    _bg = new SpriteComponent();
    addChild(_bg);

    if(shadowEnabled){
      _shadow = new DropShadowFilter(_initialDistance, 90 * PI/180, shadowColor, _initialBlur, _initialBlur, QUALITY);
      filters = [_shadow];
    }
    else{
      respondToClick = false;
    }
  }
  
  @override
  void redraw(){
    switch(type){
      case RECTANGLE:
        GraphicsUtil.rectangle(0, 0, widthAsSet, heightAsSet, color: bgColor, sprite: _bg);
        break;
      case CIRCLE:
        GraphicsUtil.circle(widthAsSet/2, widthAsSet/2, widthAsSet/2, color: bgColor, sprite: _bg);
        break;
    }
  }

  
  downAction([Event e = null]) {
    if(!respondToClick) return;
    
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = new Timer(new Duration(milliseconds: 30), () {
      
      _trans = new Translation(_initialDistance, _activeDistance, .15)..onUpdate = (num val) {
            _shadow.distance = val;
          };

      ContextTool.STAGE.juggler.add(_trans);
      _timer = null;
    });
  }


  upAction([Event e = null]) {
    if(!respondToClick) return;
    
    if (_timer != null) {
      _timer.cancel();
      return;
    }

    ContextTool.STAGE.juggler.remove(_trans);

    _trans = new Translation(_activeDistance, _initialDistance, .15)..onUpdate = (num val) {
          _shadow.distance = val;
        };

    ContextTool.STAGE.juggler.add(_trans);
  }
}
