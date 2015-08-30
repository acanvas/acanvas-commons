part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class Flow extends BoxSprite with MFlow {

  Flow(/*{FlowOrientation flow : FlowOrientation.HORIZONTAL, double spacing: 0.0, bool distribute: false, bool snapToPixels: true, bool inverted: false, bool animate: false, bool reflow: false, AlignV alignV : AlignV.TOP}*/) {
    //inheritSpan = true;
    autoRefresh = true;
  }

  @override
  void refresh() {
    DisplayObject _prevChild;
    num _childHeight = 0;
    num _childWidth = 0;
    num _prevChildX = 0;
    num _prevChildWidth = 0;

    num _childXNew = 0;
    num _childYNew = 0;

    num _rowHeight = 0;
    num _totalHeight = 0;
    bool _newLine = false;

    //if distribution is requested, calculate spacing
    if (distribute) {
      children.forEach((child) {
        _childWidth += child is MBox ? (child as MBox).spanWidth : child.width;
      });
      spacing = (spanWidth - _childWidth) / (numChildren - 1);
    }

    //iterate all children
    children.forEach((child) {

      //get width and height values of child
      if (child is MBox /*&& !(child is MFlow)*/) {
        _childWidth = child.spanWidth;
        _childHeight = child.spanHeight;
      }
      else {
        _childWidth = child.width;
        _childHeight = child.height;
      }

      //get values of previous child
      _prevChildWidth = _prevChild == null ? 0 : _prevChild is MBox ? (_prevChild as MBox).spanWidth : _prevChild.width;
      _prevChildX = _prevChild == null ? (inverted ? spanWidth - padding + spacing : padding - spacing) : _prevChild.x;


      //calculate child X in inverted mode
      if (inverted) {

        if (snapToPixels) _childXNew = (_prevChildX - _childWidth - spacing).round();
        else _childXNew = _prevChildX - _childWidth - spacing;

        //row space is full
        if ((spanWidth > 0 && reflow && _childXNew < padding) || flowOrientation == FlowOrientation.VERTICAL) {
          _childXNew = spanWidth - padding - _childWidth;
          if (_prevChild != null) _newLine = true;
        }
      }
      //calculate child X in normal mode
      else {

        if (snapToPixels) _childXNew = (_prevChildX + _prevChildWidth + spacing).round();
        else _childXNew = _prevChildX + _prevChildWidth + spacing;

        //row space is full
        if ((spanWidth > 0 && reflow && _childXNew + _childWidth + spacing > spanWidth) || flowOrientation == FlowOrientation.VERTICAL) {
          _childXNew = padding;
          if (_prevChild != null) _newLine = true;
        }
      }

      //calculate child Y offset
      if (_newLine) {
        _totalHeight += (_rowHeight + spacing).round();
        _rowHeight = 0;
        _newLine = false;
      }

      if (flowOrientation == FlowOrientation.VERTICAL) {
        //calculate height of current row (only in VERTICAL mode)
        _rowHeight = _childHeight;
        if (alignH == AlignH.CENTER) {
          _childXNew = (spanWidth / 2 - _childWidth / 2).round();
        }
      }else{
        //calculate height of current row (only in HORIZONTAL mode)
        _rowHeight = max(_rowHeight, _childHeight);

      }


      //calculate child Y including vertical alignment
      switch (alignV) {
        case AlignV.TOP:
          _childYNew = padding + _totalHeight;
          break;
        case AlignV.CENTER:
          _childYNew = (spanHeight / 2 - _childHeight / 2).round();
          break;
        case AlignV.BOTTOM:
          _childYNew = (spanHeight - _totalHeight - _childHeight - padding).round();
          break;
      }


      //set x, y, animate
      if (animate) {
        ContextTool.JUGGLER.addTween(child, 0.2)
          ..animate.alpha.to(1.0)
          ..animate.x.to(_childXNew)
          ..animate.y.to(_childYNew);
      }
      else {
        child.x = _childXNew;
        child.y = _childYNew;
      }

      if (flowOrientation == FlowOrientation.VERTICAL) {
        //GraphicsUtil.rectangle(0, 0, _childWidth, _childHeight, color: 0x88FF0000, sprite: child);
      }

      _prevChild = child;

    });

    super.refresh();

    num _spacer = (flowOrientation == FlowOrientation.HORIZONTAL && reflow == true) ? spacing : 0;
    span(width, _childYNew + _spacer + _childHeight + padding, refresh: false);

  }

  @override
  void addChildAt(DisplayObject child, int index) {
    if (animate) {
      child.alpha = 0;
    }
    super.addChildAt(child, index);
  }

  @override void removeChildAt(int index) {
    if (animate) {
      DisplayObject child = getChildAt(index);
      ContextTool.JUGGLER.addTween(child, 0.2)
        ..animate.alpha.to(0.0)
        ..onComplete = () => super.removeChildAt(index);
    }
    else {
      super.removeChildAt(index);
    }
  }

}
