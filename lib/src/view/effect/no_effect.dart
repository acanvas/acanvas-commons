part of stagexl_commons;

	 class NoEffect extends BasicEffect {
	 NoEffect():super() {
			
			_applyRecursively = false;
		}
		
		@override void runInEffect(BoxSprite target,double duration,Function callback)
		 {
			target.alpha = 1;
			callback.call();
		}
		@override void runOutEffect(BoxSprite target,double duration,Function callback)
		 {
			callback.call();
		}

	}

