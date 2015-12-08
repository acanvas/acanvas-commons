part of stagexl_commons;

class CenterZoomTransition extends BasicEffect {
  CenterZoomTransition() : super() {}

  @override
  void runInEffect(BoxSprite target, num duration, Function callback) {
    target.pivotX = target.spanWidth / 2;
    target.pivotY = target.height / 2;
    target.alpha = 0;
    target.scaleX = target.scaleY = .8;

    target.x = target.stage.stageWidth / 2;
    target.y = target.stage.stageHeight / 2;

    Rd.JUGGLER.addTween(target, duration, Transition.easeOutQuartic)
      ..animate.scaleX.to(1)
      ..animate.scaleY.to(1)
      ..animate.alpha.to(1)
      ..onComplete = () => onComplete(null, target, callback);
  }

  @override
  void runOutEffect(BoxSprite target, num duration, Function callback) {
    Rd.JUGGLER.addTween(target, duration, Transition.easeOutQuartic)
      ..animate.scaleX.to(.8)
      ..animate.scaleY.to(.8)
      ..animate.alpha.to(0)
      ..onComplete = () => onComplete(null, target, callback);
  }
}
