part of stagexl_commons;
/**
 * @author Simon Schmid (contact(at)sschmid.com)
 */
class NumericStepper {
  num _min;

  num _max;

  num _step;

  bool _loop;

  num _curStep;

  NumericStepper(num min, num max, [num step = 1, bool loop = true]) {
    _min = min;
    _max = max;
    _step = step;
    _loop = loop;
    _curStep = min;
  }


  num get value {
    return _curStep;
  }


  num get step {
    return _step;
  }


  void set step(num step) {
    _step = step;
  }


  num jumpTo(num i) {
    return _update(i, false);
  }


  num jumpToFirst() {
    _curStep = _min;
    return _curStep;
  }


  num jumpToLast() {
    _curStep = _max;
    return _curStep;
  }


  num forward() {
    return _update(_curStep + _step, _loop);
  }


  num back() {
    return _update(_curStep - _step, _loop);
  }


  num _update(num i, bool loop) {
    if (i != _curStep) {
      if (i < _min) {
        if (loop) _curStep = _max;
        else _curStep = _min;
      } else if (i > _max) {
        if (loop) _curStep = _min;
        else _curStep = _max;
      } else {
        _curStep = i;
      }
    }
    return _curStep;
  }


  num get minimum {
    return _min;
  }


  void set minimum(num min) {
    _min = min;
  }


  num get maximum {
    return _max;
  }


  void set maximum(num max) {
    _max = max;
  }


  bool get loop {
    return _loop;
  }


  void set loop(bool loop) {
    _loop = loop;
  }
}
