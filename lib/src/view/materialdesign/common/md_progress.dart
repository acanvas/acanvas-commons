part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class MdProgress extends Slider {
  int barColor;
  Sprite _progress;

  MdProgress(num min, num max, num size, {this.barColor: MdColor.BLACK, int bgColor: MdColor.WHITE})
      : super() {
    horizontalScrollBehavior = true;
    valueMin = min;
    valueMax = max;
    spanSize = size;
    momentumEnabled = false;

    RdGraphicsUtil.rectangle(0, 0, size, 2, color: bgColor, sprite: this);

    _progress = new Sprite();
    RdGraphicsUtil.rectangle(0, 0, 10, 2, color: barColor, sprite: _progress);
    _progress.alpha = 0;
    addChild(_progress);
  }

  @override
  void set value(num value) {
    super.value = value;
    _progress.width = thumb.x;
    _progress.alpha = 1;
  }
}
