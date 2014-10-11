part of stagexl_commons;

/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
class RadioButton extends Button {
  bool _isToggled = false;
  RadioButton() : super() {
  }

  @override
  void onClick([MouseEvent event = null]) {
    dispatchEvent(new ToggleButtonEvent(ToggleButtonEvent.TOGGLE));
    super.onClick(event);
  }

  void set isToggled(bool value) {
    _isToggled = value;
  }

  bool get isToggled {
    return _isToggled;
  }
}
