 part of stagexl_commons;


	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
 
@retain
class DefaultScrollbar extends Scrollbar {
	 DefaultScrollbar(String orientation,num max,num size,[num pageJumpDuration=0.7]):super(orientation, max, size, pageJumpDuration) {

			// Draw thumb
			thumb = new Sprite();
			Graphics g;
			g = thumb.graphics;
			g.rect(0, 0, 8, 8);
			g.fillColor(0xffEEEEEE);
			g.rect(1, 1, 6, 6);
			g.fillColor(0xff333333);
			thumb.applyCache(0, 0, 8, 8);
			
			//_thumb.scale9Grid = new Rectangle(1, 1, 6, 6);

			// Draw background
			background = new Sprite();
			addChild(background);
			addChild(thumb);
      
			prepare();
			
		}
		
		
		@override 
		  void redraw() {
			Graphics g;
			g = background.graphics;
			if (_orientation == Orientation.HORIZONTAL) {
				g.rect(0, 0, size, 5);
				g.fillColor(0x00AAAAAA);
				background.applyCache(0, 0, size.round(), 5);
				background.y = 2;
			} else {
				g.rect(0, 0, 5, size);
				g.fillColor(0x00AAAAAA);
				background.applyCache(0, 0, 5, size.round());
				background.x = 2;
			}
			
			super.redraw();
			
		}


		@override 
		  void set enabled(bool value) {
			super.enabled = value;
			if (_enabled) {
			  if(stage != null){
				  stage.juggler.tween(this, 0.2)..animate.alpha.to(1);
			  }
			  else{
			    this.alpha = 1;
			  }
			}
			else {
			  if(stage != null){
  			  stage.juggler.tween(this, 0.2)..animate.alpha.to(0);
  		  }
  		  else{
  		    this.alpha = 0;
  		  }
			}
		}
	}

