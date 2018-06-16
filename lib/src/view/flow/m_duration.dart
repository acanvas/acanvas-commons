part of acanvas_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */

abstract class MDuration {
  num _duration = 0;

  num get duration {
    return _duration;
  }

  void set duration(num value) {
    _duration = value;
  }
}
