part of dart_commons;


class PaperMenu extends ComponentList {

  num color;

  PaperMenu(List data, {this.color: PaperColor.GREY_DARK}) : super(Orientation.VERTICAL, PaperListCell, DefaultScrollbar, true) {
    snapToPage = true;
    touchEnabled = false;
    doubleClickEnabled = false;
    keyboardEnabled = false;
    doubleClickToZoom = false;
    bounce = false;//bounce if touchscreen
    mouseWheelEnabled = false;
    //list.hideScrollbarsOnIdle = true;
    setData(data);
    setSize(180, PaperListCell.CELL_HEIGHT * data.length);
  }

  @override
  Cell _getCell([bool pop = false]) {
    Cell cell;
    if (_reusableCellPool.length == 0) {
      cell = reflectClass(_cellClass).newInstance(new Symbol(""), [widthAsSet, color]).reflectee;
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

  @override void redraw() {

    filters = [ new DropShadowFilter(5, 90,PaperColor.GREY_SHADOW, 10, 10) ];
    super.redraw();
  }

}
