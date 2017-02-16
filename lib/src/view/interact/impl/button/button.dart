part of rockdot_commons;

class Button extends BehaveSprite with MButton {
  num swipeXDownPos;
  num swipeYDownPos;

  Button() : super() {
    useHandCursor = true;
    mouseChildren = false;
    enabled = true;
    autoRefresh = true;
    autoSpan = true;
  }

  @override
  void enable() {
    if (_enabled) return;
    super.enable();

    if (Rd.TOUCH) {
      addEventListener(TouchEvent.TOUCH_END, upAction);
      addEventListener(TouchEvent.TOUCH_BEGIN, downAction);
      addEventListener(TouchEvent.TOUCH_ROLL_OVER, rollOverAction);
      addEventListener(TouchEvent.TOUCH_ROLL_OUT, rollOutAction);
    } else {
      addEventListener(MouseEvent.MOUSE_UP, upAction);
      addEventListener(MouseEvent.MOUSE_DOWN, downAction);
      addEventListener(MouseEvent.ROLL_OVER, rollOverAction);
      addEventListener(MouseEvent.ROLL_OUT, rollOutAction);
    }

    enableAction();
  }

  void enableAction() {
    if(alpha == 0.6) alpha = 1;
    filters = [];
    rollOutAction();
  }

  @override
  void disable() {
    if (!_enabled) return;

    super.disable();

    if (Rd.TOUCH) {
      removeEventListener(TouchEvent.TOUCH_END, upAction);
      removeEventListener(TouchEvent.TOUCH_BEGIN, downAction);
      removeEventListener(TouchEvent.TOUCH_ROLL_OVER, rollOverAction);
      removeEventListener(TouchEvent.TOUCH_ROLL_OUT, rollOutAction);
    } else {
      removeEventListener(MouseEvent.MOUSE_UP, upAction);
      removeEventListener(MouseEvent.MOUSE_DOWN, downAction);
      removeEventListener(MouseEvent.ROLL_OVER, rollOverAction);
      removeEventListener(MouseEvent.ROLL_OUT, rollOutAction);
    }
    disableAction();
  }

  void disableAction() {
    if(alpha == 1.0) alpha = .6;
    filters = [
      new ColorMatrixFilter.grayscale()
    ];

    rollOverAction();
  }

  void downAction([InputEvent event = null]) {
    //measure x

    if (event != null) {
      swipeXDownPos = event.stageX;
      swipeYDownPos = event.stageY;
    }

    children.where((c) => (c is MButton && (c as MButton).inheritDownAction) || c is IMdButtonComponent).forEach((child) {
      (child as MButton).downAction(event);
    });

    dispatchEvent(new InteractEvent(InteractEvent.DOWN_ACTION));
  }

  void upAction([InputEvent event = null, bool submit = true]) {
    children.where((c) => (c is MButton && (c as MButton).inheritUpAction) || c is IMdButtonComponent).forEach((child) {
      (child as MButton).upAction(event);
    });
    if (submit) {
      this.submit();
    }
    dispatchEvent(new InteractEvent(InteractEvent.UP_ACTION));
  }

  void rollOverAction([InputEvent event = null]) {
    dispatchEvent(new InteractEvent(InteractEvent.OVER_ACTION));
  }

  void rollOutAction([InputEvent event = null]) {
    dispatchEvent(new InteractEvent(InteractEvent.OUT_ACTION));
  }
}
