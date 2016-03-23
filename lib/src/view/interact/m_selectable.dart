part of rockdot_commons;

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


  bool _selfSelect = false;

  bool get selfSelect => _selfSelect;

  void set selfSelect(bool selfSelect) {
    _selfSelect = selfSelect;
  }

  bool _selected = false;

  bool get selected => _selected;

  void set selected(bool selected) {
    if (_selected != selected) {
      if (selected) {
        select();
      } else {
        deselect();
      }
      _selected = selected;
    }
  }

  void select({bool submit: false});

  void selectAction() {}

  void deselect();

  void deselectAction() {}
}
