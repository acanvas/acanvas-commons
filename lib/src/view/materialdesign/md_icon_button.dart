part of acanvas_commons;

class MdIconButton extends MdFab {
  MdIconButton(SvgDisplayObject icon, {num radius: 20, int rippleColor: MdColor.WHITE})
      : super(icon,
            radius: radius, bgColor: MdColor.TRANSPARENT, rippleColor: rippleColor, shadow: false, hover: false) {}
}
