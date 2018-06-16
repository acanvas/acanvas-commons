part of acanvas_commons;

class NumericStepper {
  int _min;

  int _max;

  int _step;

  bool _loop;

  int _curStep;

  NumericStepper(int min, int max, [int step = 1, bool loop = true]) {
    _min = min;
    _max = max;
    _step = step;
    _loop = loop;
    _curStep = min;
  }

  int get value {
    return _curStep;
  }

  int get step {
    return _step;
  }

  void set step(int step) {
    _step = step;
  }

  int jumpTo(int i) {
    return _update(i, false);
  }

  int jumpToFirst() {
    _curStep = _min;
    return _curStep;
  }

  int jumpToLast() {
    _curStep = _max;
    return _curStep;
  }

  int forward() {
    return _update(_curStep + _step, _loop);
  }

  int back() {
    return _update(_curStep - _step, _loop);
  }

  int _update(int i, bool loop) {
    if (i != _curStep) {
      if (i < _min) {
        if (loop)
          _curStep = _max;
        else
          _curStep = _min;
      } else if (i > _max) {
        if (loop)
          _curStep = _min;
        else
          _curStep = _max;
      } else {
        _curStep = i;
      }
    }
    return _curStep;
  }

  int get minimum {
    return _min;
  }

  void set minimum(int min) {
    _min = min;
  }

  int get maximum {
    return _max;
  }

  void set maximum(int max) {
    _max = max;
  }

  bool get loop {
    return _loop;
  }

  void set loop(bool loop) {
    _loop = loop;
  }
}
