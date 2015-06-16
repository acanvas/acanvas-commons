part of stagexl_commons;

class HLeftSwipeTransition extends BasicEffect {
 
  HLeftSwipeTransition() : super() {
    _applyRecursively = false;
  }

  @override
  void runInEffect(ISpriteComponent t, num duration, Function callback) {
    SpriteComponent target = t as SpriteComponent;
    num iTargetXOriginal = target.x;
    //if mask
    target.parent.mask = new Mask.rectangle(target.x, target.y, target.widthAsSet, target.heightAsSet);
    target.x = target.stage.stageWidth;
    target.alpha = 1;

    target.stage.juggler.addTween(target, duration, Transition.easeOutQuartic)
        ..animate.x.to(iTargetXOriginal)
        ..onComplete = () {
          callback.call();
          target.parent.mask = null;
        };
  }
  @override
  void runOutEffect(ISpriteComponent t, num duration, Function callback) {
    SpriteComponent target = t as SpriteComponent;
    target.parent.mask = new Mask.rectangle(target.x, target.y, target.widthAsSet, target.heightAsSet);
    target.stage.juggler.addTween(target, duration, Transition.easeOutQuartic)
        ..animate.x.to(-target.width)
        ..onComplete = () {
          callback.call();
          target.parent.mask = null;
        };
  }

}
