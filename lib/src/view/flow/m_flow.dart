part of stagexl_commons;

/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
enum FlowOrientation {HORIZONTAL, VERTICAL}

abstract class MFlow  {

  FlowOrientation _flow = FlowOrientation.HORIZONTAL;
  void set flowOrientation (FlowOrientation flow) => _flow = flow;
  FlowOrientation get flowOrientation => _flow;

  num _spacing = 0.0;
  void set spacing (num spacing) => _spacing = spacing;
  num get spacing => _spacing;

  bool _distribute = false;
  void set distribute (bool distribute) => _distribute = distribute;
  bool get distribute => _distribute;

  bool _snapToPixels = true;
  void set snapToPixels (bool snapToPixels) => _snapToPixels = snapToPixels;
  bool get snapToPixels => _snapToPixels;

  bool _inverted = false;
  void set inverted (bool inverted) => _inverted = inverted;
  bool get inverted => _inverted;

  bool _reflow = false;
  void set reflow (bool reflow) {_reflow = reflow;}
  bool get reflow => _reflow;
  
  bool _animate = false;
  void set animate (bool animate) => _animate = animate;
  bool get animate => _animate;

  void refresh();

}
