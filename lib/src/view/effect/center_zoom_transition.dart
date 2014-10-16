 part of stagexl_commons;



	 class CenterZoomTransition extends BasicEffect {
	 CenterZoomTransition() : super() {
			_sprite = new Sprite();
			_useSprite = true;
		}
		
		@override 
		  void runInEffect(ISpriteComponent target,num duration,Function callback) {
			
		  Bitmap bmpspr = _registerBitmapSprite(target);
		  num oriX = bmpspr.x + (bmpspr.width - bmpspr.width * .8) / 3;
		  bmpspr.alpha = 0;
		  bmpspr.scaleX = bmpspr.scaleY = .8;
		  bmpspr.x = bmpspr.x + (bmpspr.width - bmpspr.width * .8) / 3;
		  bmpspr.y = bmpspr.y + 30;
		  
		  bmpspr.stage.juggler.tween(bmpspr, duration, TransitionFunction.easeOutQuartic)
		      ..animate.x.to( oriX )
          ..animate.y.to( bmpspr.y - 30 )
          ..animate.scaleX.to(1)
          ..animate.scaleY.to(1)
          ..animate.alpha.to(1)
		    ..onComplete = () => onComplete(bmpspr, target, callback);
		}
		
		@override 
		  void runOutEffect(ISpriteComponent target,num duration,Function callback) {
			Bitmap bmpspr = _registerBitmapSprite(target);
			bmpspr.stage.juggler.tween(bmpspr, duration, TransitionFunction.easeOutQuartic)
  	    ..animate.x.to( bmpspr.x + (bmpspr.width - bmpspr.width * .8) / 3 )
  	    ..animate.y.to( bmpspr.y + 30 )
  	    ..animate.scaleX.to(.8)
  	    ..animate.scaleY.to(.8)
  	    ..animate.alpha.to(0)
		    ..onComplete = () => onComplete(bmpspr, target, callback);
		}


	}

