part of stagexl_commons;

/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
class ToggleButton extends Button {
  bool _isToggled = false;
  ToggleButton() : super() {
  }

  @override
  void upAction([MouseEvent event = null]) {
    isToggled = !_isToggled;
    super.upAction(event);
  }

  bool get isToggled {
    return _isToggled;
  }

  void set isToggled(bool value) {
    _isToggled = value;
    dispatchEvent(new ToggleButtonEvent(ToggleButtonEvent.TOGGLE, _isToggled));
  }
}
