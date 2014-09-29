 part of dart_commons;
	
	
	
	
	/**
	 * Provides basic functionality for drawing with the Drawing API.
	 * 
	 * @author		Ruben Swieringa
	 * 				ruben.swieringa@gmail.com
	 * 				www.rubenswieringa.com
	 * 				www.rubenswieringa.com/blog
	 * @version		1.0.0
	 * @see			LineStyle
	 * 
	 * 
	 * edit 1
	 * 
	 * Before modifying and/or redistributing this class, please contact Ruben Swieringa (ruben.swieringa@gmail.com).
	 * 
	 * 
	 * View code documentation at: dynamic  http://www.rubenswieringa.com/code/as3/flex/DrawingTool/docs/
	 * 
	 */
	 class DrawingTool {
		
		
		// constants:
		 static const String CROSS = "cross";
		 static const String CIRCLE = "circle";
		
		
		/**
		 * Constructor.
		 * @
		 */
		  DrawingTool() {}
		
		
		/**
		 * Draws a cross shaped marker on the specified coordinate(s).
		 * This method its main functionality is that it executes the lineTo() method, so (for example) when aiming to draw a filled shape, fillColor() must be called first. For drawing lines, either the lineStyle() method of the Graphics class must be executed, or a LineStyle instance must be used as a parameter value for this method.
		 * 
		 * @param	graphics	Graphics instance on which to draw the shape.
		 * @param	point		List or Point specifying one or more Point instances. If the point parameter value is neither a Point nor an List then the function will silently fail.
		 * @param	size		Size of the marker.
		 * @param	shape		Shape of the marker, either DrawingTool.CROSS or DrawingTool.CIRCLE. Defaults to DrawingTool.CROSS.
		 * @param	lineStyle	LineStyle instance carrying the styles for the lines of the marker to be drawn.
		 * 
		 * @see		LineStyle
		 * @see		DrawingTool#CROSS
		 * @see		DrawingTool#CIRCLE
		 * 
		 */
		 static void drawMarker(Graphics graphics,dynamic point,[num size=10, String shape=CROSS, LineStyle lineStyle=null]) {
			if (point is List){
				for (String i in point){
					drawMarker(graphics, point[i], size, shape);
				}
			}
			if (point is Point){
				switch (shape){
					case CROSS :
						Point point1 = new Point(point.x-size/2, point.y-size/2);
						Point point2 = new Point(point.x+size/2, point.y+size/2);
						Point point3 = new Point(point.x+size/2, point.y-size/2);
						Point point4 = new Point(point.x-size/2, point.y+size/2);
						drawLine(graphics, point1, point2, lineStyle);
						drawLine(graphics, point3, point4, lineStyle);
						break;
					case CIRCLE :
						if (lineStyle != null){
							lineStyle.applyTo(graphics);
						}
						graphics.moveTo(point.x+size/2, point.y);
						graphics.quadraticCurveTo(point.x+size/2, point.y+size/2, point.x, point.y+size/2);
						graphics.quadraticCurveTo(point.x-size/2, point.y+size/2, point.x-size/2, point.y);
						graphics.quadraticCurveTo(point.x-size/2, point.y-size/2, point.x, point.y-size/2);
						graphics.quadraticCurveTo(point.x+size/2, point.y-size/2, point.x+size/2, point.y);
						break;
				}
			}
		}
		
		
		/**
		 * Draws lines between the Point instances in the area List onto graphics with the drawing API.
		 * This method its main functionality is that it executes the lineTo() method, so (for example) when aiming to draw a filled shape, fillColor() must be called first. For drawing lines, either the lineStyle() method of the Graphics class must be executed, or a LineStyle instance must be used as a parameter value for this method (DrawingTool.draw()). Also see the example below.
		 * 
		 * @param	graphics	Graphics instance on which the lines should be drawn
		 * @param	area		List with coordinates (Point instances)
		 * @param	connect		bool indicating whether or not to connect the last Point in area with the last Point in area. Defaults to true.
		 * @param	lineStyle	LineStyle instance carrying the styles for the lines of the shape to be drawn.
		 * 
		 * @example	Drawing a filled shape: dynamic 			<listing version="3.0">
		 * 			List shape = [new Point(0,0), new Point(100,0), new Point(0,100)];
		 * 			myGraphics.fillColor(0xFF0000);
		 * 			DrawingTool.draw(myGraphics, shape);
		 * 			//myGraphics.endFill() //not supported in StageXL;
		 * 			</listing>
		 * 
		 * @example	Drawing a shape with outline: dynamic 			<listing version="3.0">
		 * 			List shape = [new Point(0,0), new Point(100,0), new Point(0,100)];
		 * 			myGraphics.lineStyle(1, 0x00FF00);
		 * 			DrawingTool.draw(myGraphics, shape);
		 * 			</listing>
		 * 
		 * @example	Drawing a shape with dashed outline using the LineStyle class: dynamic 			<listing version="3.0">
		 * 			List shape = [new Point(0,0), new Point(100,0), new Point(0,100)];
		 * 			LineStyle lineStyle = new LineStyle(1, 0x00FF00);
		 * 			lineStyle.dash = 4;
		 * 			DrawingTool.draw(myGraphics, shape);
		 * 			</listing>
		 * 
		 * @see		LineStyle
		 * 
		 */
		 static  void draw(Graphics graphics,List area,[bool connect=true, LineStyle lineStyle=null]) {
			int i;
			List newArea = [];
			for (i=0; i<area.length; i++){
				if (area[i] != null){
					newArea.add(area[i]);
				}
			}
			if (newArea.length < 2){
				return;
			}
			graphics.moveTo(newArea[0].x, newArea[0].y);
			for (i=1; i<newArea.length; i++){
				if (newArea[i] != null){
					drawLine(graphics, newArea[i-1], newArea[i], lineStyle, false);
				}
			}
			if( connect != null || connect == true){
				drawLine(graphics, newArea[newArea.length-1], newArea[0], lineStyle, false);
			}
		}
		
		
		/**
		 * Draws lines between the four corners of a Rectangle.
		 * Note that this method is not the same as the method with the same name in the Graphics class, which takes the parameters of the Rectangle constructor as parameters, instead of a Rectangle instance, as does this method.
		 * This method its main functionality is that it executes the lineTo() method, so (for example) when aiming to draw a filled shape, fillColor() must be called first. For drawing lines, either the lineStyle() method of the Graphics class must be executed, or a LineStyle instance must be used as a parameter value for this method. Also see the example included in the documentation for the draw() method.
		 * 
		 * @param	graphics	Graphics instance on which the lines should be drawn
		 * @param	rect		Rectangle
		 * @param	lineStyle	LineStyle instance carrying the styles for the lines of the Rectangle to be drawn.
		 * 
		 * @see		LineStyle
		 * @see		DrawingTool#draw()
		 */
		 static  void rect(Graphics graphics,Rectangle rect,[LineStyle lineStyle=null]) {
			List area =   [rect.topLeft,
								new Point(rect.right, rect.top),
								rect.bottomRight,
								new Point(rect.left, rect.bottom)];
			draw(graphics, area, true, lineStyle);
		}
		
		
		/**
		 * Draws a line from one Point to another.
		 * This method its main functionality is that it executes the lineTo() method, so (for example) when aiming to draw a filled shape, fillColor() must be called first. For drawing lines, either the lineStyle() method of the Graphics class must be executed, or a LineStyle instance must be used as a parameter value for this method.
		 * 
		 * @param	graphics	Graphics instance on which to draw the line.
		 * @param	point1		First Point.
		 * @param	point2		second Point.
		 * @param	lineStyle	LineStyle instance storing the properties of the line to be drawn.
		 * @param	moveTo		Whether or not to execute the Graphics class its moveTo() method before running the rest of the method.
		 * 
		 * @see		LineStyle
		 */
		 static  void drawLine(Graphics graphics,Point point1,Point point2,[LineStyle lineStyle=null, bool moveTo=true]) {
			
			if( moveTo != null || moveTo == true){
				graphics.moveTo(point1.x, point1.y);
			}
			
			if (lineStyle != null && lineStyle.dashEnabled){ // draw dashed line
				
				num distance = Point.distance(point1, point2);
				num traveled = 0;
				Point next;
				
				for (int i=0; i<(distance/(lineStyle.dash+lineStyle.space)).ceil(); i++){
					traveled = i * (lineStyle.dash + lineStyle.space);
					// draw line:
					traveled = (traveled + lineStyle.dash >= distance) ? distance : traveled + lineStyle.dash;
					next = Point.interpolate(point1, point2, 1-(traveled/distance));
//					lineStyle.applyTo(graphics);
					graphics.lineTo(next.x, next.y);
					// stop if end of dash is equal to end of line:
					if (next.equals(point2)) break;
					// draw space:
					traveled = (traveled + lineStyle.space >= distance) ? distance : traveled + lineStyle.space;
					next = Point.interpolate(point1, point2, 1-(traveled/distance));
					clearLineStyle(graphics);
					graphics.lineTo(next.x, next.y);
					lineStyle.applyTo(graphics);
				}
				
			}else{ // draw normal line
				
				graphics.lineTo(point2.x, point2.y);
				if (lineStyle != null){
					lineStyle.applyTo(graphics);
				}
				
			}
			
		}
		
		
		/**
		 * Sets the lineStyle of a Graphics instance to none.
		 * 
		 * @param	graphics	Graphics instance of which to clear the lineStyle.
		 * 
		 */
		 static  void clearLineStyle(Graphics graphics) {
			//graphics.lineStyle(undefined, undefined, undefined);
		}
		
		
	}
	
