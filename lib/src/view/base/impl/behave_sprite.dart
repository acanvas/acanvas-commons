part of rockdot_commons;

class BehaveSprite extends BoxSprite with MBehave {
  BehaveSprite() : super() {
    submitCallbackParams = [this];
  }

  @override
  void enable() {
    children.where((c) => (c is MBehave && (c as MBehave).inheritEnabled)).forEach((child) {
      (child as MBehave).enable();
    });
  }

  @override
  void disable() {
    super.enable();
    children.where((c) => c is MBehave && (c as MBehave).inheritEnabled).forEach((child) {
      (child as MBehave).disable();
    });
    super.disable();
  }

  @override
  void dispose({bool removeSelf: true}) {
    disable();
    super.dispose(removeSelf: removeSelf);
  }

  @override
  void addChild(DisplayObject child) {
    super.addChild(child);
    if (child is MBehave && (child as MBehave).inheritEnabled) {
      if (this.enabled) {
        (child as MBehave).enable();
      } else {
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
