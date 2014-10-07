part of stagexl_commons;


	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
	 @retain
class PaperListCell extends Cell {
		 static const num CELL_HEIGHT = 48;
		 PaperText _title;
		 Shape _bg;
	 
		 PaperListCell(int w, [int fontColor = PaperColor.GREY_DARK]) :super(){

		   _bg = new Shape();
		   addChild(_bg);
		   
		   PaperRipple	ripple = new PaperRipple(color: fontColor);
       addChild(ripple);

       _title = new PaperText("empty", size: 14, color: fontColor);
			addChild(_title);
			
			heightAsSet = CELL_HEIGHT;
			widthAsSet = w;
		}


		@override 
		void set data(Object newdata) {
			if (newdata != data) {
				super.data = newdata;
				if (data != null) {
					_title.text = (data as Map)["label"];
					redraw();
				}
			}
		}
    
		@override
		void setSize(num w, num h){
		  super.setSize(w, CELL_HEIGHT);
		}

		@override void redraw()
		 {
			_title.width = widthAsSet - 10;
			_title.x = 10;
			_title.y = (heightAsSet/2 - _title.textHeight/2).round();
			
			_bg.graphics.clear();
			_bg.graphics.rect(0, 0, widthAsSet, heightAsSet);
			_bg.graphics.fillColor(PaperColor.WHITE);
			if(ContextTool.WEBGL){
			  _bg.applyCache(0, 0, widthAsSet, heightAsSet);
			}
			
			super.redraw();
		}

	}

