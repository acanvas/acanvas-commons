part of acanvas_commons;

class MdFab extends Button {
  bool hover = false;
  bool shadow = true;

  SvgDisplayObject icon;
  MdShadow _shadow;
  MdRipple _ripple;

  MdFab(this.icon,
      {num radius: 30,
      int bgColor: MdColor.BLUE,
      int shadowColor: MdColor.GREY_SHADOW,
      int rippleColor: MdColor.WHITE,
      this.shadow: true,
      this.hover: true})
      : super() {
    _shadow = new MdShadow(type: MdShadow.CIRCLE, bgColor: bgColor, shadowEnabled: shadow ? true : false);
    addChild(_shadow);

    _ripple = new MdRipple(type: MdRipple.CIRCLE, color: rippleColor);
    addChild(_ripple);

    addChild(icon);

    span(radius * 2, radius * 2);
  }

  void set opacity(num o) {
    _ripple.opacity = o;
  }

  @override
  void refresh() {
    icon.pivotX = 12;
    icon.pivotY = 12;
    icon.x = (spanWidth / 2).ceil();
    icon.y = (spanHeight / 2).ceil();

    super.refresh();
  }

  void rollOverAction([InputEvent event = null]) {
    if (stage == null || !hover) return;
    Ac.JUGGLER.addTween(icon, .1).animate..scaleX.to(1.2)..scaleY.to(1.2);
    // _shadow.downAction();
  }

  void rollOutAction([InputEvent event = null]) {
    if (stage == null || !hover) return;
    Ac.JUGGLER.addTween(icon, .1).animate..scaleX.to(1)..scaleY.to(1);
    //  _shadow.upAction();
  }
}
