part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class VBoxScrollable extends ComponentScrollable {
  VBox _vbox;
  Sprite _background;

  VBoxScrollable([int padding = 10, bool pixelSnapping = true, bool inverted = false]) {
    ignoreCallSetSize = false;

    _vbox = new VBox(padding, pixelSnapping, inverted);
    superConstructor(Orientation.VERTICAL, _vbox, DefaultScrollbar);

    _background = new Sprite();
    super.addChildAt(_background,0);

    //swapChildren(_vbox, _background);

    hideScrollbarsOnIdle = false;
    mouseWheelEnabled = true;
  }

  @override
  void redraw() {
    super.redraw();
    GraphicsUtil.rectangle(0, 0, widthAsSet, _vbox.height, color: 0x00000000, sprite: _background);
  }

  @override
  void addChild(DisplayObject child) {
    _view.addChild(child);
  }
}
