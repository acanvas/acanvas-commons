part of stagexl_commons;

/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
class RadioButton extends Button {
  bool _isToggled = false;
  RadioButton() : super() {
  }

  @override
  void upAction([InputEvent event = null]) {
    dispatchEvent(new ToggleButtonEvent(ToggleButtonEvent.TOGGLE, true));
    super.upAction(event);
  }

  void set isToggled(bool value) {
    _isToggled = value;
  }

  bool get isToggled {
    return _isToggled;
  }
}
