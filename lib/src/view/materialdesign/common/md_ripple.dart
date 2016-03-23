part of rockdot_commons;

class MdRipple extends BoxSprite implements IMdButtonComponent {
  static const int RECTANGLE = 1;
  static const int CIRCLE = 2;

  num _waveMaxRadius = 150;
  num _initialOpacity = 0.25;

  void set opacity(num o) {
    _initialOpacity = o;
  }

  int color;
  num type;
  num velocity = 1.5;

  Sprite holder;

  MdRipple({this.color: 0xFF000000, this.type: RECTANGLE, this.velocity: 0.5}) : super() {
    inheritSpan = true;
    if (Rd.TOUCH) {
      velocity = 1;
    }
  }

  @override
  void refresh() {
    switch (type) {
      case CIRCLE:
        mask = new Mask.circle(spanWidth / 2, spanWidth / 2, spanWidth / 2 + 2);
        break;
      case RECTANGLE:
        mask = new Mask.rectangle(0, 0, spanWidth + 2, spanHeight + 3);
        break;
    }
  }

  @override
  downAction([InputEvent e = null]) {
    num localX = e == null ? spanWidth / 2 : e.localX;
    num localY = e == null ? spanHeight / 2 : e.localY;

    num touchX = localX > spanWidth ? spanWidth : localX; // - rect.left;
    num touchY = localY > spanHeight ? spanHeight : localY; // - rect.top;

    int waveRadius =
        (distanceFromPointToFurthestCorner(new Point(touchX, touchY), new Point(spanWidth, spanHeight)) / 1.1).round();

    Sprite inner = new Sprite()
      ..graphics.circle(0, 0, waveRadius)
      ..graphics.fillColor(color)
      ..alpha = _initialOpacity
      ..x = touchX
      ..y = touchY;

    if (Rd.WEBGL) {
      //inner.applyCache(-waveRadius, -waveRadius, waveRadius*2, waveRadius*2);
    }
    inner.scaleX = 0.1;
    inner.scaleY = 0.1;

    addChild(inner);

    Tween tw = new Tween(inner, velocity, Transition.easeOutElastic)..animate.scaleX.to(1.2)..animate.scaleY.to(1.2);

    Rd.JUGGLER.add(tw);
  }

  @override
  upAction([Event e = null]) {
    for (int i = 0; i < numChildren; i++) {
      DisplayObject dobj = getChildAt(i);

      Rd.JUGGLER.removeTweens(dobj);
      Rd.JUGGLER.addTween(dobj, velocity)
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
