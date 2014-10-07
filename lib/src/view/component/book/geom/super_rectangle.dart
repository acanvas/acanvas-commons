 part of stagexl_commons;




	
	/**
	 * Provides functionality for working with Rectangles. This class extends the RoundedRectangle class and thus has all of its functionality (and also the functionality of the Rectangle class, which RoundedRectangle extends).
	 * 
	 * @author		Ruben Swieringa
	 * 				ruben.swieringa@gmail.com
	 * 				www.rubenswieringa.com
	 * 				www.rubenswieringa.com/blog
	 * @version		1.0.0
	 * 
	 * 
	 * edit 5b*
	 * 
	 * * This class is a slightly stripped-down version of the original SuperRectangle class (the unfinished method getCornersInbetween() has been removed)
	 * 
	 * Before modifying and/or redistributing this class, please contact Ruben Swieringa (ruben.swieringa@gmail.com).
	 * 
	 * 
	 * View code documentation at: dynamic  http://www.rubenswieringa.com/code/as3/flex/Geom/docs/
	 * 
	 */
	 class SuperRectangle extends Rectangle {
		
		
		 static const int NONE = -1;
		 static const int TOP = 0;
		 static const int RIGHT = 1;
		 static const int BOTTOM = 2;
		 static const int LEFT = 3;
		
		
		/**
		 * Constructor.
		 */
		 num _cornerRadius;

		  SuperRectangle([num x=0, num y=0, num width=0, num height=0, num cornerRadius=0]) : super(x, y, width, height) {
			_cornerRadius = cornerRadius;
		}
		
		
		/**
		 * Takes a Rectangle instance and returns it as a SuperRectangle with the same position, width, height, and (if applicable) corner-radius.
		 * 
		 * @param	rect	Rectangle
		 * 
		 * @return	rect as a SuperRectangle.
		 */
		 static  SuperRectangle createSuperRectangle(Rectangle rect) {
			if (rect is SuperRectangle){
				return rect;
			}
			SuperRectangle newRect = new SuperRectangle(rect.x, rect.y, rect.width, rect.height);
//			if (rect is RoundedRectangle){
//				newRect.cornerRadius = RoundedRectangle(rect).cornerRadius;
//			}
			return newRect;
		}
		
		
		/**
		 * Indicates on which side of this SuperRectangle a Point is. Note that if the Point is not on the SuperRectangle its border, -1 will be the return-value.
		 * 
		 * @param	point	A coordinate.
		 * 
		 * @see		SuperRectangle#NONE
		 * @see		SuperRectangle#TOP
		 * @see		SuperRectangle#RIGHT
		 * @see		SuperRectangle#BOTTOM
		 * @see		SuperRectangle#LEFT
		 * 
		 * @return	An integer indicating on which side a given coordinate is. 0 stands for he top-side, 1 for right-side, etc. Use the constants of the SuperRectangle class for improved code-readability.
		 */
		  int isOnSide(Point point) {
			List lines = this.getLines();
			for (int i=0; i<lines.length; i++){
				if (lines[i].containsPoint(point)){
					switch (i){
						case 0 : return SuperRectangle.TOP;
						case 1 : return SuperRectangle.RIGHT;
						case 2 : return SuperRectangle.BOTTOM;
						case 3 : return SuperRectangle.LEFT;
					}
				}
			}
			return SuperRectangle.NONE;
		}
		
		
		/**
		 * Returns an List with Point instances indicating the corners of the SuperRectangle. The first index (0) is the top-left corner, the second (1) the top-right, etc.
		 * 
		 * @return	List
		 */
		  List getCorners() {
			return [this.topLeft, this.topRight, this.bottomRight, this.bottomLeft];
		}
		/**
		 * Returns an List with Point instances indicating the 4 sides of this SuperRectangle as Lines.
		 * 
		 * @see		Line
		 * 
		 * @return	List
		 */
		  List getLines() {
			List lines = [];
			List corners = this.getCorners();
			lines.add(new Line(corners[0], corners[1]));
			lines.add(new Line(corners[1], corners[2]));
			lines.add(new Line(corners[2], corners[3]));
			lines.add(new Line(corners[3], corners[0]));
			return lines;
		}
		/**
		 * @copy	SuperRectangle#getCorners()
		 * 
		 * @see		SuperRectangle#getCorners()
		 * 
		 * @return	List
		 */
		  List toList() {
			return this.getCorners();
		}
		
		
		/**
		 * The center of the SuperRectangle.
		 */
		  Point get center {
			return Point.interpolate(this.bottomRight, this.topLeft, 0.5);
		}
		
		
		/**
		 * Point representing the lower left corner of this SuperRectangle.
		 */
		  Point get bottomLeft {
			return new Point(this.left, this.bottom);
		}
		/**
		 * Point representing the upper right corner of this SuperRectangle.
		 */
		  Point get topRight {
			return new Point(this.right, this.top);
		}
		
		
		/**
		 * The center of this SuperRectangle instance.
		 */
		  Point get middle {
			Point point = new Point(0,0);
			point.x = this.x + this.width/2;
			point.y = this.y + this.height/2;
			return point;
		}

		  num get cornerRadius {
			return _cornerRadius;
		}
		
		
	}
	
	
