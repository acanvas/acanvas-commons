 part of stagexl_commons;

	
	/**
	 * Draws shadows and highlights for a Page.
	 * 
	 * @author		Ruben Swieringa
	 * 				ruben.swieringa@gmail.com
	 * 				www.rubenswieringa.com
	 * 				www.rubenswieringa.com/blog
	 * @version		1.0.0
	 * @see			Page Page
	 * 
	 * 
	 * @internal
	 * 
	 * edit 3
	 * 
	 * 
	 * View code documentation at: dynamic  http://www.rubenswieringa.com/code/as3/flex/Book/docs/
	 * 
	 * 
	 * Copyright (2005 as c) Ruben Swieringa. All rights reserved.
	 * 
	 * This class is part of the Book component, which is licensed under the CREATIVE COMMONS Attribution 3.0 Unported.
	 *   You may not use this file except in compliance with the License.
	 *   You may obtain a copy of the License at: dynamic   http://creativecommons.org/licenses/by/3.0/deed.en
	 * 
	 */
	 class Gradients {
		
		
		// internals accessors:
		/**
		 * @
		 */
		 Page _page;
		/**
		 * @
		 */
		 num _solidColorAlpha = 0.3;
		
		// plain  properties
		 /**
		 * If true, highlights for the insides of hardcover Pages are not drawn.
		 * @default	true
		 */
		 bool eliminateSolidHighlights = true;
		
		// constants:
		 static const num ROTATE_FULL = 0.25;
		 static const num ROTATE_HALF = 0.75;
		 static const String LIGHT =	"light";
		 static const String DARK	=	"dark";
		/**
		 * @
		 */
		 static const int LIGHTCOLOR	= 0xFFFFFF;
		/**
		 * @
		 */
		 static const int DARKCOLOR	= 0x000000;
		
		/**
		 * @
		 */
		 static final Map FLIPSIDE = {
								"light":	{	"color": [LIGHTCOLOR, LIGHTCOLOR, LIGHTCOLOR, DARKCOLOR, DARKCOLOR],
											"alpha": [  0, 0.3, 0.2, 0.5,   0],
											"ratio": [  0,  88,  96, 128, 129] },
								"dark":	{	"color": [0xCCCCCC, 0x999999, 0x444444, 0x000000],
											"alpha": [  0, 0.1, 0.3, 0.6],
											"ratio": [  0,  74, 100, 128] } };
		/**
		 * @
		 */
		 static final Map INSIDE_SMOOTH = {
								"light":	{	"color": [DARKCOLOR, DARKCOLOR, DARKCOLOR, DARKCOLOR],
											"alpha": [  0,   0, 0.5,   0],
											"ratio": [  0,   1, 128, 129] },
								"dark":	{	"color": [DARKCOLOR, DARKCOLOR, DARKCOLOR, DARKCOLOR],
											"alpha": [  0,   0, 0.5,   0],
											"ratio": [  0,   1, 128, 129] } };
		/**
		 * @
		 */
		 static final Map OUTSIDE_SMOOTH = {
								"light":	{	"color": [DARKCOLOR, DARKCOLOR, DARKCOLOR, DARKCOLOR, DARKCOLOR],
											"alpha": [  0, 0.2,   0,   0,   0],
											"ratio": [126, 127, 141, 191, 255] },
								"dark":	{	"color": [DARKCOLOR, DARKCOLOR, DARKCOLOR, DARKCOLOR],
											"alpha": [  0, 0.4,   0,   0],
											"ratio": [126, 127, 191, 255] } };
		/**
		 * @
		 */
		 static final Map OUTSIDE_HARD = {
								"light":	{	"color": [DARKCOLOR, DARKCOLOR, DARKCOLOR, DARKCOLOR],
											"alpha": [0.8, 0.3, 0.1,  0],
											"ratio": [  0,  96, 160, 255] },
								"dark":	{	"color": [DARKCOLOR, DARKCOLOR, DARKCOLOR],
											"alpha": [  0, 0.2, 0.9],
											"ratio": [  0,  96, 255] } };
		
		
	// CONSTRUCTOR:
		
		/**
		 * Constructor.
		 */
		  Gradients(Page p) {
			
			this._page = p;
			
		}
		
		
	// CUSTOM:
		
		/**
		 * Draws a gradient to simulate depth in the middle of the Book.
		 * 
		 * @param	tint	Indicates whether to draw a highlight (Gradients.LIGHT) or shadow (Gradients.DARK)
		 * 
		 * @see		#LIGHT
		 * @see		#DARK
		 * 
		 * @see		#FOLD
		 * 
		 * @see		Book#addGradients()
		 * 
		 */
		  void drawFold(Graphics graphics,[String tint=Gradients.LIGHT, num rotate=Gradients.ROTATE_FULL]) {
			
			Map gradient = Gradients.FLIPSIDE[tint];
			SuperRectangle area = new SuperRectangle(0, 0, this._page.book.widthAsSet/2, this._page.book.heightAsSet);
			
			// define the points that the calculation will be based on:
			Point point1 = (this._page.side == Page.LEFT) ? area.topRight : area.topLeft;
			Point point2 = (this._page.side == Page.LEFT) ? area.bottomRight : area.bottomLeft;
			
			// create the model for the gradient:
			Matrix matrix = this.createNewMatrix(point1, point2, rotate);
			
			// draw gradient:
			DrawingTool.rect(graphics, area);
      GraphicsGradient g = GraphicsUtil.linearGraphicsGradient(
          gradient["color"],
          gradient["alpha"],
          gradient["ratio"],
          matrix);
      graphics.fillGradient(g);
			
		}
		
		
		/**
		 * Draws a gradient to simulate a shadow on the facing pages of the Book.
		 * 
		 * @param	area	List with coordinates (Point instances), typically the cPoints property of the ocf Map returned by the computeFlip method of the PageFlip class
		 * @param	tint	Indicates whether to draw a light or dark shadow
		 * @param	rotate	The correction of the gradient its rotation (from 0.0 to 1.0)
		 * 
		 * @see		Gradients#ROTATE_FULL;
		 * @see		Gradients#ROTATE_HALF;
		 * 
		 * @see		Gradients#LIGHT
		 * @see		Gradients#DARK
		 * 
		 * @see		Gradients#INSIDE
		 * 
		 * @see		Book#addGradients()
		 * @see		PageFlip#computeFlip()
		 * 
		 */
		  void drawInside(Graphics graphics,List area,[String tint=Gradients.DARK, num rotate=Gradients.ROTATE_FULL]) {
			
			if (this._page.hard){
				this.drawInsideHard(graphics, area, tint, rotate);
			}else{
				this.drawInsideSmooth(graphics, area, tint, rotate);
			}
			
		}
		/**
		 * @see	Gradients#drawInside()
		 * 
		 * @
		 */
		  void drawInsideHard(Graphics graphics,List area,[String tint=Gradients.DARK, num rotate=Gradients.ROTATE_FULL]) {
			// hard pages don't need highlights, only shadows:
			if (this.eliminateSolidHighlights && tint == Gradients.LIGHT){
				return;
			}
			
			int color = (tint == Gradients.DARK) ? Gradients.DARKCOLOR : Gradients.LIGHTCOLOR;
			
			// calculate strength (of as opacity) the "color":
			num strength = (this._page.book.widthAsSet/2 - (area[0].x - area[1].x)) / (this._page.book.widthAsSet/2).abs() * this._solidColorAlpha;
			
			// draw "color":
			DrawingTool.draw(graphics, area);
			graphics.fillColor(((strength* 256).round() << 24) + color);
			
		}
		/**
		 * @see	Gradients#drawInside()
		 * 
		 * @
		 */
		  void drawInsideSmooth(Graphics graphics,List area,[String tint=Gradients.DARK, num rotate=Gradients.ROTATE_FULL]) {
			
			Map gradient = Gradients.INSIDE_SMOOTH[tint];
			
			// define the points that the calculation will be based on:
			Point point1 = area[area.length-2];
			Point point2 = area[area.length-1];
			Point point3 = new Point((this._page.book.widthAsSet/2)*this._page.book.getLastFlippedCorner().x, this._page.book.heightAsSet*this._page.book.getLastFlippedCorner().y);
			Point point4 = area[0];
			List newArea = [point1, point2];
			
			// adjust area (inside shadow is in a combination-area of the facing and flipping coordinates):
			num x = (this._page.side == Page.LEFT) ? this._page.book.widthAsSet : -this._page.book.widthAsSet/2;
			num y = (point2.y == 0) ? 0 : this._page.book.heightAsSet;
			newArea.add(new Point(x, y));
			y = (point2.y == 0) ? this._page.book.heightAsSet : 0;
			newArea.add(new Point(x, y));
			
			// creates Lines that will be defined in all following if-statements:
			Line line = new Line();
			Line hLine = new Line();
			
			// if only one corner is flipping:
			if (area.length == 3){
				
				x = (this._page.side == Page.LEFT) ? 0 : this._page.book.widthAsSet/2;
				newArea.add(new Point(x, y));
				newArea.insert(1, area[0]);
				
				// if flipped corner is outside of the Book its boundaries:
				if (area[0].y < 0 || area[0].y > this._page.book.heightAsSet){
					
					Point intersection1;
					Point intersection2;
					
					line.a	= area[0];
					hLine.a	= newArea[4];
					hLine.b	= newArea[5];
					
					// calculate first intersection Point:
					line.b	= area[2];
					intersection1 = Line.getIntersection(line, hLine);
					
					// calculate second intersection Point:
					line.b	= area[1];
					intersection2 = Line.getIntersection(line, hLine);
					
					// replace the out-of-bounds Point with the two intersection Points:
					newArea.replaceRange(1, 1, [intersection2, intersection1]);
					
				}
				
			}
			
			// if two corners are flipped:
			if (area.length == 4){
				
				Point intersection;
				
				// calculate intersection (if both flipped corners are out of the bounds of the Book):
				if ((area[0].y < 0 && area[1].y < 0) || (area[0].y > this._page.book.heightAsSet && area[1].y > this._page.book.heightAsSet)){
					
					int correctionIndex;
					
					if (this._page.book.lastFlippedSide == Page.LEFT){
						correctionIndex = (area[0].x > area[1].x) ? 0 : 1;
						line.a	= (area[0].x > area[1].x) ? area[0] : area[1];
						line.b	= (area[0].x > area[1].x) ? area[3] : area[2];
						hLine.a	= (area[0].x > area[1].x) ? newArea[3] : newArea[2];
						hLine.b	= (area[0].x > area[1].x) ? newArea[0] : newArea[1];
					}else{
						correctionIndex = (area[0].x < area[1].x) ? 0 : 1;
						line.a	= (area[0].x < area[1].x) ? area[0] : area[1];
						line.b	= (area[0].x < area[1].x) ? area[3] : area[2];
						hLine.a	= (area[0].x < area[1].x) ? newArea[3] : newArea[2];
						hLine.b	= (area[0].x < area[1].x) ? newArea[0] : newArea[1];
					}
					
					intersection = Line.getIntersection(line, hLine);
					newArea[correctionIndex] = intersection;
					
				// calculate intersection (if only one flipped corner is out of the bounds of the Book):
				}else{
					
					newArea.insert(1, area[1]);
					newArea.insert(2, area[0]);
					line = new Line(newArea[1], newArea[2]);
					
					if (line.a.y < 0 || line.b.y < 0){
						hLine.a = (line.a.y < line.b.y) ? newArea[newArea.length-1] : newArea[newArea.length-3];
						hLine.b = (line.a.y < line.b.y) ? newArea[0] : newArea[newArea.length-2];
					}else{
						hLine.a = (line.a.y > line.b.y) ? newArea[newArea.length-1] : newArea[newArea.length-3];
						hLine.b = (line.a.y > line.b.y) ? newArea[0] : newArea[newArea.length-2];
					}
					
					if (line.a.y != hLine.a.y && line.b.y != hLine.a.y){
						intersection = Line.getIntersection(line, hLine);
						int spliceAt;
						if (newArea[1].y < 0 || newArea[1].y > this._page.book.heightAsSet) spliceAt = 0;
						if (newArea[2].y < 0 || newArea[2].y > this._page.book.heightAsSet) spliceAt = newArea.length-4;
						newArea.replaceRange(spliceAt, 2, [intersection]);
					}
					
				}
				
			}
			
			// calculate strength of the gradient:
			num strength = Point.distance(point3, point4) / this._page.book.widthAsSet;
			
			// create the model for the gradient:
			Matrix matrix = this.createNewMatrix(point1, point2, rotate);
			
			// draw gradient:
			DrawingTool.draw(graphics, newArea);
			
			GraphicsGradient gr = GraphicsUtil.linearGraphicsGradient(
                gradient["color"],
                gradient["alpha"],
                gradient["ratio"],
                matrix);
			graphics.fillGradient(gr);
			
			
		}
		
		
		/**
		 * Draws a gradient to simulate a shadow on the next page of the Book.
		 * 
		 * @param	area	List with coordinates (Point instances), typically the pPoints property of the ocf Map returned by the computeFlip method of the PageFlip class
		 * @param	tint	Indicates whether to draw a light or dark shadow
		 * @param	rotate	The correction of the gradient its rotation (from 0.0 to 1.0)
		 * 
		 * @see		Gradients#ROTATE_FULL;
		 * @see		Gradients#ROTATE_HALF;
		 * 
		 * @see		Gradients#LIGHT
		 * @see		Gradients#DARK
		 * 
		 * @see		Gradients#OUTSIDE
		 * 
		 * @see		Book#addGradients()
		 * @see		PageFlip#computeFlip()
		 * 
		 */
		  void drawOutside(Graphics graphics,List area,[String tint=Gradients.DARK, num rotate=Gradients.ROTATE_FULL]) {
			
			if (this._page.hard){
				this.drawOutsideHard(graphics, area);
			}else{
				this.drawOutsideSmooth(graphics, area, tint, rotate);
			}
			
		}
		/**
		 * @see	Gradients#drawOutside()
		 * 
		 * @
		 */
		  void drawOutsideHard(Graphics graphics,List area) {
			
			Map gradient0 = Gradients.OUTSIDE_HARD["dark"];
			Map gradient1 = Gradients.OUTSIDE_HARD["light"];
			
			// define the coordinates for the gradients:
			Rectangle area0 = new Rectangle(0, 0, this._page.book.widthAsSet/2, this._page.book.heightAsSet);
			Rectangle area1 = new Rectangle(0, 0, this._page.book.widthAsSet/2, this._page.book.heightAsSet);
			area0.left	= area[0].x - this._page.book.widthAsSet/2;
			area0.right	= min(area[0].x, area[1].x);
			area1.left	= max(area[0].x, area[1].x);
			area1.right	= area[0].x + this._page.book.widthAsSet/2;
			
			// calculate strength of the gradients:
			num strength0 = 1 - (area[1].x - area0.x) / this._page.book.widthAsSet;
			num strength1 = max(0, (area[1].x - area[0].x) / (this._page.book.widthAsSet/2));
			
			// create the model for the gradients:
			Matrix matrix0 = new Matrix.fromIdentity();
			Matrix matrix1 = new Matrix.fromIdentity();
			matrix0.createBox(this._page.book.widthAsSet/2, this._page.book.heightAsSet, 0, area0.left, 0);
			matrix1.createBox(this._page.book.widthAsSet/2, this._page.book.heightAsSet, 0, area[0].x, 0);
			
			// draw left gradient:
			if (strength0 > 0){
				DrawingTool.rect(graphics, area0);
			  GraphicsGradient g = GraphicsUtil.linearGraphicsGradient(
			        gradient0["color"],
              ListTool.adjustValues(gradient0["alpha"], strength0, MathTool.MULTIPLICATION),
              gradient0["ratio"],
              matrix0);
			  graphics.fillGradient(g);
			}
			
			// draw right gradient:
			if (strength1 > 0){
				DrawingTool.rect(graphics, area1);
			  GraphicsGradient g = GraphicsUtil.linearGraphicsGradient(
			        gradient1["color"],
              ListTool.adjustValues(gradient1["alpha"], strength1, MathTool.MULTIPLICATION),
              gradient1["ratio"],
              matrix1);
			  graphics.fillGradient(g);
			}
			
		}
		/**
		 * @see	Gradients#drawOutside()
		 * 
		 * @
		 */
		  void drawOutsideSmooth(Graphics graphics,List area,[String tint=Gradients.DARK, num rotate=Gradients.ROTATE_FULL]) {
			
			Map gradient = Gradients.OUTSIDE_SMOOTH[tint];
			
			// define the points that the calculation will be based on:
			List newArea;
			Point point1 = area[area.length-3];
			Point point2 = area[area.length-2];
			// calculation for normal pageflips:
			if (!this._page.book.tearActive){
				newArea = [point1, point2];
				if (newArea[0].y == 0 || newArea[1].y == 0){
					newArea.add(new Point(this._page.side*this._page.book.widthAsSet/2, 0));
				}else{
					newArea.add(new Point(this._page.side*this._page.book.widthAsSet/2, this._page.book.heightAsSet));
				}
				if (area.length == 4){
					int spliceAt = (newArea[1].y == 0) ? 0 : newArea.length - 1;
					if (newArea[0].y == this._page.book.heightAsSet || newArea[1].y == this._page.book.heightAsSet){
						newArea.insert(spliceAt, new Point(this._page.side*this._page.book.widthAsSet/2, this._page.book.heightAsSet));
					}
				}
			}
			// calculation for tearing pageflips:
			if (this._page.book.tearActive){
				newArea = ListTool.copy(area);
		 		if (newArea[0].y == 0){
					newArea[0].y = newArea[3].y = this._page.book.heightAsSet;
				}else{
					newArea[0].y = newArea[3].y = 0;
				}
			}
			
			// define additional points and calculate strength of the gradient:
			Point point3 = newArea[newArea.length-1];
			Point point4 = Point.interpolate(point1, point2, 0.5);
			num max;
			num strength;
			if (!this._page.book.tearActive){
				max = this._page.book.widthAsSet/2;
				strength = 1 - (max/2-(point3.x-point4.x).abs()) / (max/2).abs();
			}else{
				max = this._page.book.heightAsSet;
				strength = 1 - (point3.y-point4.y).abs()/max;
			}
			
			// create the model for the gradient:
			Matrix matrix = this.createNewMatrix(point1, point2, rotate);
			
			// draw gradient:
			DrawingTool.draw(graphics, newArea);
			GraphicsGradient g = GraphicsUtil.linearGraphicsGradient(
			      gradient["color"],
            ListTool.adjustValues(gradient["alpha"], strength, MathTool.MULTIPLICATION),
            gradient["ratio"],
            matrix);
      graphics.fillGradient(g);
			
		}
		
		
		/**
		 * Draws a gradient to simulate depth on the flipside of the Page.
		 * 
		 * @param	area	List with coordinates (Point instances), typically the cPoints property of the ocf Map returned by the computeFlip method of the PageFlip class
		 * @param	tint	Indicates whether to draw a highlight (Gradients.LIGHT) or shadow (Gradients.DARK)
		 * @param	rotate	The correction of the gradient its rotation (from 0.0 to 1.0)
		 * 
		 * @see		Gradients#ROTATE_FULL;
		 * @see		Gradients#ROTATE_HALF;
		 * 
		 * @see		Gradients#LIGHT
		 * @see		Gradients#DARK
		 * 
		 * @see		Gradients#FLIPSIDE
		 * 
		 * @see		Book#addGradients()
		 * @see		PageFlip#computeFlip()
		 * 
		 */
		  void drawFlipside(Graphics graphics,List area,[String tint=Gradients.LIGHT, num rotate=Gradients.ROTATE_FULL]) {
			
			// this method is not applicable to hard Pages:
			if (this._page.hard){
				return;
			}
			
			Map gradient = Gradients.FLIPSIDE[tint];
			
			// define the points that the calculation will be based on:
			Point point1 = area[area.length-2];
			Point point2 = area[area.length-1];
			
			// calculate strength of the gradient:
			Point point3 = Point.interpolate(point1, point2, 0.5);
			Point point4 = Point.interpolate(area[0], area[1], 0.5);
			num max = this._page.book.widthAsSet/2;
			num strength = 0.5 + ((point3.x-point4.x)/max).abs() * 0.5;
			
			// create the model for the gradient:
			Matrix matrix = this.createNewMatrix(point1, point2, rotate);
			
			// draw gradient:
			DrawingTool.draw(graphics, area);
      GraphicsGradient g = GraphicsUtil.linearGraphicsGradient(
          gradient["color"],
          ListTool.adjustValues(gradient["alpha"], strength, MathTool.MULTIPLICATION),
          gradient["ratio"],
          matrix);
      graphics.fillGradient(g);
			
		}
		
		
		/**
		 * Returns a Matrix instance with a gradientbox with the properties read from the provided parameters.
		 * 
		 * @param	point1	Point indicating the first coordinate in a line used for calculating the gradient its rotation and position
		 * @param	point2	Point indicating the second coordinate in a line used for calculating the gradient its rotation and position
		 * @param	rotate	The correction of the gradient its rotation (from 0.0 to 1.0)
		 * 
		 * @see		Gradients#ROTATE_FULL;
		 * @see		Gradients#ROTATE_HALF;
		 * 
		 * @see		Gradients#drawInside()
		 * @see		Gradients#drawOutside()
		 * @see		Gradients#drawFlipside()
		 * 
		 * @return	Matrix
		 * 
		 * @
		 */
		  Matrix createNewMatrix(Point point1,Point point2,[num rotate=Gradients.ROTATE_FULL]) {
			
			rotate *= PI * 2;
			
			// get offset and angle:
			Point offset =	this.getOffset(point1, point2);
			num angle =	Geom.getAngle (point1, point2) - rotate;
			
			// define sizes:
			num larger	= max(this._page.book.widthAsSet/2, this._page.book.heightAsSet);
			num smaller	= min(this._page.book.widthAsSet/2, this._page.book.heightAsSet);
			if (larger == this._page.book.heightAsSet){
				offset.x -= (larger-smaller) / 2;
			}else{
				offset.y -= (larger-smaller) / 2;
			}
			
			// create the model for the gradient:
			Matrix matrix = new Matrix.fromIdentity();
			matrix.createBox(larger, larger, angle, offset.x, offset.y);
			
			// return value:
			return matrix;
			
		}
		/**
		 * Calculates offset for the createBox() method executed in createNewMatrix().
		 * 
		 * @param	point1	Point indicating the first coordinate in a line used for calculating the gradient its position
		 * @param	point2	Point indicating the second coordinate in a line used for calculating the gradient its position
		 * 
		 * @see		Gradients#createNewMatrix()
		 * 
		 * @return	Point with x (for x-offset) and y (y-offset) properties
		 * 
		 * @
		 */
		  Point getOffset(Point point1,Point point2) {
			Point middle =	new Point(this._page.book.widthAsSet/2/2, this._page.book.heightAsSet/2);
			Point average =	Point.interpolate(point1, point2, 0.5);
			Point offset =	new Point(average.x - middle.x, average.y - middle.y);
			return offset;
		}
		
		
	// ACCESSORS:
		
		/**
		 * Page this Gradients instance is associated with.
		 * 
		 * @see	Page
		 * 
		 */
		  Page get page {
			return this._page;
		}
		
		/**
		 * The maximum alpha value for solid shadows or highlights on Pages.
		 * 
		 * @default	0.3
		 */
		  num get solidColorAlpha {
			return this._solidColorAlpha;
		}
		  void set solidColorAlpha(num value) {
			if (value < 0) value = 0;
			if (value > 1) value = 1;
			this._solidColorAlpha = value;
		}
		
		
	}
	
	