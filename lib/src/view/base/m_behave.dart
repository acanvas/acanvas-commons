part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */

abstract class MBehave {
  bool _touchable = ContextTool.MOBILE ? true : false;

  void set touchable(bool touchable) {
    _touchable = touchable;
  }

  bool get touchable => _touchable;

  bool _inheritTouchable = true;

  void set inheritTouchable(bool inheritTouchable) {
    _inheritTouchable = inheritTouchable;
  }

  bool get inheritTouchable => _inheritTouchable;

  //events
  XLSignal _submitEvent;

  XLSignal get submitEvent => _submitEvent;

  void set submitEvent(XLSignal submitEvent) {
    _submitEvent = submitEvent;
  }

  Function _submitCallback;

  Function get submitCallback => _submitCallback;

  void set submitCallback(Function submitCallback) {
    _submitCallback = submitCallback;
  }

  List _submitCallbackParams;

  List get submitCallbackParams => _submitCallbackParams;

  void set submitCallbackParams(List submitCallbackParams) {
    _submitCallbackParams = submitCallbackParams;
  }

  void submit() {
    if (submitCallback != null) {
      Function.apply(submitCallback, submitCallbackParams);
    }
    if (submitEvent != null) {
      submitEvent.dispatch();
    }
  }

  bool _enabled = false;

  void set enabled(bool enabled) {
    //if (_enabled != enabled) {
    if (enabled) {
      enable();
    } else {
      disable();
    }
    _enabled = enabled;
    //}
  }

  bool get enabled => _enabled;

  void enable() {
    _enabled = true;
  }

  void disable() {
    _enabled = false;
  }

  bool _inheritEnabled = true;

  void set inheritEnabled(bool inheritEnabled) {
    _inheritEnabled = inheritEnabled;
  }

  bool get inheritEnabled => _inheritEnabled;
}
