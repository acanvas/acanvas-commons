part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */

abstract class MPager {
  List chunksPlaced = [];
  int chunkSize = 8;

  int hasPrev = 0;
  bool hasNext = false;
  bool loaded = false;

  bool pressedNext = false;

  bool disableClick = false;

  int _listItemWidth = 0;

  int get listItemWidth => _listItemWidth;

  void set listItemWidth(int listItemWidth) {
    _listItemWidth = listItemWidth;
  }

  int _listItemHeight = 0;

  int get listItemHeight => _listItemHeight;

  void set listItemHeight(int listItemHeight) {
    _listItemHeight = listItemHeight;
  }

  int _listItemSpacer = 0;

  int get listItemSpacer => _listItemSpacer;

  void set listItemSpacer(int listItemSpacer) {
    _listItemSpacer = listItemSpacer;
  }

  int _rows = 1;

  int get rows => _rows;

  void set rows(int rows) {
    if (rows == 0) rows++;
    _rows = rows;
  }
}
