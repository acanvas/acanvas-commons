part of stagexl_commons;

class PaperShadow extends SpriteComponent implements IPaperButtonComponent{
  static const int RECTANGLE = 1;
  static const int CIRCLE = 2;
  
  int initialBlur = 10;
  int activeBlur = 9;
  int initialDistance = 0;
  int activeDistance = 8;

  num shadowColor;
  num bgColor;
  num type;
  bool respondToClick = true;

  Timer timer;

  DropShadowFilter _shadow;
  Transition trans;

  PaperShadow({this.type : RECTANGLE, this.bgColor: 0xFFFFFFFF, this.shadowColor: PaperColor.GREY_SHADOW, this.respondToClick: true}):super() {
    ignoreCallSetSize = false;
    _shadow = new DropShadowFilter(initialDistance, 90, shadowColor, initialBlur, initialBlur);
    filters = [_shadow];

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

  
  downAction(MouseEvent e) {
    if(!respondToClick) return;
    
    if (timer != null) {
      timer.cancel();
    }

    timer = new Timer(new Duration(milliseconds: 30), () {
      
      trans = new Transition(initialDistance, activeDistance, .1)..onUpdate = (num val) {
            _shadow.distance = val;
            cacheThis();
          };

      stage.juggler.add(trans);
      timer = null;

    });

  }


  upAction(Event e) {
    if(!respondToClick) return;
    
    if (timer != null) {
      timer.cancel();
      return;
    }

    stage.juggler.remove(trans);

    trans = new Transition(activeDistance, initialDistance, .4)..onUpdate = (num val) {
          _shadow.distance = val;
          cacheThis();
        };

    stage.juggler.add(trans);
  }

  void cacheThis() {
    if (ContextTool.WEBGL) {
      applyCache(-30, -1, (widthAsSet + 60).round(), (heightAsSet + 30).round());
    }
  }
}
