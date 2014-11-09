part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class VBox extends HBox {
  VBox([int padding = 10, bool pixelSnapping = true, bool inverted = false]) {
    _padding = padding;
    _pixelSnapping = pixelSnapping;
    _inverted = inverted;
    _ignoreCallSetSize = false;
  }

  @override
  void setSize(int w, int h) {
    _heightAsSet = h;
    super.setSize(w, 0);//sets only width of children
  }


  @override
  void setFixedSize(int size) {
    if (size != _size) {
      _size = size;
      if (numChildren > 1) {
        _padding = _calcPadding();
        update();
      }
    }
  }


  @override
  num _calcPadding() {
    int n = numChildren;
    num totalHeight = 0;
    DisplayObject dobj;
    for (int i = 0; i < n; i++) {
      dobj = getChildAt(i);
      if (dobj is ISpriteComponent) {
        totalHeight += (dobj as ISpriteComponent).heightAsSet == 0 ? dobj.height : (dobj as ISpriteComponent).heightAsSet;
      } else {
        totalHeight += dobj.height;
      }
    }

    return (_size - totalHeight) / (numChildren - 1);
  }


  @override
  void update() {
    if (_size != 0) _padding = _calcPadding();

    if (numChildren > 0) {
      int n = numChildren;
      DisplayObject child;
      DisplayObject prevChild;
      child = getChildAt(0);

      num ch;
      num ph;

      for (int i = 1; i < n; i++) {
        child = getChildAt(i);
        ch = child is ISpriteComponent && (child as ISpriteComponent).heightAsSet != 0 ? (child as ISpriteComponent).heightAsSet : child.height;
        prevChild = getChildAt(i - 1);
        ph = prevChild is ISpriteComponent && (prevChild as ISpriteComponent).heightAsSet != 0 ? (prevChild as ISpriteComponent).heightAsSet : prevChild.height;

        if (_inverted) {
          if (_pixelSnapping) child.y = (prevChild.y - ch - _padding).round(); else child.y = prevChild.y + ch - _padding;
        } else {
          if (_pixelSnapping) child.y = (prevChild.y + ph + _padding).round(); else child.y = prevChild.y + ph + _padding;
        }
      }
    }
  }
}
