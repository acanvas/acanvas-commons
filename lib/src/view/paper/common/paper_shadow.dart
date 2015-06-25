part of stagexl_commons;

class PaperShadow extends SpriteComponent implements IPaperButtonComponent{
  static const int RECTANGLE = 1;
  static const int CIRCLE = 2;

  static int QUALITY = ContextTool.MOBILE ? 1 : 1;

  int _initialBlur = 8;
  int _initialDistance = 1;
  int _activeDistance = 4;
  DropShadowFilter _shadow;
  Translation _trans;

  int type;
  int bgColor;
  bool shadowEnabled;
  int shadowColor;
  bool respondToClick;
  int elevation;
  Sprite target;

  PaperShadow({this.type : RECTANGLE, this.bgColor: 0xFFFFFFFF, this.shadowEnabled : true, this.shadowColor: PaperColor.GREY_SHADOW, this.respondToClick: true, this.elevation: 1, this.target}):super() {
    ignoreCallSetSize = false;

    if(elevation > 0 && shadowEnabled){
      _shadow = new DropShadowFilter(_initialDistance, PI/2, shadowColor, _initialBlur, _initialBlur, QUALITY);
      target != null ? target.filters = [_shadow] : filters = [_shadow];
    }
    else{
      respondToClick = false;
    }
  }
  
  @override
  void redraw(){
    switch(type){
      case RECTANGLE:
        GraphicsUtil.rectangle(0, 0, widthAsSet, heightAsSet, round : true, color: bgColor, sprite: target != null ? target : this);
        break;
      case CIRCLE:
        GraphicsUtil.circle(widthAsSet/2, widthAsSet/2, widthAsSet/2, round : true, color: bgColor, sprite: target != null ? target : this);
        break;
    }
  }

  
  downAction([Event e = null]) {
    if(!respondToClick) return;
    
    if (_trans != null) {
      ContextTool.STAGE.juggler.remove(_trans);
    }

    _trans = new Translation(_initialDistance, _activeDistance, .15)  ..onUpdate = (num val) {
        _shadow.distance = val;
      };

    ContextTool.STAGE.juggler.add(_trans);
  }


  upAction([Event e = null]) {
    if(!respondToClick) return;

    if (_trans != null) {
      ContextTool.STAGE.juggler.remove(_trans);
    }

    _trans = new Translation(_activeDistance, _initialDistance, .15)..onUpdate = (num val) {
          _shadow.distance = val;
        };

    ContextTool.STAGE.juggler.add(_trans);
  }
}
