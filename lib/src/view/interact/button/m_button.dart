part of stagexl_commons;

abstract class MButton {
  String _labelText;
  void set labelText (String labelText) {
    _labelText = labelText;
  }
  String get labelText => _labelText;

  bool _toggleable = false;
  void set toggleable (bool toggleable) => _toggleable = toggleable;
  bool get toggleable => _toggleable;
  
  bool _toggled = false;
  void set toggled (bool toggled) => _toggled = toggled;
  bool get toggled => _toggled;
  
  bool _inheritDownAction = false;
  void set inheritDownAction (bool inheritDownAction) => _inheritDownAction = inheritDownAction;
  bool get inheritDownAction => _inheritDownAction;

  bool _inheritUpAction = false;
  void set inheritUpAction (bool inheritUpAction) => _inheritUpAction = inheritUpAction;
  bool get inheritUpAction => _inheritUpAction;
  
  bool _inheritRollOverAction = false;
  void set inheritRollOverAction (bool inheritRollOverAction) => _inheritRollOverAction = inheritRollOverAction;
  bool get inheritRollOverAction => _inheritRollOverAction;
  
  bool _inheritRollOutAction = false;
  void set inheritRollOutAction (bool inheritRollOutAction) => _inheritRollOutAction = inheritRollOutAction;
  bool get inheritRollOutAction => _inheritRollOutAction;

  void downAction([InputEvent event = null]);
  void upAction([InputEvent event = null, bool submit = true]);
  void rollOverAction([InputEvent event = null]);
  void rollOutAction([InputEvent event = null]);

}
