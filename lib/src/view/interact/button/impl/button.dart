part of stagexl_commons;

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

    if (RdEnvironment.TOUCH) {
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
    rollOutAction();
  }

  @override
  void disable() {
    if (!_enabled) return;

    super.disable();

    if (RdEnvironment.TOUCH) {
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
    rollOverAction();
  }

  void downAction([InputEvent event = null]) {
    //measure x

    if (event != null) {
      swipeXDownPos = event.stageX;
      swipeYDownPos = event.stageY;
    }

    children.where((c) => (c is MButton && c.inheritDownAction) || c is IMdButtonComponent).forEach((child) {
      child.downAction(event);
    });
  }

  void upAction([InputEvent event = null, bool submit = true]) {
    children.where((c) => (c is MButton && c.inheritUpAction) || c is IMdButtonComponent).forEach((child) {
      child.upAction(event);
    });
    if (submit) {
      this.submit();
    }
  }

  void rollOverAction([InputEvent event = null]) {
    // Override this method
  }

  void rollOutAction([InputEvent event = null]) {
    // Override this method
  }
}
