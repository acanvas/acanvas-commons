part of stagexl_commons;

class XLSignal extends Event{
  var _callback;
  var _data;
  final XLEventBus eventBus = new XLEventBus();
  
  XLSignal(String type, [this._data = null, this._callback = null]) : super(type);
  
  void dispatch(){
    eventBus.dispatchEvent(new XLSignal(type, _data, _callback));
  }
  void listen(){
    eventBus.addEventListener(type , _callback);
  }
  void unlisten(){
    eventBus.removeEventListener(type , _callback);
  }

  get data => _data;
  get completeCallBack => _callback;
 }