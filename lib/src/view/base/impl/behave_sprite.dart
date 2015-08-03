part of stagexl_commons;

class BehaveSprite extends BoxSprite with MBehave {

  BehaveSprite() : super() {
    submitCallbackParams = [this];
  }


  @override
  void enable() {
    super.enable();
    children.where((c) => c is MBehave && c.inheritEnabled).forEach((child) {
      child.enable();
    });
  }

  @override
  void disable() {
    children.where((c) => c is MBehave && c.inheritEnabled).forEach((child) {
      child.disable();
    });
    super.disable();
  }

  @override
  void dispose() {
    disable();
    super.dispose();
  }

  @override
  void addChild(DisplayObject child) {
    super.addChild(child);
    if (child is MBehave && (child as MBehave).inheritEnabled) {
      if (this.enabled) {
        (child as MBehave).enable();
      }
      else {
        (child as MBehave).disable();
      }
    }
    if (child is MBehave && (child as MBehave).inheritTouchable) {
      (child as MBehave).inheritTouchable = this.touchable;
    }
  }

  @override
  void removeChild(DisplayObject child) {
    super.removeChild(child);
    if (child is MBehave) {
      (child as MBehave).disable();
    }
  }
}
