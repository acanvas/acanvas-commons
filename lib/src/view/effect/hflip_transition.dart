part of stagexl_commons;

class HFlipTransition extends BasicEffect {
  HFlipTransition() {
    _applyRecursively = false;
  }

  @override
  void runInEffect(BoxSprite target, num duration, Function callback) {
    target.rotationY = 179;
    target.alpha = 1;
    TweenLite.to(target, duration, {rotationY: 0, ease: Quart.easeOut, onComplete: callback.call});
  }

  @override
  void runOutEffect(BoxSprite target, num duration, Function callback) {
    target.alpha = 1;
    TweenLite.to(target, duration, {rotationY: -179, ease: Quart.easeIn, onComplete: callback.call});
  }
}
