part of stagexl_commons;

class PaperRipple extends SpriteComponent implements IPaperButtonComponent{
  static const int RECTANGLE = 1;
  static const int CIRCLE = 2;
  
  num _waveMaxRadius = 150;
  num _initialOpacity = 0.25;
  void set opacity(num o) {_initialOpacity = o;}

  int color;
  num type;
  num velocity = 1.5;
  
  Sprite holder;

  PaperRipple({this.color : 0xFF000000, this.type : RECTANGLE, this.velocity: 0.5 }):super() {
    ignoreCallSetSize = false;
    if(ContextTool.TOUCH){
      velocity = 1;
    }
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

  @override
  downAction([InputEvent e = null]) {
    num localX = e == null ? widthAsSet/2 : e.localX;
    num localY = e == null ? heightAsSet/2 : e.localY;
    
    num touchX = localX > widthAsSet ? widthAsSet : localX;// - rect.left;
    num touchY = localY > heightAsSet ? heightAsSet : localY;// - rect.top;
    
    int waveRadius = (distanceFromPointToFurthestCorner(new Point(touchX, touchY), new Point(widthAsSet, heightAsSet)) / 1.2).round();
    
    Shape inner = new Shape()
          ..graphics.circle(0, 0, waveRadius)
          ..graphics.fillColor(color)
          ..alpha = _initialOpacity
          ..x = touchX
          ..y = touchY;
   
    if(ContextTool.WEBGL){
      //inner.applyCache(-waveRadius, -waveRadius, waveRadius*2, waveRadius*2);
    }
    inner.scaleX = 0.1;
    inner.scaleY = 0.1;
    
    addChild(inner);
    
    Tween tw = new Tween(inner, velocity, Transition.easeOutElastic)
    ..animate.scaleX.to(1.2)
    ..animate.scaleY.to(1.2);

    ContextTool.STAGE.juggler.add(tw);

  }

  @override
  upAction([Event e = null]) {

    for (int i = 0; i < numChildren; i++) {
     DisplayObject dobj = getChildAt(i);

      ContextTool.STAGE.juggler.removeTweens(dobj);
      ContextTool.STAGE.juggler.addTween(dobj, velocity)
      ..animate.alpha.to(0)
      ..animate.scaleX.to(1.0)
      ..animate.scaleY.to(1.0)
      ..onComplete = () { 
        disposeChild(dobj); 
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
