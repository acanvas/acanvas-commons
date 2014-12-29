part of stagexl_commons;

/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
class RadioButton extends Button {
  bool _isToggled = false;
  RadioButton() : super() {
  }

  @override
  void upAction([MouseEvent event = null]) {
    dispatchEvent(new ToggleButtonEvent(ToggleButtonEvent.TOGGLE));
    super.upAction(event);
  }

  void set isToggled(bool value) {
    _isToggled = value;
  }

  bool get isToggled {
    return _isToggled;
  }
}
