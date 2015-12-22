part of rockdot_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class DefaultScrollbar extends Scrollbar {
  int color;

  DefaultScrollbar({this.color: MdColor.BLACK}) : super() {
    background = RdGraphics.rectangle(0, 0, 10, 10, color: MdColor.TRANSPARENT);
    thumb = RdGraphics.rectangle(0, 0, 8, 8, color: color);
  }

  @override
  void refresh() {
    if (horizontalScrollBehavior) {
      RdGraphics.rectangle(0, 0, spanSize, 10, color: MdColor.TRANSPARENT, sprite: background);
      thumb.y = 1;
    } else {
      RdGraphics.rectangle(0, 0, 10, spanSize, color: MdColor.TRANSPARENT, sprite: background);
      thumb.x = 1;
    }

    super.refresh();
  }
}
