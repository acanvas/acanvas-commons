part of stagexl_commons;

/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
enum ScrollDirection {HORIZONTAL, VERTICAL}

abstract class MPagedScroll {

  ScrollDirection _direction;
  void set direction (ScrollDirection direction) => _direction = direction;
  ScrollDirection get direction => _direction;

  bool _tweening = false;
  void set tweening(bool tweening) => _tweening = tweening;
  bool get tweening => _tweening;
  
  int _pageScrollInterval = 300;
  void set pageScrollInterval(int pageScrollInterval) => _pageScrollInterval = pageScrollInterval;
  int get pageScrollInterval => _pageScrollInterval;
  
  int _pageScrollIntervalFirst = 50;
  void set pageScrollIntervalFirst(int pageScrollIntervalFirst) => _pageScrollIntervalFirst = pageScrollIntervalFirst;
  int get pageScrollIntervalFirst => _pageScrollIntervalFirst;
  
  num _pageScrollDuration = 0.7;
  void set pageScrollDuration(num pageScrollDuration) => _pageScrollDuration = pageScrollDuration;
  num get pageScrollDuration => _pageScrollDuration;

  num _pageScrollDistance = 1.0;
  void set pageScrollDistance(num pageScrollDistance) => _pageScrollDistance = pageScrollDistance;
  num get pageScrollDistance => _pageScrollDistance;

}