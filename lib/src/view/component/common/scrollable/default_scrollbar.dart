 part of stagexl_commons;


	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
 
class DefaultScrollbar extends Scrollbar {
	 DefaultScrollbar([String orientation=Orientation.VERTICAL,num max=0,num size=100,num pageJumpDuration=0.7]):super(orientation, max, size, pageJumpDuration) {

			// Draw thumb
			thumb = new Sprite();
			Graphics g;
			g = thumb.graphics;
			g.rect(0, 0, 8, 8);
			g.fillColor(PaperColor.BLACK);
			//g.rect(1, 1, 6, 6);
			//g.fillColor(0xff333333);
			//thumb.applyCache(0, 0, 8, 8);
			
			//_thumb.scale9Grid = new Rectangle(1, 1, 6, 6);

			// Draw background
			background = new Sprite();
			addChild(background);
			addChild(thumb);
      
			prepare();
			
		}

	 @override
	 Scrollbar clone(String orientation, num max, num size, [num pageScrollDuration = 0.7])
	 	=> new DefaultScrollbar(orientation, max, size, pageScrollDuration);
		
		
		@override 
		  void redraw() {
			Graphics g;
			g = background.graphics;
			if (_orientation == Orientation.HORIZONTAL) {
				g.rect(0, 0, size, 8);
				g.fillColor(PaperColor.TRANSPARENT);
			} else {
				g.rect(0, 0, 8, size);
				g.fillColor(PaperColor.TRANSPARENT);
			}
			
			super.redraw();
			
		}


		@override 
		  void set enabled(bool value) {
			super.enabled = value;
			if (_enabled) {
				ContextTool.STAGE.juggler.addTween(this, 0.2)..animate.alpha.to(1);
			}
			else {
				this.alpha = 0;
			}
		}
	}

