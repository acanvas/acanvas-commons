part of acanvas_commons;

/**
 * @author Nils Doehring (nilsdoehring(gmail as at).com)
 */

class HRightSwipeTransition extends BasicEffect {
  HRightSwipeTransition() : super() {
    _applyRecursively = false;
  }

  @override
  void runInEffect(BoxSprite t, num duration, Function callback) {
    BoxSprite target = t;
    target.parent.mask = new Mask.rectangle(target.x, target.y, target.spanWidth, target.spanHeight);
    num iTargetXOriginal = target.x;
    target.x = -target.stage.stageWidth;
    target.alpha = 1;

    Ac.JUGGLER.addTween(target, duration, Transition.easeOutQuartic)
      ..animate.x.to(iTargetXOriginal)
      ..onComplete = () {
        callback.call();
        target.parent.mask = null;
      };
  }

  @override
  void runOutEffect(BoxSprite t, num duration, Function callback) {
    BoxSprite target = t;
    target.parent.mask = new Mask.rectangle(target.x, target.y, target.spanWidth, target.spanHeight);
    Ac.JUGGLER.addTween(target, duration, Transition.easeOutQuartic)
      ..animate.x.to(target.x + target.spanWidth)
      ..onComplete = () {
        callback.call();
        target.parent.mask = null;
      };
  }
}
