part of stagexl_commons;


class PaperIconButton extends PaperFab {

  PaperIconButton(SvgDisplayObject icon, {num radius: 20, int rippleColor: PaperColor.WHITE}) : super(icon, radius:radius, bgColor:PaperColor.TRANSPARENT, rippleColor:rippleColor, elevation : 0) {
    hover = false;
  }


  @override void redraw() {
    super.redraw();

    _shadow.x = _ripple.x = -4;
    _shadow.y = _ripple.y = -4;

    icon.x = 4;
    icon.y = 4;
  }

}
