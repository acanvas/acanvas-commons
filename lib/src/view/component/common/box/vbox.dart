part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class VBox extends HBox {
  VBox([int padding = 10, bool pixelSnapping = true, bool inverted = false, bool center = false]) {
    _padding = padding;
    _pixelSnapping = pixelSnapping;
    _inverted = inverted;
    _center = center;
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
        totalHeight += dobj.heightAsSet == 0 ? dobj.height : dobj.heightAsSet;
      } else {
        totalHeight += dobj.height;
      }
    }

    return (_size - totalHeight) / (numChildren - 1);
  }

  @override redraw(){
    super.redraw();
    if(_center == true){
      children.forEach((child){

        if(child is ISpriteComponent){
            child.x = (widthAsSet/2 - (child.widthAsSet != 0 ? child.widthAsSet : child.width)/2).round();
        }
        else{
            child.x = (widthAsSet/2 - child.width/2).round();
        }
      });
    }
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

        if(child is ISpriteComponent){
          ch = child.heightAsSet != 0 ? child.heightAsSet : child.height;
          if(_center == true){
            child.x = ((child.widthAsSet != 0 ? child.widthAsSet : child.width)/2 - widthAsSet/2).round();
          }
        }
        else{
          ch = child.height;
          if(_center == true){
            child.x = (child.width/2 - widthAsSet/2).round();
          }
        }


        prevChild = getChildAt(i - 1);
        ph = prevChild is ISpriteComponent && prevChild.heightAsSet != 0 ? prevChild.heightAsSet : prevChild.height;

        if (_inverted) {
          if (_pixelSnapping) child.y = (prevChild.y - ch - _padding).round(); else child.y = prevChild.y + ch - _padding;
        } else {
          if (_pixelSnapping) child.y = (prevChild.y + ph + _padding).round(); else child.y = prevChild.y + ph + _padding;
        }
      }
    }
  }
}
