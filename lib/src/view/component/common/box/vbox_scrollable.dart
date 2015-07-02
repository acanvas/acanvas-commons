part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class VBoxScrollable extends ComponentScrollable {
  VBox _vbox;

  VBoxScrollable([int padding = 10, bool pixelSnapping = true, bool inverted = false, bool center = false]) {
    ignoreCallSetSize = false;

    _vbox = new VBox(padding, pixelSnapping, inverted, center);
    superConstructor(Orientation.VERTICAL, _vbox, new DefaultScrollbar());

    snapToPage = false;
    doubleClickEnabled = false;
    keyboardEnabled = false;
    doubleClickToZoom = false;
    bounce = ContextTool.MOBILE ? true : false;
    mouseWheelEnabled = ContextTool.MOBILE ? false : true;
    touchEnabled = ContextTool.MOBILE ? true : false;
    hideScrollbarsOnIdle = true;
  }

  @override
  void redraw() {
    super.redraw();
    GraphicsUtil.rectangle(0, 0, widthAsSet, heightAsSet, color: 0x00000000, sprite: this);
  }

  @override
  void addChild(DisplayObject child) {
    _view.addChild(child);
  }
}
