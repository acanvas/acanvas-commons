part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class HBoxScrollable extends ComponentScrollable {
  HBox _hbox;
  Sprite _background;

  HBoxScrollable([int padding = 10, bool pixelSnapping = true, bool inverted = false]) {
    ignoreCallSetSize = false;

    _hbox = new HBox(padding, pixelSnapping, inverted);
    superConstructor(Orientation.HORIZONTAL, _hbox, DefaultScrollbar);

    _background = new Sprite();
    addChild(_background);

    hideScrollbarsOnIdle = true;
    mouseWheelEnabled = true;
  }

  @override
  void redraw() {
    super.redraw();
    GraphicsUtil.rectangle(0, 0, widthAsSet, heightAsSet, color: 0x00000000, sprite: _background);
  }

  @override
  void addChild(DisplayObject child) {
    _view.addChild(child);
  }
}
