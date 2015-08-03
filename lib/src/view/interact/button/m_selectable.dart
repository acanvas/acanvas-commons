part of stagexl_commons;

abstract class MSelectable {

  int _id = 0;

  int get id => _id;

  void set id(int id) {
    _id = id;
  }

  dynamic _data;

  dynamic get data => _data;

  set data(dynamic data) {
    _data = data;
  }

  bool _multiSelectable = false;

  bool get multiSelectable => _multiSelectable;

  void set multiSelectable(bool multiSelectable) {
    _multiSelectable = multiSelectable;
  }

  bool _autoSelect = false;

  bool get autoSelect => _autoSelect;

  void set autoSelect(bool autoSelect) {
    _autoSelect = autoSelect;
  }

  bool _selected = false;

  bool get selected => _selected;

  void set selected(bool selected) {
    if (_selected != selected) {
      if (selected) {
        select();
      }
      else {
        deselect();
      }
      _selected = selected;
    }
  }

  void select({bool submit : false});

  void selectAction() {
  }

  void deselect();

  void deselectAction() {
  }

}
