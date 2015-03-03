 part of stagexl_commons;



   class CenterZoomTransition extends BasicEffect {
   CenterZoomTransition() : super() {
    }
    
    @override 
      void runInEffect(ISpriteComponent target,num duration,Function callback) {

      num oriX = target.x;
      target.pivotX = target.widthAsSet / 2;
      target.pivotY = target.height / 2;
      target.alpha = 0;
      target.scaleX = target.scaleY = .8;
      
      target.x = target.stage.stageWidth / 2;
      target.y = target.stage.stageHeight / 2;
      
      target.stage.juggler.tween(target, duration, TransitionFunction.easeOutQuartic)
        //  ..animate.x.to( oriX )
        //  ..animate.y.to( target.y - 30 )
          ..animate.scaleX.to(1)
          ..animate.scaleY.to(1)
          ..animate.alpha.to(1)
        ..onComplete = () => onComplete(null, target, callback);
    }
    
    @override 
      void runOutEffect(ISpriteComponent target,num duration,Function callback) {
      target.stage.juggler.tween(target, duration, TransitionFunction.easeOutQuartic)
       // ..animate.x.to( target.x + (target.width - target.width * .8) / 3 )
       // ..animate.y.to( target.y + 30 )
        ..animate.scaleX.to(.8)
        ..animate.scaleY.to(.8)
        ..animate.alpha.to(0)
        ..onComplete = () => onComplete(null, target, callback);
    }


  }

