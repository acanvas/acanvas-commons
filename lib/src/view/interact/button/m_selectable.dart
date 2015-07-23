part of stagexl_commons;

abstract class MSelectable {

  int _id = 0;
  int get id => _id;
  void set id(int id) { _id = id; }

  dynamic _data;
  dynamic get data => _data;
  set data(dynamic data) { _data = data; }

  bool _multiSelectable = false;
  bool get multiSelectable =>  _multiSelectable;
  void set multiSelectable(bool multiSelectable) { _multiSelectable = multiSelectable; }

  void select();
  void deselect();

}
