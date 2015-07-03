part of stagexl_commons;


class PaperIconButton extends PaperFab {

  PaperIconButton(SvgDisplayObject icon, {num radius: 20, int rippleColor: PaperColor.WHITE}) : super(icon, radius:radius, bgColor:PaperColor.TRANSPARENT, rippleColor:rippleColor, shadow : false, hover: false) {
  }
}
