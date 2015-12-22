part of rockdot_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 *
 * You can change the slider value by
 *    - clicking or tapping the background sprite
 *    - clicking or tapping the thumb sprite
 *    - hold-dragging thumb (or background, as thumb will move to hold position immediately)
 */

class Slider extends BehaveSprite with MSlider {
  Sprite _background;
  Sprite _thumb;
  num _thumbSize = 0;

  Slider() : super() {
    mouseWheelEnabled = Rd.MOBILE ? false : true;
    background = RdGraphics.rectangle(0, 0, 1, 1, color: 0x00000000);
    thumb = RdGraphics.rectangle(0, 0, 1, 1, color: 0x00FFFFFF);
  }

  //-------- SCROLL THUMB

  Sprite get background {
    return _background;
  }

  void set background(Sprite background) {
    if (background != _background) {
      _background = background;
      if (background.parent == null) {
        addChild(background);
      }
    }
  }

  Sprite get thumb {
    return _thumb;
  }

  void set thumb(Sprite thumb) {
    if (thumb != _thumb) {
      _thumb = thumb;
      _thumbSize = horizontalScrollBehavior ? _thumb.width : _thumb.height;
      if (thumb.parent == null) {
        addChild(thumb);
      }
      _updateThumbPosition();
    }
  }

  //----- refresh everything

  @override
  void span(spanWidth, spanHeight, {bool refresh: true}) {
    Assert.notNull(background, "You need to set a background Sprite.");
    Assert.notNull(thumb, "You need to set a thumb Sprite.");
    spanSize = horizontalScrollBehavior ? spanWidth : spanHeight;
    super.span(spanWidth, spanHeight, refresh: refresh);
    _updateThumbPosition();
  }

  //----- add/remove listeners for thumb and background

  @override
  void enable() {
    if (_enabled) return;

    Assert.notNull(background, "You need to set a background Sprite.");
    Assert.notNull(thumb, "You need to set a thumb Sprite.");
    super.enable();
    Rd.JUGGLER.removeTweens(this);

    if (Rd.TOUCH) {
      background.addEventListener(TouchEvent.TOUCH_BEGIN, _onBackgroundMouseDown, useCapture: false, priority: 0);
      thumb.addEventListener(TouchEvent.TOUCH_BEGIN, _onThumbMouseDown, useCapture: false, priority: 0);
    } else {
      background.addEventListener(MouseEvent.MOUSE_DOWN, _onBackgroundMouseDown, useCapture: false, priority: 0);
      thumb.addEventListener(MouseEvent.MOUSE_DOWN, _onThumbMouseDown, useCapture: false, priority: 0);
    }
  }

  @override
  void disable() {
    if (!_enabled) return;

    Rd.JUGGLER.removeTweens(this);

    if (Rd.TOUCH) {
      background.removeEventListener(TouchEvent.TOUCH_BEGIN, _onBackgroundMouseDown);
      thumb.removeEventListener(TouchEvent.TOUCH_BEGIN, _onThumbMouseDown);
    } else {
      background.removeEventListener(MouseEvent.MOUSE_DOWN, _onBackgroundMouseDown);
      thumb.removeEventListener(MouseEvent.MOUSE_DOWN, _onThumbMouseDown);
    }
    super.disable();
  }

  void _onBackgroundMouseDown(InputEvent event) {
    num posX = mouseX - _thumbSize * 0.5 - background.x;
    num posY = mouseY - _thumbSize * 0.5 - background.y;
    if (horizontalScrollBehavior) {
      value = _convertPositionToValue(posX);
      mouseOffset = event.stageX - posX;
    } else {
      value = _convertPositionToValue(posY);
      mouseOffset = event.stageY - posY;
    }
    interactionStart(true);
  }

  void _onThumbMouseDown(InputEvent event) {
    mouseOffset = horizontalScrollBehavior ? event.stageX - thumb.x : event.stageY - thumb.y; // - _thumbSize * 0.5;
    interactionStart();
  }

  //---- START DRAGGING VIA THUMB OR BACKGROUND(as thumb moves to mousedown position)

  void interactionStart([bool preventMomentum = false, bool addMouseListeners = true]) {
    if (!interaction) {
      Rd.MATERIALIZE_REQUIRED = true;
      interaction = true;

      clearMomentum();

      if (addMouseListeners == true) {
        if (Rd.TOUCH) {
          stage.addEventListener(TouchEvent.TOUCH_MOVE, _onStageMouseMove);
          stage.addEventListener(TouchEvent.TOUCH_END, _onStageMouseUp);
        } else {
          stage.addEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);
          stage.addEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
        }
      }

      if (momentumEnabled && !preventMomentum) {
        addEventListener(Event.ENTER_FRAME, _calcMomentum);
      }

      dispatchEvent(new SliderEvent(SliderEvent.INTERACTION_START, value));
      notifyChangeStart();
    }
  }

  //---- STOP DRAGGING VIA THUMB OR BACKGROUND(as thumb moves to mousedown position)

  void interactionEnd() {
    if (interaction) {
      Rd.MATERIALIZE_REQUIRED = false;
      interaction = false;
      if (Rd.TOUCH) {
        stage.removeEventListener(TouchEvent.TOUCH_MOVE, _onStageMouseMove);
        stage.removeEventListener(TouchEvent.TOUCH_END, _onStageMouseUp);
      } else {
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, _onStageMouseMove);
        stage.removeEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
      }

      dispatchEvent(new SliderEvent(SliderEvent.INTERACTION_END, value));

      if (momentumEnabled) {
        removeEventListener(Event.ENTER_FRAME, _calcMomentum);
        notifyMomentumStart();
      } else {
        notifyChangeEnd();
      }
    }
  }

  //----- SET VALUE according to MousePosition and initial Offset (on mousedown)
  void _onStageMouseMove(InputEvent event) {
    num mousePos = (horizontalScrollBehavior ? event.stageX : event.stageY); // - _thumbSize * 0.5;
    value = _convertPositionToValue(mousePos - mouseOffset);
    // event.updateAfterEvent();
  }

  //----- FINISHED DRAGGING
  void _onStageMouseUp(InputEvent event) {
    interactionEnd();
  }

  //----- NOTIFIERS FOR EXTERNAL BEHAVIOUR

  void notifyMomentumStart() {
    if (momentum != 0) {
      dispatchEvent(new SliderEvent(SliderEvent.MOMENTUM_START, value));
      addEventListener(Event.ENTER_FRAME, _applyMomentum);
    } else {
      notifyChangeEnd();
    }
  }

  void notifyMomentumEnd() {
    dispatchEvent(new SliderEvent(SliderEvent.MOMENTUM_END, value));
    notifyChangeEnd();
  }

  void notifyChangeStart() {
    if (!_changing) {
      Rd.MATERIALIZE_REQUIRED = true;
      _changing = true;
      dispatchEvent(new SliderEvent(SliderEvent.CHANGE_START, value));
    }
  }

  void notifyChangeEnd() {
    if (_changing) {
      Rd.MATERIALIZE_REQUIRED = false;
      _changing = false;
      dispatchEvent(new SliderEvent(SliderEvent.CHANGE_END, value));
    }
  }

  //----- INTERNAL HELPERS

  num _convertPositionToValue(num position) {
    num calc = valueMin + (valueMax - valueMin) * (position / (spanSize - _thumbSize));
    return calc;
  }

  void _updateThumbPosition() {
    num bgp = 0;
    if (background != null) {
      bgp = (horizontalScrollBehavior ? background.x : background.y);
    }
    if (thumb != null) {
      num pos = 0;
      if (valueMax != 0) {
        pos = ((value - valueMin) * ((spanSize - _thumbSize) / valueMax) + bgp).round();
      }
      horizontalScrollBehavior ? thumb.x = pos : thumb.y = pos;
    }
  }

  //----- MOMENTUM

  void _calcMomentum(Event event) {
    momentum = value - momentumDelta;
    momentumDelta = value;
  }

  void _applyMomentum(Event event) {
    momentum *= momentumFriction;
    if ((momentum).abs() < momentumClearThreshold) {
      value += momentum;
      clearMomentum();
      notifyMomentumEnd();
    } else {
      value += momentum;
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

  void clearMomentum() {
    if (momentumEnabled) {
      removeEventListener(Event.ENTER_FRAME, _calcMomentum);
      removeEventListener(Event.ENTER_FRAME, _applyMomentum);
      momentum = momentumDelta = 0;
    }
  }
}
