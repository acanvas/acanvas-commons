part of stagexl_commons;

class LifecycleEvent extends Event {

  static const String INIT_START = "LifecycleEvent.INIT_START";
  static const String INIT_COMPLETE = "LifecycleEvent.DID_INIT";

  static const String LOAD_COMPLETE = "LifecycleEvent.DID_LOAD";
  static const String LOAD_ERROR = "LifecycleEvent.LOAD_ERROR";

  static const String APPEAR_COMPLETE = "LifecycleEvent.DID_APPEAR";
  static const String DISAPPEAR_COMPLETE = "LifecycleEvent.DID_DISAPPEAR";

  static const String DID_ACTIVATE = "LifecycleEvent.DID_ACTIVATE";
  static const String DID_DEACTIVATE = "LifecycleEvent.DID_DEACTIVATE";

  var _data;

  LifecycleEvent(String type, [this._data = null, bool bubbles = false]) : super(type, bubbles);
  
  Event clone() => new LifecycleEvent(type, _data, bubbles);
}
