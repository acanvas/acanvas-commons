part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
abstract class MSlider {
  Timer _materializeControl;

  bool _horizontalScrollBehavior = false;

  void set horizontalScrollBehavior(bool horizontalScrollBehavior) =>
      _horizontalScrollBehavior = horizontalScrollBehavior;

  bool get horizontalScrollBehavior => _horizontalScrollBehavior;

  bool _snapToPages = false;

  void set snapToPages(bool snapToPages) => _snapToPages = snapToPages;

  bool get snapToPages => _snapToPages;

  bool _continuous = false;

  void set continuous(bool continuous) {
    if (continuous != _continuous) {
      _continuous = continuous;
      _updateThumbPosition();
    }
  }

  bool get continuous => _continuous;

  _updateThumbPosition() {}

  bool _bounce = Rd.MOBILE ? true : false;

  void set bounce(bool bounce) => _bounce = bounce;

  bool get bounce => _bounce;

  num _mouseWheelSensitivity = 1.0;

  void set mouseWheelSensitivity(num mouseWheelSensitivity) => _mouseWheelSensitivity = mouseWheelSensitivity;

  num get mouseWheelSensitivity => _mouseWheelSensitivity;

  bool _mouseWheelEnabled = false;

  bool get mouseWheelEnabled {
    return _mouseWheelEnabled;
  }

  void set mouseWheelEnabled(bool value) {
    _mouseWheelEnabled = value;
    if (_mouseWheelEnabled) addEventListener(MouseEvent.MOUSE_WHEEL, _onMouseWheel, useCapture: false, priority: 0);
    else removeEventListener(MouseEvent.MOUSE_WHEEL, _onMouseWheel);
  }

  void _onMouseWheel(MouseEvent event) {
    if (event.deltaY < 0) {
      if (_value >= valueMax) return;
    }
    if (event.deltaY > 0) {
      if (_value == valueMin) return;
    }

    interactionStart();

    value = value - event.deltaY * mouseWheelSensitivity;
    interactionEnd();
    Rd.MATERIALIZE_REQUIRED = true;

    if (_materializeControl != null) _materializeControl.cancel();
    _materializeControl = new Timer(new Duration(milliseconds: 100), () => Rd.MATERIALIZE_REQUIRED = false);
  }

  void interactionStart();

  void interactionEnd();

  //----- SCROLL MOMENTUM (slowing down, speeding up)

  num _spanSize = 0;

  void set spanSize(num spanSize) => _spanSize = spanSize;

  num get spanSize => _spanSize;

  bool _momentumEnabled = false;

  void set momentumEnabled(bool momentumEnabled) => _momentumEnabled = momentumEnabled;

  bool get momentumEnabled => _momentumEnabled;

  num _momentum = 0.0;

  void set momentum(num momentum) => _momentum = momentum;

  num get momentum => _momentum;

  num _momentumDelta = 0;

  void set momentumDelta(num momentumDelta) => _momentumDelta = momentumDelta;

  num get momentumDelta => _momentumDelta;

  num _momentumFriction = 0.85;

  void set momentumFriction(num momentumFriction) => _momentumFriction = momentumFriction;

  num get momentumFriction => _momentumFriction;

  num _momentumClearThreshold = 1;

  void set momentumClearThreshold(num momentumClearThreshold) => _momentumClearThreshold = momentumClearThreshold;

  num get momentumClearThreshold => _momentumClearThreshold;

  num _value = 0;

  void set value(num newValue) {
    if (newValue < valueMin) newValue = valueMin;
    else if (newValue > valueMax) newValue = valueMax;
    if (!continuous) newValue = (newValue).round();

    if (newValue != _value) {
      _value = newValue;
      _updateThumbPosition();
      dispatchEvent(new SliderEvent(SliderEvent.VALUE_CHANGE, _value));
    }
  }

  num get value => _value;

  num _valueMin = 0;

  void set valueMin(num valueMin) {
    if (valueMin != _valueMin) {
      _valueMin = valueMin;
      if (value < valueMin) value = valueMin;
      _updateThumbPosition();
    }
  }

  num get valueMin => _valueMin;

  num _valueMax = 0;

  void set valueMax(num valueMax) {
    if (valueMax != _valueMax) {
      _valueMax = valueMax;
      if (value > valueMax) value = valueMax;
      _updateThumbPosition();
    }
  }

  num get valueMax => _valueMax;

  //--------- INTERNAL STATE VALUES

  num _pageCount = 1;

  void set pageCount(num pageCount) => _pageCount = pageCount;

  num get pageCount => _pageCount;

  num _mouseOffsetX = 0;

  void set mouseOffsetX(num mouseOffsetX) => _mouseOffsetX = mouseOffsetX;

  num get mouseOffsetX => _mouseOffsetX;

  num _mouseOffsetY = 0;

  void set mouseOffsetY(num mouseOffsetY) => _mouseOffsetY = mouseOffsetY;

  num get mouseOffsetY => _mouseOffsetY;

  num _mouseOffset = 0;

  void set mouseOffset(num mouseOffset) => _mouseOffset = mouseOffset;

  num get mouseOffset => _mouseOffset;

  bool _interactionH = false;

  void set interactionH(bool interactionH) => _interactionH = interactionH;

  bool get interactionH => _interactionH;

  bool _interactionV = false;

  void set interactionV(bool interactionV) => _interactionV = interactionV;

  bool get interactionV => _interactionV;

  bool _interaction = false;

  void set interaction(bool interaction) => _interaction = interaction;

  bool get interaction => _interaction;

  bool _changing = false;

  void set changing(bool changing) => _changing = changing;

  bool get changing => _changing;

  bool _touching = false;

  void set touching(bool touching) => _touching = touching;

  bool get touching => _touching;

  StreamSubscription<Event> addEventListener(String eventType, EventListener eventListener,
      {bool useCapture: false, int priority: 0});

  void removeEventListener(String eventType, EventListener eventListener, {bool useCapture: false});

  void dispatchEvent(Event event);
}
