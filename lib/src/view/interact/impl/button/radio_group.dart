part of rockdot_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class RadioGroup extends Flow {
  int _selectedButtonIndex = 0;

  void set selectedButtonIndex(int index) {
    _selectedButtonIndex = index;
  }

  int get selectedButtonIndex => _selectedButtonIndex;

  RadioGroup({FlowOrientation flowOrientation: FlowOrientation.VERTICAL, double spacing: 0.0}) : super() {
    this.flowOrientation = flowOrientation;
    this.spacing = spacing;
    inheritSpan = true;
  }

  @override
  void addChild(DisplayObject child) {
    super.addChild(child);
    _addRdChild(child);
  }

  @override
  void addChildAt(DisplayObject child, int index) {
    super.addChildAt(child, index);
    _addRdChild(child);
  }

  void _addRdChild(DisplayObject child) {
    if (child is SelectableButton) {
      child.submitCallback = _onBtnSubmit;
      child.selfSelect = false;
    } else {
      throw new StateError("Only SelectableButton allowed as children");
    }
  }

  void _onBtnSubmit(SelectableButton button) {
    selectButton(getChildIndex(button));
  }

  void selectButton(int index) {
    (getChildAt(_selectedButtonIndex) as MSelectable).selected = false;
    (getChildAt(index) as MSelectable).selected = true;
    _selectedButtonIndex = index;
    dispatchEvent(new RadioGroupEvent(RadioGroupEvent.BUTTON_SELECTED, index));
  }
}
