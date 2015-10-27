part of stagexl_commons;

class XLSignal extends Event {
  final XLEventBus eventBus = new XLEventBus();

  dynamic _data;

  dynamic get data => _data;

  set data(dynamic data) {
    _data = data;
  }

  var _callback;

  get completeCallBack => _callback;

  XLSignal(String type, [this._data = null, this._callback = null]) : super(type);

  void dispatch() {
    eventBus.dispatchEvent(new XLSignal(type, _data, _callback));
  }

  void listen() {
    eventBus.addEventListener(type, _callback);
  }

  void unlisten() {
    eventBus.removeEventListener(type, _callback);
  }
}
