part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class DefaultScrollbar extends Scrollbar {
  int color;

  DefaultScrollbar({this.color: PaperColor.BLACK}):super() {

    background = GraphicsUtil.rectangle(0, 0, 10, 10, color:0xFF000000);
    thumb = GraphicsUtil.rectangle(0, 0, 8, 8, color:color);

  }

  @override
  void refresh() {
    if (horizontalScrollBehavior) {
      GraphicsUtil.rectangle(0, 0, spanSize, 8, color:PaperColor.TRANSPARENT, sprite: background);
      thumb.y = 1;
    } else {
      GraphicsUtil.rectangle(0, 0, 8, spanSize, color:PaperColor.TRANSPARENT, sprite: background);
      thumb.x = 1;
    }

    super.refresh();
  }

}

