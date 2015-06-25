part of stagexl_commons;


	/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
class PaperListCell extends Cell {
		 PaperText title;
		 int fontColor;
	 
		 PaperListCell(int w, [this.fontColor = PaperColor.GREY_DARK]) :super(){

		   PaperRipple	ripple = new PaperRipple(color: fontColor);
       addChild(ripple);

       title = new PaperText("empty", size: 14, color: fontColor);
			addChild(title);

			 setSize(w, PaperDimensions.HEIGHT_MENU_CELL);
		}


		@override
		Cell clone(num width, [int fontClr])
		 		=> new PaperListCell(width, fontClr);


		@override 
		void set data(Object newdata) {
			if (newdata != data) {
				super.data = newdata;
				if (data != null && data is Map) {
					title.text = (data as Map)["label"];
					redraw();
				}
			}
		}
    
		@override
		void setSize(num w, num h){
		  super.setSize(w, PaperDimensions.HEIGHT_MENU_CELL);
		}

		@override void redraw()
		 {
			title.width = widthAsSet - 10;
			title.x = 10;
			title.y = (heightAsSet/2 - title.textHeight/2).round();

			graphics.clear();
			graphics.rect(0, 0, widthAsSet, heightAsSet);
			graphics.fillColor(PaperColor.WHITE);

			super.redraw();
		}

	}

