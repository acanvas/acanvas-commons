part of stagexl_commons;

class HLeftSwipeTransition extends BasicEffect {
  HLeftSwipeTransition() : super() {
    _applyRecursively = false;
  }

  @override
  void runInEffect(BoxSprite t, num duration, Function callback) {
    BoxSprite target = t as BoxSprite;
    num iTargetXOriginal = target.x;
    //if mask
    target.parent.mask = new Mask.rectangle(target.x, target.y, target.spanWidth, target.spanHeight);
    target.x = target.stage.stageWidth;
    target.alpha = 1;

    ContextTool.JUGGLER.addTween(target, duration, Transition.easeOutQuartic)
      ..animate.x.to(iTargetXOriginal)
      ..onComplete = () {
        callback.call();
        target.parent.mask = null;
      };
  }

  @override
  void runOutEffect(BoxSprite t, num duration, Function callback) {
    BoxSprite target = t as BoxSprite;
    target.parent.mask = new Mask.rectangle(target.x, target.y, target.spanWidth, target.spanHeight);
    ContextTool.JUGGLER.addTween(target, duration, Transition.easeOutQuartic)
      ..animate.x.to(-target.width)
      ..onComplete = () {
        callback.call();
        target.parent.mask = null;
      };
  }
}
