part of stagexl_commons;


/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class ListSprite extends ScrollifySprite with MList {
  //

  SelectableButton _cellFactory;
  List _cellPool = [];
  num _cellSize = 0;
  SelectableButton _mouseDownCell;
  Map _selectedCells = {};


  bool _cellMoved = false;
  int _cellsLoaded = 0;
  int _scrollPos = 0;
  int _totalCellSize = 0;
  int _oldVScrollbarValue = 0;
  Timer _timer;


  num _originX = 0;
  num _originY = 0;


  ListSprite(List data, SelectableButton cell, Scrollbar hScrollbar, Scrollbar vScrollbar) : super(new BoxSprite(), hScrollbar, vScrollbar) {
    this.data = data;
    _cellFactory = cell;
    _cellSize = _cellFactory.spanHeight;
  }

  @override
  void span(spanWidth, spanHeight, {bool refresh: true}) {
    super.span(spanWidth, spanHeight, refresh: refresh);
    _cellFactory.span(spanWidth, spanHeight, refresh: false);
    init();
  }

  @override
  void refresh() {
    super.refresh();
    _updateCells();
  }

  @override
  void set touchable(bool touchable) {
    super.touchable = touchable;
    if (touchable) {
      view.children.forEach((child) {
        child.disable();
      });
    }
  }


  void init() {
    _scrollPos = 0;
    _oldVScrollbarValue = 0;
    _totalCellSize = 0;
    _selectedCells = new Map();
    _cellsLoaded = 0;
    int numDataEntries = data.length;
    SelectableButton cell;
    int fromIndex = _cellsLoaded;
    int i;

    // Constant cell height
    if (_constantCellSize) {
      //size of a cell incl spacing
      _cellSize = (_horizontalFlow ? _cellFactory.spanWidth : _cellFactory.spanHeight) + spacing;
      //size of all cells
      _totalCellSize = (numDataEntries * _cellSize - spacing).round();
      //length of data - unsure if needed
      _cellsLoaded = numDataEntries;
      //how many cells fit into visible area?
      int cellsInFrame = ((_horizontalFlow ? spanWidth : spanHeight) / _cellSize).ceil();
      //iterate all data
      for (i = 0; i < numDataEntries; i++) {
        //if in visible area, create cell
        if (i < cellsInFrame) {
          cell = _getCell();
          cell.id = i;
          cell.data = data.elementAt(i);
          _horizontalFlow ? cell.x = i * _cellSize : cell.y = i * _cellSize;

          view.addChild(cell);
        }
        //fill up lookup
        _selectedCells[i] = false;

      }
    } else {
      // Variable cell height
      for (i = fromIndex; i < _bufferSize; i++) {
        if (i < numDataEntries) {
          if (i == fromIndex) _scrollPos = -_totalCellSize;
          cell = _getCell();
          cell.id = i;
          cell.data = data.elementAt(i);
          if (_totalCellSize < (_horizontalFlow ? spanWidth : spanHeight)) {
            // Show cell
            _horizontalFlow ? cell.x = _totalCellSize : cell.y = _totalCellSize;
            _totalCellSize += ((_horizontalFlow ? cell.spanWidth : cell.spanHeight)).round() + spacing;
            view.addChild(cell);
          } else {
            // Only precalculate cell height
            _totalCellSize += ((_horizontalFlow ? cell.spanWidth : cell.spanHeight)).round() + spacing;
            _putCellInPool(cell);
          }
          _selectedCells[i] = false;
          _cellsLoaded++;
        }
      }
      _totalCellSize -= spacing;
    }
    refresh();
    if ((_horizontalFlow ? _hScrollbar : _vScrollbar).enabled) {
      (_horizontalFlow ? _hScrollbar : _vScrollbar).value = -_scrollPos;
    }
  }

  void _calcNextCells() {
    if (data == null) {
      return;
    }

    int numDataEntries = data.length;
    SelectableButton cell;
    int fromIndex = _cellsLoaded;
    int n = _cellsLoaded + _bufferSize;
    for (int i = fromIndex; i < n; i++) {
      if (i < numDataEntries) {
        cell = _getCell();
        cell.id = i;
        cell.data = data.elementAt(i);

        // Only precalculate cell height
        _totalCellSize += ((_horizontalFlow ? cell.spanWidth : cell.spanHeight)).round() + spacing;
        _putCellInPool(cell);
        _selectedCells[i] = false;
        _cellsLoaded++;
      }
    }
    updateScrollbars();
  }

  void selectCellByVO(dynamic vo) {
    deselectAllCells();
    int i = 0;
    for (i = 0;i < this.data.length;i++) {
      if (vo == this.data[i]) {
        jumpToCell(i);
        break;
      }
    }

    view.children.forEach((child) {
      if (child is SelectableButton) {
        if ((child as SelectableButton).id == i) {
          child.select();
        }
      }
    });
  }


  void jumpToCell(int nr) {
    _vScrollbar.killPageTween();
    clearMomentum();
    (_horizontalFlow ? _hScrollbar : _vScrollbar).interactionStart();
    if (_constantCellSize) {
      if ((_horizontalFlow ? _hScrollbar : _vScrollbar).enabled) (_horizontalFlow ? _hScrollbar : _vScrollbar).value = nr * _cellSize;
    } else {
      if ((_horizontalFlow ? _hScrollbar : _vScrollbar).enabled) {
        SelectableButton cell;
        int targetPos;
        cell = _getCell();
        for (int i = 0; i < nr; i++) {
          cell.id = i;
          cell.data = data.elementAt(i);
          targetPos += ((_horizontalFlow ? cell.spanWidth : cell.spanHeight) + spacing).round();
        }

        int safetyFlag = -1;
        while ((_horizontalFlow ? _hScrollbar : _vScrollbar).value != targetPos) {
          if (safetyFlag != (_horizontalFlow ? _hScrollbar : _vScrollbar).value) {
            safetyFlag = (_horizontalFlow ? _hScrollbar : _vScrollbar).value;
            (_horizontalFlow ? _hScrollbar : _vScrollbar).value = targetPos;
          } else {
            break;
          }
        }
      }
    }
    (_horizontalFlow ? _hScrollbar : _vScrollbar).interactionEnd();
  }


  @override
  void updateScrollbars() {
    if (_horizontalFlow) {
      _hScrollbar.enabled = _totalCellSize > spanWidth;
      _hScrollbar.valueMax = max(0, _totalCellSize - spanWidth);
      _vScrollbar.enabled = view.height > spanHeight;
      _vScrollbar.valueMax = max(0, view.height - spanHeight);
    } else {
      _hScrollbar.enabled = view.width > spanWidth;
      _hScrollbar.valueMax = max(0, view.width - spanWidth);
      _vScrollbar.enabled = _totalCellSize > spanHeight;
      _vScrollbar.valueMax = max(0, _totalCellSize - spanHeight);
    }
    if (_hScrollbar.enabled || _vScrollbar.enabled) {
      mouseWheelEnabled = true;
    }
    _updateThumbs();
  }


  @override
  void _updateThumbs() {
    if (_horizontalFlow) {
      _hScrollbar.pageCount = _totalCellSize / spanWidth;
      _vScrollbar.pageCount = view.height / spanHeight;
    } else {
      _hScrollbar.pageCount = view.width / spanWidth;
      _vScrollbar.pageCount = _totalCellSize / spanHeight;
    }
  }


  void _onHScrollbarChange(SliderEvent event) {
    if (_horizontalFlow) _onListScrollbarChange(event);
    //else _onHScrollbarChange(event);
  }


  void _onVScrollbarChange(SliderEvent event) {
    if (_horizontalFlow == false) _onListScrollbarChange(event);
    //else _onVScrollbarChange(event);
  }


  void _onListScrollbarChange(SliderEvent event) {
    _scrollPos = _oldVScrollbarValue - event.value;
    _oldVScrollbarValue = event.value;
    _updateCells();
  }


  void _updateCells() {

    int n = view.numChildren;
    SelectableButton cell;
    List cellsToPool = [];
    // Push not visible cells to "cellsToPool"
    for (int i = 0; i < n; i++) {
      cell = (view.getChildAt(i) as SelectableButton);
      _horizontalFlow ? cell.x += _scrollPos : cell.y += _scrollPos;
      if ((_horizontalFlow ? cell.x : cell.y) + (_horizontalFlow ? cell.spanWidth : cell.spanHeight) < 0 || (_horizontalFlow ? cell.x : cell.y) > (_horizontalFlow ? spanWidth : spanHeight)) cellsToPool.add(cell);
    }

    // Put collected cells in pool
    n = cellsToPool.length;
    for (int i = 0; i < n; i++) {
      _putCellInPool(cellsToPool.elementAt(i));
    }

    // Check, if scrolling up or down
    bool firstLoop;
    if (_scrollPos > 0) {
      // Scrolling up
      cell = view.numChildren != 0 ? (view.getChildAt(0) as SelectableButton) : _getCell(true);
      firstLoop = true;
      while ((_horizontalFlow ? cell.x : cell.y) > 0) {
        if (firstLoop != null) {
          if (cell.parent == null) _putCellInPool(cell);
          firstLoop = false;
        }
        cell = _unshiftNewCell(cell);
        if (cell == null) break;
        (_horizontalFlow ? cell.x : cell.y) > (_horizontalFlow ? spanWidth : spanHeight) ? _putCellInPool(cell) : view.addChildAt(cell, 0);
      }
    } else if (_scrollPos < 0) {
      // Scrolling down
      cell = view.numChildren != 0 ? (view.getChildAt(view.numChildren - 1) as SelectableButton) : _getCell(true);
      firstLoop = true;

      while ((_horizontalFlow ? cell.x : cell.y) + (_horizontalFlow ? cell.spanWidth : cell.spanHeight) < (_horizontalFlow ? spanWidth : spanHeight)) {
        if (firstLoop != null) {
          if (cell.parent == null) _putCellInPool(cell);
          firstLoop = false;
        }
        cell = _addNewCell(cell);
        if (cell == null) {
          break;
        }
        (_horizontalFlow ? cell.x : cell.y) + (_horizontalFlow ? cell.spanWidth : cell.spanHeight) < 0 ? _putCellInPool(cell) : view.addChild(cell);
      }
    } else {

      // Just update (e.g. render())
      cell = view.numChildren != 0 ? (view.getChildAt(0) as SelectableButton) : _getCell(true);
      firstLoop = true;
      while ((_horizontalFlow ? cell.x : cell.y) > 0) {
        if (firstLoop) {
          if (cell.parent == null) _putCellInPool(cell);
          firstLoop = false;
        }
        cell = _unshiftNewCell(cell);
        if (cell == null) break;
        (_horizontalFlow ? cell.x : cell.y) > (_horizontalFlow ? spanWidth : spanHeight) ? _putCellInPool(cell) : view.addChildAt(cell, 0);
      }
      cell = view.numChildren != 0 ? (view.getChildAt(view.numChildren - 1) as SelectableButton) : _getCell(true);

      firstLoop = true;
      while ((_horizontalFlow ? cell.x : cell.y) + (_horizontalFlow ? cell.spanWidth : cell.spanHeight) < (_horizontalFlow ? spanWidth : spanHeight)) {
        if (firstLoop) {
          if (cell.parent == null) _putCellInPool(cell);
          firstLoop = false;
        }
        cell = _addNewCell(cell);
        if (cell == null) break;
        (_horizontalFlow ? cell.x : cell.y) + (_horizontalFlow ? cell.spanWidth : cell.spanHeight) < 0 ? _putCellInPool(cell) : view.addChild(cell);
      }
    }

    if (_oldVScrollbarValue >= (_horizontalFlow ? _hScrollbar : _vScrollbar).valueMax) {
      _calcNextCells();
    }
  }

  SelectableButton _addNewCell(SelectableButton oldCell) {
    if (oldCell.id + 1 >= data.length) return null;

    SelectableButton newCell = _getCell();
    newCell.id = oldCell.id + 1;
    newCell.data = data[newCell.id];
    newCell.visible = newCell.data != null;
    _selectedCells[newCell.id] == true ? newCell.select() : newCell.deselect();

    num pos = ((_horizontalFlow ? oldCell.x : oldCell.y) + (_horizontalFlow ? oldCell.spanWidth : oldCell.spanHeight)).round() + spacing;
    _horizontalFlow ? newCell.x = pos : newCell.y = pos;

    return newCell;
  }


  SelectableButton _unshiftNewCell(SelectableButton oldCell) {
    if (oldCell.id - 1 < 0) return null;

    SelectableButton newCell = _getCell();
    newCell.id = oldCell.id - 1;
    newCell.data = data[newCell.id];
    newCell.visible = newCell.data != null;
    _selectedCells[newCell.id] == true ? newCell.select() : newCell.deselect();

    num pos = ((_horizontalFlow ? oldCell.x : oldCell.y) - (_horizontalFlow ? newCell.spanWidth : newCell.spanHeight)).round() - spacing;
    _horizontalFlow ? newCell.x = pos : newCell.y = pos;

    return newCell;
  }

  SelectableButton _getCell([bool pop = false]) {
    SelectableButton cell;
    if (_cellPool.length == 0) {
      cell = _cellFactory.clone();
      cell.span(spanWidth, spanHeight);
      cell.mouseChildren = false;
      cell.autoSelect = false;
      if (touchable) {
        cell.enabled = false;
      }

      if (ContextTool.TOUCH) {
        cell.addEventListener(TouchEvent.TOUCH_BEGIN, _onCellMouseDown, useCapture: false, priority: 0);
        cell.addEventListener(TouchEvent.TOUCH_END, _onCellMouseUp, useCapture: false, priority: 0);
      }
      else {
        cell.addEventListener(MouseEvent.MOUSE_DOWN, _onCellMouseDown, useCapture: false, priority: 0);
        cell.addEventListener(MouseEvent.MOUSE_UP, _onCellMouseUp, useCapture: false, priority: 0);
      }

      cell.submitCallback = _onCellSelected;
    }
    else {
      cell = pop ? _cellPool.removeLast() : _cellPool.removeAt(0);
      cell.span(spanWidth, spanHeight);
    }
    return cell;
  }


  void _onCellMouseDown(InputEvent event) {
    _cellMoved = false;

    _originX = event.stageX;
    _originY = event.stageY;

    _mouseDownCell = (event.currentTarget as SelectableButton);
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = new Timer(new Duration(milliseconds: 500), _onDelayedCellMouseDown);
  }


  void _onDelayedCellMouseDown() {
    if (_mouseDownCell != null) {

      if (touchable) {
        deselectAllCells();
      }
      _mouseDownCell.select();
    }
  }


  void _onCellMouseUp(InputEvent event) {
    if (!_cellMoved && _mouseDownCell != null) {
      if (touchable) {
        deselectAllCells();
      }
      _mouseDownCell.select();
      if (_submitCallback != null) {
        _submitCallback.call(_mouseDownCell);
      }
    }
    _mouseDownCell = null;
  }


  void _putCellInPool(SelectableButton cell) {
    cell.inheritDispose = false;
    if (cell.parent != null) cell.parent.removeChild(cell);
    _cellPool.add(cell);
    _selectedCells[cell.id] = cell.selected;
  }


  void deselectAllCells([int exception = -1]) {
    int n = view.numChildren;
    SelectableButton cell;
    for (int i = 0; i < n; i++) {
      cell = (view.getChildAt(i) as SelectableButton);
      if (cell.id != exception) {
        //print("selected ${cell.id}");
        cell.deselect();
      }
      else {
        //print("exception ${cell.id}");
      }
    }

    n = _selectedCells.length;
    for (int i = 0; i < n; i++) {
      _selectedCells[i] = false;
    }
  }


  @override
  void _onViewMouseDown(InputEvent event) {
    if (_touching) return;
    _touching = true;
    if (_hScrollbar.enabled) {
      _hScrollbar.interactionStart(false, false);
      _mouseOffsetX = event.stageX + _hScrollbar.value;
    } else {
      _mouseOffsetX = event.stageX;
    }

    if (_vScrollbar.enabled) {
      _vScrollbar.interactionStart(false, false);
      _mouseOffsetY = event.stageY + _vScrollbar.value;
    } else {
      _mouseOffsetY = event.stageY;
    }

    if (ContextTool.TOUCH) {
      stage.addEventListener(TouchEvent.TOUCH_END, _onStageMouseUp, useCapture: false, priority: 0);
      stage.addEventListener(TouchEvent.TOUCH_MOVE, _onStageMouseMove, useCapture: false, priority: 0);
    }
    else {
      stage.addEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp, useCapture: false, priority: 0);
      stage.addEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove, useCapture: false, priority: 0);
    }
  }


  @override
  void _onStageMouseMove(InputEvent event) {
    super._onStageMouseMove(event);

    if ((_originX - event.stageX).abs() > 3 || (_originY - event.stageY).abs() > 3) {
      _cellMoved = true;
      _timer.cancel();
      //if (_mouseDownCell != null) _mouseDownCell.deselect();
    }
  }


  void _onCellSelected([SelectableButton cell = null]) {
    if (cell != null) {
      deselectAllCells(cell.id);
    }
  }

}