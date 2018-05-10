part of rockdot_commons;

class RdSignal extends Event {
  final RdEventBus eventBus = new RdEventBus();

  dynamic _data;

  dynamic get data => _data;

  set data(dynamic data) {
    _data = data;
  }

  Function _callback;

  Function get completeCallBack => _callback;

  RdSignal(String type, [this._data = null, this._callback = null]) : super(type);

  void dispatch() {
    eventBus.dispatchEvent(new RdSignal(type, _data, _callback));
  }

  void listen<T extends Event>() {
    eventBus.addEventListener<T>(type, (T e) => _callback(e));
  }

  void unlisten<T extends Event>() {
    eventBus.removeEventListener<T>(type, (T e) => _callback(e));
  }
}
