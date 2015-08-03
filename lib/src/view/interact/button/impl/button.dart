part of stagexl_commons;

class Button extends BehaveSprite with MButton {

  Button() : super() {
    useHandCursor = true;
    mouseChildren = false;
    enabled = true;
    autoRefresh = true;
    autoSpan = true;
  }

  @override
  void refresh() {
    //adjust inherited span size to actual size
    span(width, height, refresh: false);
    if (this is MFlow) {
      print("${this}: ${spanWidth}x${spanHeight}  ${width}x${height}");
      children.forEach((c) {
        print("--${c}: ${c.width}x${c.height} x:${c.x} y:${c.y}");
      });
    }
  }

  @override
  void enable() {
    if (_enabled)return;

    super.enable();

    if (ContextTool.TOUCH) {
      addEventListener(TouchEvent.TOUCH_END, upAction);
      addEventListener(TouchEvent.TOUCH_BEGIN, downAction);
      addEventListener(TouchEvent.TOUCH_ROLL_OVER, rollOverAction);
      addEventListener(TouchEvent.TOUCH_ROLL_OUT, rollOutAction);
    }
    else {
      addEventListener(MouseEvent.MOUSE_UP, upAction);
      addEventListener(MouseEvent.MOUSE_DOWN, downAction);
      addEventListener(MouseEvent.ROLL_OVER, rollOverAction);
      addEventListener(MouseEvent.ROLL_OUT, rollOutAction);
    }

    rollOutAction();
  }

  @override
  void disable() {
    if (!_enabled)return;

    super.disable();

    if (ContextTool.TOUCH) {
      removeEventListener(TouchEvent.TOUCH_END, upAction);
      removeEventListener(TouchEvent.TOUCH_BEGIN, downAction);
      removeEventListener(TouchEvent.TOUCH_ROLL_OVER, rollOverAction);
      removeEventListener(TouchEvent.TOUCH_ROLL_OUT, rollOutAction);
    }
    else {
      removeEventListener(MouseEvent.MOUSE_UP, upAction);
      removeEventListener(MouseEvent.MOUSE_DOWN, downAction);
      removeEventListener(MouseEvent.ROLL_OVER, rollOverAction);
      removeEventListener(MouseEvent.ROLL_OUT, rollOutAction);
    }
    rollOverAction();
  }

  void downAction([InputEvent event = null]) {
    children.where((c) => (c is MButton && c.inheritDownAction) || c is IPaperButtonComponent).forEach((child) {
      child.downAction(event);
    });
  }

  void upAction([InputEvent event = null, bool submit = true]) {
    children.where((c) => (c is MButton && c.inheritUpAction) || c is IPaperButtonComponent).forEach((child) {
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
