part of stagexl_commons;


class PaperFab extends Button {

  bool hover = false;
  
  SvgDisplayObject icon;
  PaperShadow _shadow;
  PaperRipple _ripple;

  PaperFab(this.icon, {num radius: 30, int bgColor: PaperColor.BLUE, int shadowColor: PaperColor.GREY_SHADOW, int rippleColor: PaperColor.WHITE, int elevation : 1, this.hover : true}) : super() {

    _shadow = new PaperShadow(type: PaperShadow.CIRCLE, bgColor: bgColor, shadowColor: shadowColor, elevation: elevation, shadowEnabled: elevation == 0 ? false : true);
    addChild(_shadow);

    _ripple = new PaperRipple(type: PaperRipple.CIRCLE, color: rippleColor);
    addChild(_ripple);

    addChild(icon);

    setSize(radius * 2, radius * 2);
    enabled = true;
  }

  void set opacity(num o) {_ripple.opacity = o;}


  @override void redraw() {
    super.redraw();

    icon.x = (widthAsSet / 2 - 12).round();
    icon.y = (heightAsSet / 2 - 12).round();
  }

  void onRollOver([MouseEvent event = null]) {
    if(stage == null || !hover) return;
    ContextTool.STAGE.juggler.addTween(icon, .1).animate
     ..x.to((widthAsSet / 2 - 12).round() - 2.4)
     ..y.to((heightAsSet / 2 - 12).round() - 2.4)
     ..scaleX.to(1.2)
     ..scaleY.to(1.2);
    _shadow.downAction();
  }
  void onRollOut([MouseEvent event = null]) {
    if(stage == null || !hover) return;
    ContextTool.STAGE.juggler.addTween(icon, .1).animate
        ..x.to((widthAsSet / 2 - 12).round())
        ..y.to((heightAsSet / 2 - 12).round())
     ..scaleX.to(1)
     ..scaleY.to(1);
     _shadow.upAction();
  }


}
