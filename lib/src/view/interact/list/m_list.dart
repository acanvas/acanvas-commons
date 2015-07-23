part of stagexl_commons;

/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
enum ListDirection {HORIZONTAL, VERTICAL}

abstract class MList {

  bool _horizontalFlow = false;

  ListDirection _listDirection;
  void set listDirection (ListDirection listDirection) {
    _listDirection = listDirection;
    _horizontalFlow = listDirection == ListDirection.HORIZONTAL ? true : false;
  }
  ListDirection get listDirection => _listDirection;

  num _spacing = 0.0;
  void set spacing (num spacing) => _spacing = spacing;
  num get spacing => _spacing;

  IDataProxy _proxy;
  IDataProxy get listProxy => _proxy;
  void set listProxy(IDataProxy m) {
    _proxy = m;
  }

  List _data = [];
  List get data => _data;
  set data(List data) { _data = data; }

  int _bufferSize = 20;
  int get bufferSize => _bufferSize;
  void set bufferSize(int bufferSize){ _bufferSize = bufferSize;}

  bool _constantCellSize = true;
  void set constantCellSize (bool constantCellSize) => _constantCellSize = constantCellSize;
  bool get constantCellSize => _constantCellSize;

}