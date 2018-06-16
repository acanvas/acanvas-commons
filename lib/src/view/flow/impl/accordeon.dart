part of acanvas_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class Accordeon extends Flow with MDuration {
  bool _multiselection = false;
  Timer _timer;

  Accordeon() : super() {
    duration = 0.3;
    spacing = 0;
    snapToPixels = false;
  }

  void _onSelectableButtonSelected(SelectableButton cell) {
    AccordeonButton selectedItem = cell as AccordeonButton;
    if (_multiselection) {
      _startAnimation(_duration);
    } else {
      deselectAll(selectedItem);
    }
  }

  //void _onSelectableButtonDeselected(SelectableButton cell) {
  //  _startAnimation(_duration);
  //}

  void deselectAll([AccordeonButton exception = null]) {
    int n = numChildren;
    AccordeonButton item;
    for (int i = 0; i < n; i++) {
      item = getChildAt(i) as AccordeonButton;
      if (item != exception) item.deselect();
    }
    _startAnimation(_duration);
  }

  void _startAnimation(num duration) {
    if (_timer != null) {
      _timer.cancel();
    }
    addEventListener(Event.ENTER_FRAME, _onEnterFrame);
    _timer = new Timer(new Duration(milliseconds: ((duration + 0.1) * 1000).round()),
        () => removeEventListener(Event.ENTER_FRAME, _onEnterFrame));
  }

  void _onEnterFrame(Event event) {
    refresh();
  }

  @override
  void addChild(DisplayObject child) {
    if (child is AccordeonButton) {
      child.submitCallback = _onSelectableButtonSelected;
      child.duration = _duration;
    }
    super.addChild(child);
  }
}

class AccordeonButton extends SelectableButton with MDuration {}
