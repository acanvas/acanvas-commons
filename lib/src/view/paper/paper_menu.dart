part of stagexl_commons;


class PaperMenu extends ComponentList {

  num color;
  bool shadow = false;
  PaperListCell _cellFactory;


  PaperMenu(List data, {this.color: PaperColor.GREY_DARK, PaperListCell cell, this.shadow : true}) : super(Orientation.VERTICAL, cell, new DefaultScrollbar(), true) {
    _cellFactory = cell != null ? cell : new PaperListCell(10);

    snapToPage = false;
    touchEnabled = false;
    doubleClickEnabled = false;
    keyboardEnabled = false;
    doubleClickToZoom = false;
    bounce = false;
    mouseWheelEnabled = true;
    hideScrollbarsOnIdle = false;
    setData(data);

    PaperShadow _paperShadow = new PaperShadow(type : PaperShadow.RECTANGLE, bgColor: PaperColor.WHITE, shadowEnabled : shadow);
    addChildAt(_paperShadow, 0);

    setSize(PaperDimensions.WIDTH_MENU, PaperDimensions.HEIGHT_MENU_CELL * data.length);
  }

  @override
  Cell _getCell([bool pop = false]) {
    Cell cell;
    if (_reusableCellPool.length == 0) {
      cell = _cellFactory.clone(widthAsSet, color);
      //cell.setSize(widthAsSet, heightAsSet);
      cell.mouseChildren = false;
      cell.addEventListener(MouseEvent.MOUSE_DOWN, _onCellMouseDown, useCapture: false, priority: 0);
      cell.addEventListener(MouseEvent.MOUSE_UP, _onCellMouseUp, useCapture: false, priority: 0);
      cell.submitCallback = _onCellSelected;
      return cell;
    }
    cell = pop ? _reusableCellPool.removeLast() : _reusableCellPool.removeAt(0);
    //cell.setSize(widthAsSet, heightAsSet);
    return cell;
  }

}
