 part of stagexl_commons;

	/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */
   @retain
	 class HRightSwipeTransition extends BasicEffect {
	 HRightSwipeTransition() : super() {
			_applyRecursively = false;
		}
		
		@override 
		  void runInEffect(ISpriteComponent t,num duration,Function callback) {
			SpriteComponent target = t as SpriteComponent;
			target.parent.mask = new Mask.rectangle(target.x, target.y, target.widthAsSet, target.heightAsSet);
			num iTargetXOriginal = target.x;
			target.x = -target.stage.stageWidth;
			target.alpha = 1;
			
      target.stage.juggler.tween(target, duration, TransitionFunction.easeOutQuartic)
        ..animate.x.to(iTargetXOriginal)
        ..onComplete = () {
        callback.call();
        target.parent.mask = null;
      };
		}
		@override 
		  void runOutEffect(ISpriteComponent t,num duration,Function callback) {
				SpriteComponent target = t as SpriteComponent;
				target.parent.mask = new Mask.rectangle(target.x, target.y, target.widthAsSet, target.heightAsSet);
		    target.stage.juggler.tween(target, duration, TransitionFunction.easeOutQuartic)
          ..animate.x.to(target.stage.stageWidth)
          ..onComplete = () {
          callback.call();
          target.parent.mask = null;
        };
		}
	}

