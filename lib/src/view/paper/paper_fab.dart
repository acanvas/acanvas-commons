part of stagexl_commons;


class PaperFab extends Button {

  bool hasShadow;
  bool hover = false;
  
  SvgDisplayObject icon;
  PaperShadow _shadow;
  PaperRipple _ripple;

  PaperFab(this.icon, {num radius: 30, num bgColor: PaperColor.BLUE, int shadowColor: PaperColor.GREY_SHADOW, num rippleColor: null, this.hasShadow : true}) : super() {
    hover = true;
    if(rippleColor != null){
    }

    _shadow = new PaperShadow(type: PaperShadow.CIRCLE, bgColor: bgColor, shadowColor: shadowColor);
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
    ContextTool.STAGE.juggler.tween(icon, .1).animate
     ..x.to((widthAsSet / 2 - 12).round() - 2.4)
     ..y.to((heightAsSet / 2 - 12).round() - 2.4)
     ..scaleX.to(1.2)
     ..scaleY.to(1.2);
    _shadow.downAction();
  }
  void onRollOut([MouseEvent event = null]) {
    if(stage == null || !hover) return;
    ContextTool.STAGE.juggler.tween(icon, .1).animate
        ..x.to((widthAsSet / 2 - 12).round())
        ..y.to((heightAsSet / 2 - 12).round())
     ..scaleX.to(1)
     ..scaleY.to(1);
     _shadow.upAction();
  }


}
