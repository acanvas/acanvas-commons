part of dart_commons;


class PaperButtonRound extends Button {

  bool hover = false;
  SvgDisplayObject icon;
  PaperShadow _shadow;
  PaperRipple _ripple;

  PaperButtonRound(this.icon, {num radius: 30, num bgColor: PaperColor.BLUE, num rippleColor: null}) : super() {
    if(rippleColor != null){
      hover = true;
    }

    _shadow = new PaperShadow(type: PaperShadow.CIRCLE, bgColor: bgColor);
    addChild(_shadow);

    _ripple = new PaperRipple(type: PaperRipple.CIRCLE, color: rippleColor == null ? PaperColor.WHITE : rippleColor);
    addChild(_ripple);

    addChild(icon);

    setSize(radius * 2, radius * 2);
    enabled = true;
  }


  @override void redraw() {
    super.redraw();

    icon.x = (widthAsSet / 2 - 12).round();
    icon.y = (heightAsSet / 2 - 12).round();
  }

  void onRollOver([MouseEvent event = null]) {
    if(stage == null || !hover) return;
    stage.juggler.tween(icon, .1).animate
     ..x.to((widthAsSet / 2 - 12).round() - 2.4)
     ..y.to((heightAsSet / 2 - 12).round() - 2.4)
     ..scaleX.to(1.2)
     ..scaleY.to(1.2);
  }
  void onRollOut([MouseEvent event = null]) {
    if(stage == null || !hover) return;
    stage.juggler.tween(icon, .1).animate
        ..x.to((widthAsSet / 2 - 12).round())
        ..y.to((heightAsSet / 2 - 12).round())
     ..scaleX.to(1)
     ..scaleY.to(1);
  }


}
