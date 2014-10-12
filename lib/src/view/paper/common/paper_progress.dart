part of stagexl_commons;


/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
class PaperProgress extends Slider {
  
  int barColor;
  Sprite _progress;
  
  PaperProgress(num min, num max, num size, {this.barColor : PaperColor.BLACK, int bgColor: PaperColor.WHITE}) : super(Orientation.HORIZONTAL, min, max, size, false) {
    background = GraphicsUtil.rectangle(0, 0, size, 2, color: bgColor, sprite: background);
    addChild(background);
    
    _progress = new Sprite();
    addChild(_progress);
  }

  @override
  void set value(num value) {
    super.value = value;
    GraphicsUtil.rectangle(0, 0, thumb.x, 2, color: barColor, sprite: _progress);
  }
}
