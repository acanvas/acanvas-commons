part of stagexl_commons;

class PaperShadow extends SpriteComponent implements IPaperButtonComponent{
  static const int RECTANGLE = 1;
  static const int CIRCLE = 2;
  
  int _initialBlur = 10;
  int _activeBlur = 16;
  int _initialDistance = 2;
  int _activeDistance = 6;
  Timer _timer;
  DropShadowFilter _shadow;
  Transition _trans;

  num type;
  num bgColor;
  bool shadowEnabled;
  num shadowColor;
  bool respondToClick;

  PaperShadow({this.type : RECTANGLE, this.bgColor: 0xFFFFFFFF, this.shadowEnabled : true, this.shadowColor: PaperColor.GREY_SHADOW, this.respondToClick: true}):super() {
    ignoreCallSetSize = false;
    if(shadowEnabled){
      _shadow = new DropShadowFilter(_initialDistance, 90 * PI/180, shadowColor, _initialBlur, _initialBlur);
      filters = [_shadow];
    }
    else{
      respondToClick = false;
    }
  }
  
  @override
  void redraw(){
    graphics.clear();
    switch(type){
      case RECTANGLE:
        graphics.rect(0, 0, widthAsSet, heightAsSet);
        break;
      case CIRCLE:
        graphics.circle(widthAsSet/2, widthAsSet/2, widthAsSet/2);
        break;
    }
    graphics.fillColor(bgColor);
    cacheThis();
  }

  
  downAction([Event e = null]) {
    if(!respondToClick) return;
    
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = new Timer(new Duration(milliseconds: 30), () {
      
      _trans = new Transition(_initialDistance, _activeDistance, .15)..onUpdate = (num val) {
            _shadow.distance = val;
            cacheThis();
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

    _trans = new Transition(_activeDistance, _initialDistance, .15)..onUpdate = (num val) {
          _shadow.distance = val;
          cacheThis();
        };

    ContextTool.STAGE.juggler.add(_trans);
  }

  void cacheThis() {
    if (ContextTool.WEBGL) {
      applyCache(-30, -5, (widthAsSet + 60).round(), (heightAsSet + 34).round());
    }
  }
}
