part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */

class Cell extends Button {
  int _id = 0;
  int get id => _id;
  void set id(int idd) {
    _id = idd;
  }
  
  dynamic _data;
  bool _isSelected = false;
  bool _isMultiselection = false;
  
  Cell() : super() {
  }

  dynamic get data {
    return _data;
  }

  void set data(dynamic data) {
    _data = data;
  }

  void select() {
    if (!_isSelected) {
      _isSelected = true;
      redraw();
      submitCallbackParams = [this];
      upAction();
    }
  }

  void deselect() {
    if (_isSelected) {
      _isSelected = false;
      redraw();
    }
  }

  bool get isSelected {
    return _isSelected;
  }

  bool get isMultiselection {
    return _isMultiselection;
  }

  void set isMultiselection(bool isMultiselection) {
    _isMultiselection = isMultiselection;
  }
}
