part of acanvas_commons;

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

    if (Ac.TOUCH) {
      addEventListener<InputEvent>(TouchEvent.TOUCH_END, upAction);
      addEventListener<InputEvent>(TouchEvent.TOUCH_BEGIN, downAction);
      addEventListener<InputEvent>(TouchEvent.TOUCH_ROLL_OVER, rollOverAction);
      addEventListener<InputEvent>(TouchEvent.TOUCH_ROLL_OUT, rollOutAction);
    } else {
      addEventListener<InputEvent>(MouseEvent.MOUSE_UP, upAction);
      addEventListener<InputEvent>(MouseEvent.MOUSE_DOWN, downAction);
      addEventListener<InputEvent>(MouseEvent.ROLL_OVER, rollOverAction);
      addEventListener<InputEvent>(MouseEvent.ROLL_OUT, rollOutAction);
    }

    enableAction();
  }

  void enableAction() {
    if (alpha == 0.6) alpha = 1;
    filters = [];
    rollOutAction();
  }

  @override
  void disable() {
    if (!_enabled) return;

    super.disable();

    if (Ac.TOUCH) {
      removeEventListener<InputEvent>(TouchEvent.TOUCH_END, upAction);
      removeEventListener<InputEvent>(TouchEvent.TOUCH_BEGIN, downAction);
      removeEventListener<InputEvent>(TouchEvent.TOUCH_ROLL_OVER, rollOverAction);
      removeEventListener<InputEvent>(TouchEvent.TOUCH_ROLL_OUT, rollOutAction);
    } else {
      removeEventListener<InputEvent>(MouseEvent.MOUSE_UP, upAction);
      removeEventListener<InputEvent>(MouseEvent.MOUSE_DOWN, downAction);
      removeEventListener<InputEvent>(MouseEvent.ROLL_OVER, rollOverAction);
      removeEventListener<InputEvent>(MouseEvent.ROLL_OUT, rollOutAction);
    }
    disableAction();
  }

  void disableAction() {
    if (alpha == 1.0) alpha = .6;
    filters = [new ColorMatrixFilter.grayscale()];

    rollOverAction();
  }

  void downAction([InputEvent event = null]) {
    //measure x

    if (event != null) {
      swipeXDownPos = event.stageX;
      swipeYDownPos = event.stageY;
    }

    children.where((c) => (c is MButton && (c as MButton).inheritDownAction)).forEach((child) {
      (child as MButton).downAction(event);
    });

    children.where((c) => c is IMdButtonComponent).forEach((child) {
      (child as IMdButtonComponent).downAction(event);
    });

    dispatchEvent(new InteractEvent(InteractEvent.DOWN_ACTION));
  }

  void upAction([InputEvent event = null, bool submit = true]) {
    children.where((c) => (c is MButton && (c as MButton).inheritUpAction)).forEach((child) {
      (child as MButton).upAction(event);
    });
    children.where((c) => c is IMdButtonComponent).forEach((child) {
      (child as IMdButtonComponent).upAction(event);
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
