part of rockdot_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class Scrollbar extends Slider with MPagedScroll {
  NumericStepper _pageStepper;
  Timer _timer;

  Scrollbar({ScrollDirection direction: ScrollDirection.VERTICAL}) : super() {
    this.direction = direction;
    _pageStepper = new NumericStepper(0, 0, 1, false);
  }

  void span(spanWidth, spanHeight, {bool refresh: true}) {
    valueMax = direction == ScrollDirection.HORIZONTAL ? spanWidth : spanHeight;
    super.span(spanWidth, spanHeight, refresh: refresh);
  }

  @override
  void enable() {
    super.enable();
    visible = true;
  }

  @override
  void disable() {
    visible = false;
    super.disable();
  }

  //---- START DRAGGING VIA THUMB OR BACKGROUND(as thumb moves to mousedown position)
  @override
  void interactionStart([bool preventMomentum = false, bool addMouseListeners = true]) {
    if (!_interaction) {
      killPageTween();
      super.interactionStart(preventMomentum, addMouseListeners);
    }
  }

  //---- STOP DRAGGING VIA THUMB OR BACKGROUND(as thumb moves to mousedown position)
  @override
  void interactionEnd() {
    if (_interaction) {
      Rd.MATERIALIZE_REQUIRED = false;
      _interaction = false;
      if (stage != null) {
        if (Rd.TOUCH) {
          stage.removeEventListener(TouchEvent.TOUCH_END, _onStageMouseUp, useCapture: false);
          stage.removeEventListener(TouchEvent.TOUCH_MOVE, _onStageMouseMove, useCapture: false);
        } else {
          stage.removeEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp, useCapture: false);
          stage.removeEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove, useCapture: false);
        }
      }

      dispatchEvent(new SliderEvent(SliderEvent.INTERACTION_END, value));

      if (momentumEnabled) {
        removeEventListener(Event.ENTER_FRAME, _calcMomentum);

        if (snapToPages) {
          if (!tweening) snapToCurrentPage();
        } else if (bounce) {
          if (!checkOuterFrame() && !tweening) notifyMomentumStart();
        } else notifyMomentumStart();
      } else {
        if (snapToPages) {
          if (!tweening) snapToCurrentPage();
        } else if (bounce) {
          if (!checkOuterFrame() && !tweening) notifyMomentumStart();
        } else if (!tweening) {
          notifyChangeEnd();
        }
      }
    }
  }

  void snapToCurrentPage() {
    if (momentum < 0) scrollToPage(currentPage - (_rawPagePos - currentPage < 0 ? 1 : 0), 0, true);
    else if (momentum > 0) scrollToPage(currentPage + (_rawPagePos - currentPage > 0 ? 1 : 0), 0, true);
    else scrollToPage(currentPage);
  }

  void pageUp() {
    if (snapToPages) {
      scrollToPage(_pageStepper.value - 1);
    } else {
      notifyChangeStart();
      num val = max(0, value - pageScrollDistance);
      if (pageScrollDuration == 0) {
        value = val;
        notifyChangeEnd();
      } else {
        tweening = true;
        Rd.JUGGLER.delayCall(() {
          this.value = val;
          _onTweenComplete();
        }, pageScrollDuration);

        _scrollTransition(val);
      }
    }
  }

  void pageDown() {
    if (snapToPages) {
      scrollToPage(_pageStepper.value + 1);
    } else {
      notifyChangeStart();
      num val = min(valueMax, value + pageScrollDistance);
      if (pageScrollDuration == 0) {
        value = val;
        notifyChangeEnd();
      } else {
        tweening = true;
        Rd.JUGGLER.delayCall(() {
          this.value = val;
          _onTweenComplete();
        }, pageScrollDuration);

        _scrollTransition(val);
      }
    }
  }

  void scrollToPage(int page, [num offset = 0, bool force = false]) {
    _pageStepper.jumpTo(page);
    if (page == _pageStepper.value || offset != 0 || force) {
      notifyChangeStart();
      num val = _pageStepper.value * pageScrollDistance + offset;
      if (pageScrollDuration == 0) {
        value = val;
        notifyChangeEnd();
      } else {
        tweening = true;
        Rd.JUGGLER.delayCall(() {
          this.value = val;
          _onTweenComplete();
        }, pageScrollDuration);

        _scrollTransition(val);
      }
    }
  }

  int get currentPage {
    return _pageStepper.jumpTo((value / pageScrollDistance).round());
  }

  num get _rawPagePos {
    return value / pageScrollDistance;
  }

  @override
  void _onThumbMouseDown(InputEvent event) {
    killPageTween();
    super._onThumbMouseDown(event);
  }

  void killPageTween() {
    if (pageScrollDuration != 0) {
      //value = 0;
      tweening = false;
    }
  }

  @override
  void _onBackgroundMouseDown(InputEvent event) {
    interactionStart(true, false);
    if (Rd.TOUCH) {
      stage.addEventListener(TouchEvent.TOUCH_END, _onStageMouseUp);
    } else {
      stage.addEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
    }
    _startPageScrollTimer();
  }

  @override
  void _onStageMouseUp(InputEvent event) {
    _stopPageScrollTimer();
    interactionEnd();
  }

  /**
   *
   * MOMENTUM
   *
   */
  @override
  void _applyMomentum(Event event) {
    momentum *= momentumFriction;
    if ((momentum).abs() < momentumClearThreshold) {
      // Stop momentum
      value += momentum;
      clearMomentum();
      if (value < valueMin) value = valueMin;
      else if (value > valueMax) value = valueMax;
      notifyMomentumEnd();
    } else {
      // Apply momentum
      value += momentum;
      if (!bounce) {
        if (value <= valueMin) {
          clearMomentum();
          value = valueMin;
          notifyMomentumEnd();
        } else if (value >= valueMax) {
          clearMomentum();
          value = valueMax;
          notifyMomentumEnd();
        }
      }
    }
  }

  bool checkOuterFrame() {
    if (value < valueMin) {
      scrollToPage(0);
      return true;
    } else if (value > valueMax) {
      scrollToPage((pageCount), 100, true);
      return true;
    }
    return false;
  }

  void set pageCount(num pages) {
    if (pages != pageCount) {
      _pageCount = max(pages, 1).toInt();
      _pageStepper.maximum = pageCount - 1;
      pageScrollDistance = valueMax / (pageCount < 2 ? 1 : pageCount - 1);
      _thumbSize = max(10, (spanSize / pageCount).round());
      horizontalScrollBehavior ? thumb.width = _thumbSize : thumb.height = _thumbSize;
//				render();
    }
  }

  @override
  void set value(num newValue) {
    if (newValue < valueMin) {
      newValue = bounce ? valueMin + (newValue - valueMin) * 0.5 : valueMin;
    } else if (newValue > valueMax) {
      newValue = bounce ? valueMax + (newValue - valueMax) * 0.5 : valueMax;
    }
    if (!_continuous && newValue != null) newValue = (newValue).round();

    if (newValue != value) {
      if (bounce) {
        _value = newValue;
      } else {
        num delta = value - newValue;

        if (delta < 0) {
          delta = value - max(delta, -500);
        } else {
          delta = value - min(delta, 500);
        }

        _value = delta;
      }

      refresh();
      dispatchEvent(new SliderEvent(SliderEvent.VALUE_CHANGE, value));
    }
  }

  @override
  void refresh() {
    int pos;
    int offset;
    int maxPos;
    int thumbSize;
    maxPos = (spanSize - _thumbSize).floor();
    //pos = ((value - valueMin) / ((valueMax - valueMin) == 0 ? 1 : (valueMax - valueMin)) * maxPos).round();
    //value = value == 0 ? value +1 : value;

    if (valueMax - valueMin == 0) {
      throw new StateError("bo");
    }

    pos = ((value - valueMin) / (valueMax - valueMin) * maxPos).round();
    //print("MAXPOS $maxPos THUMBSIZE $_thumbSize ORIPOS $pos");
    if (pos < 0) {
      offset = -pos;
      thumbSize = max(10, (spanSize / pageCount).round() - offset * 4);
      pos = 0;
    } else if (pos > maxPos /* && !bounce*/) {
      offset = pos - maxPos;
      thumbSize = max(10, (spanSize / pageCount).round() - offset * 4);
      pos = (spanSize - thumbSize).floor();
      //print("pos>maxPos $pos");
    } else {
      offset = 0;
      num t = (spanSize / pageCount).round() - offset * 4;
      thumbSize = max(10, t);
      //print("pos<maxPos $pos");
    }
    _thumbSize = thumbSize;
    horizontalScrollBehavior ? thumb.width = _thumbSize : thumb.height = _thumbSize;
    horizontalScrollBehavior ? thumb.x = pos : thumb.y = pos;
  }

  @override
  void set valueMax(num maxi) {
    super.valueMax = max(0, (maxi).round());
    pageScrollDistance = valueMax / (pageCount < 2 ? 1 : pageCount - 1);
  }

  //----- TIMER - used for page snapping

  void _startPageScrollTimer() {
    //_pageScroll();
    _runTimer(pageScrollIntervalFirst);
  }

  void _runTimer(int delay) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = new Timer.periodic(new Duration(milliseconds: delay), _onTimer);
  }

  void _onTimer(Timer t) {
    _runTimer(pageScrollInterval);
    _pageScroll();
  }

  void _pageScroll() {
    Rd.MATERIALIZE_REQUIRED = true;
    if (snapToPages) {
      int thumbPos =
          ((currentPage * pageScrollDistance - valueMin) / (valueMax - valueMin) * (spanSize - _thumbSize)).round();
      if (thumbPos > (horizontalScrollBehavior ? mouseX : mouseY)) pageUp();
      else if (thumbPos + _thumbSize < (horizontalScrollBehavior ? mouseX : mouseY)) pageDown();
    } else {
      if ((horizontalScrollBehavior ? thumb.x : thumb.y) > (horizontalScrollBehavior ? mouseX : mouseY)) pageUp();
      else if ((horizontalScrollBehavior ? thumb.x : thumb.y) + _thumbSize <
          (horizontalScrollBehavior ? mouseX : mouseY)) pageDown();
    }
  }

  void _stopPageScrollTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void _scrollTransition(num val) {
    Translation t = new Translation(value, val, pageScrollDuration, Transition.easeOutExponential)
      ..onUpdate = _onPageScrollUpdate
      ..onComplete = _onTweenComplete;
    Rd.JUGGLER.add(t);
  }

  void _onPageScrollUpdate(num val) {
    value = val;
  }

  void _onTweenComplete() {
    tweening = false;
    notifyChangeEnd();
  }
}
