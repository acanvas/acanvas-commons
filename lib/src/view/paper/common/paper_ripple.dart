part of stagexl_commons;

class PaperRipple extends SpriteComponent implements IPaperButtonComponent{
  static const int RECTANGLE = 1;
  static const int CIRCLE = 2;
  
  num waveMaxRadius = 150;
  num initialOpacity = 0.25;
  num velocity = 0.5;
  bool recenteringTouch = false;
  
  num color;
  num type;
  
  Sprite holder;

  PaperRipple({this.color : 0xFF000000, this.type : RECTANGLE, this.velocity: 0.5 }):super() {
    ignoreCallSetSize = false;
    //addEventListener(MouseEvent.MOUSE_DOWN, downAction);
    //addEventListener(MouseEvent.MOUSE_UP, upAction);
  }
  
  @override
  void redraw(){
    switch(type){
      case CIRCLE:
        mask = new Mask.circle(widthAsSet/2, widthAsSet/2, widthAsSet/2);
        break;
      case RECTANGLE:
        mask = new Mask.rectangle(0, 0, widthAsSet, heightAsSet);
        break;
    }
  }

  downAction(Event e) {
    num localX = e is MouseEvent ? (e as MouseEvent).localX : (e as TouchEvent).localX;
    num localY = e is MouseEvent ? (e as MouseEvent).localY : (e as TouchEvent).localY;
    
    var touchX = localX > widthAsSet ? widthAsSet : localX;// - rect.left;
    var touchY = localY > heightAsSet ? heightAsSet : localY;// - rect.top;
    
    num waveRadius = distanceFromPointToFurthestCorner(new Point(touchX, touchY), new Point(widthAsSet, heightAsSet)) / 1.2;
    
    Shape inner = new Shape()
          ..graphics.circle(0, 0, waveRadius.round())
          ..graphics.fillColor(color)
          ..alpha = initialOpacity
          ..x = touchX
          ..y = touchY;
   
    if(ContextTool.WEBGL){
      inner.applyCache(-waveRadius.round(), -waveRadius.round(), waveRadius.round()*2, waveRadius.round()*2);
    }
    inner.scaleX = 0.1;
    inner.scaleY = 0.1;
    
    addChild(inner);
    
    Tween tw = new Tween(inner, velocity, TransitionFunction.easeOutElastic)
    ..animate.scaleX.to(1.2)
    ..animate.scaleY.to(1.2);
    
    if (recenteringTouch == true) {
      tw.animate.x.to(width / 2);
      tw.animate.y.to(height / 2);
    }
    
    stage.juggler.add(tw);

  }

  upAction(Event e) {

    for (int i = 0; i < numChildren; i++) {
      // Declare the next wave that has mouse down to be mouse'ed up.
     DisplayObject dobj = getChildAt(i);

      stage.juggler.removeTweens(dobj);
      stage.juggler.tween(dobj, velocity)
      ..animate.alpha.to(0)
      ..animate.scaleX.to(1.0)
      ..animate.scaleY.to(1.0)
      ..onComplete = () { 
          if(dobj != null && contains(dobj)) removeChild(dobj); 
          dobj = null;
      };
     
    }

  }
  
  num dist(Point p1, Point p2) {
    return sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2));
  }

  num distanceFromPointToFurthestCorner(Point point, Point size) {
    num tl_d = dist(point, new Point(0, 0));
    num tr_d = dist(point, new Point(size.x, 0));
    num bl_d = dist(point, new Point(0, size.y));
    num br_d = dist(point, new Point(size.x, size.y));
    return max(max(tl_d, tr_d), max(bl_d, br_d));
  }

}
