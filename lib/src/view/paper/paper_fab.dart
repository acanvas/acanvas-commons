part of stagexl_commons;


class PaperFab extends Button {

  bool hover = false;
  bool shadow = true;

  SvgDisplayObject icon;
  PaperShadow _shadow;
  PaperRipple _ripple;

  PaperFab(this.icon, {num radius: 30, int bgColor: PaperColor.BLUE, int shadowColor: PaperColor.GREY_SHADOW, int rippleColor: PaperColor.WHITE, this.shadow : true, this.hover : true}) : super() {

    _shadow = new PaperShadow(type: PaperShadow.CIRCLE, bgColor: bgColor, shadowEnabled: shadow ? true : false);
    addChild(_shadow);

    _ripple = new PaperRipple(type: PaperRipple.CIRCLE, color: rippleColor);
    addChild(_ripple);

    addChild(icon);

    setSize(radius * 2, radius * 2);
  }

  void set opacity(num o) {_ripple.opacity = o;}


  @override void redraw() {
    super.redraw();

    icon.pivotX = 12;
    icon.pivotY = 12;
    icon.x = (widthAsSet / 2).round();
    icon.y = (heightAsSet / 2).round();
  }

  void onRollOver([InputEvent event = null]) {
    if(stage == null || !hover) return;
    ContextTool.STAGE.juggler.addTween(icon, .1).animate
     ..scaleX.to(1.2)
     ..scaleY.to(1.2);
   // _shadow.downAction();
  }
  void onRollOut([InputEvent event = null]) {
    if(stage == null || !hover) return;
    ContextTool.STAGE.juggler.addTween(icon, .1).animate
     ..scaleX.to(1)
     ..scaleY.to(1);
   //  _shadow.upAction();
  }


}
