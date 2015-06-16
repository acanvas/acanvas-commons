 part of stagexl_commons;
	

	
	/**
	 * Describes a line consisting of two Points.
	 * 
	 * @author		Ruben Swieringa
	 * 				ruben.swieringa@gmail.com
	 * 				www.rubenswieringa.com
	 * 				www.rubenswieringa.com/blog
	 * @version		1.0.0
	 * @see			InfiniteLine
	 * 
	 * 
	 * edit 4
	 * 
	 * Before modifying and/or redistributing this class, please contact Ruben Swieringa (ruben.swieringa@gmail.com).
	 * 
	 * 
	 * View code documentation at: dynamic  http://www.rubenswieringa.com/code/as3/flex/Geom/docs/
	 * 
	 */
	 class Line extends InfiniteLine {
		
		
		/**
		 * @
		 */
		 Point _a = new Point(0, 0);
		/**
		 * @
		 */
		 Point _b = new Point(1, 1);
		
		
		/**
		 * Constructor.
		 * 
		 * @param	pointA	Line's first Point.
		 * @param	pointB	Line's second Point.
		 * 
		 * @see		Line#a
		 * @see		Line#b
		 * 
		 */
		  Line([Point pointA=null, Point pointB=null]) {
			if (pointA != null) this.a = pointA;
			if (pointA != null) this.b = pointB;
		}
		
		
		/**
		 * Returns a Point instance that represents the coordinate at which two Line instances intersect.
		 * 
		 * @param	line1	Line
		 * @param	line2	Line
		 * 
		 * @see		InfiniteLine#getIntersection()
		 * 
		 * @return	A Point instance if intersections occurs, null of otherwise.
		 */
		 static  Point getIntersection(Line line1,Line line2) { 
			Point intersect = InfiniteLine.getIntersection(line1, line2);
			if (!line1.containsPoint(intersect) || !line2.containsPoint(intersect)){
				return null;
			}else{
				return intersect;
			}
		}
		
		
		/**
		 * Creates a Line from an InfiniteLine instance.
		 * 
		 * @param	line	InfiniteLine
		 * @param	range	Distance between both ends of the returned Line and the x-intersection of the InfiniteLine. Consequently, the returned Line instance its length will be twice the value of the range parameter.
		 * 
		 * @see		InfiniteLine
		 * @see		InfiniteLine#xIntersection
		 * 
		 * @return	Line.
		 */
		 static  Line createFromInfinite(InfiniteLine line,[num range=100]) {
			Point point1;
			Point point2;
			if (!line.horizontal){
				point1 = new Point(line.xIntersection, 0);
				point2 = new Point(line.xIntersection+1, line.xCoefficient);
			}else{
				point1 = new Point(0, line.yIntersection);
				point2 = new Point(line.yCoefficient, line.yIntersection+1);
			}
			num angle = line.getAngle();
			// calculate ends:
			Line newLine = new Line();
			newLine.a = new Point(point1.x + range * cos(angle), point1.y + range * sin(angle));
			angle += PI;
			newLine.b = new Point(point1.x + range * cos(angle), point1.y + range * sin(angle));
			// return value:
			return newLine;
		}
		
		/**
		 * Returns an List if which the first index and second (0 and 1) indexes are (the as respectively) Line its first and second Points (a and b).
		 * 
		 * @return	List
		 */
		  List toList() {
			return [this.a, this.b];
		}
		/**
		 * The String representation of this Line instance.
		 * 
		 * @return	String
		 */
		@override 
		  String toString() {
			return "Line(("+this.a.x+","+this.a.y+")->("+this.b.x+","+this.b.y+"))";
		}
		
		
		/**
		 * Sets both ends of this Line instance equal to the values of the respective parameter values. This method does nothing more than setting the values of the a and b properties.
		 * 
		 * @param	a	Line's first Point.
		 * @param	b	Line's second Point.
		 * 
		 * @see		Line#a
		 * @see		Line#b
		 * 
		 */
		@override 
		  void syncToPoints(Point a,Point b) {
			this.a = a;
			this.b = b;
		}
		
		
		/**
		 * Returns a cloned instance of this Line.
		 * 
		 * @return	Line
		 */
		@override 
		  dynamic clone() {
			return new Line(this.a, this.b);
		}
		
		
		/**
		 * Returns true if the provided coordinate is on this Line.
		 * 
		 * @param	point	Point instance representing a coordinate.
		 * @param	round	bool indicating whether or not to round values before making equations.
		 * 
		 * @see		Line#containsLine()
		 * 
		 * @returns	bool
		 */
		@override 
		  bool containsPoint(Point point,[bool round=true]) {
	 		// coordinate can't be on this Line if both Points in this Line are on one side of the coordinate:
			if ((point.x < this.a.x && point.x < this.b.x) || (point.x > this.a.x && point.x > this.b.x) || 
				(point.y < this.a.y && point.y < this.b.y) || (point.y > this.a.y && point.y > this.b.y) ){
				return false;
			}
			// invoke super:
			return super.containsPoint(point, round);
		}
		/**
		 * Returns true if the provided Line is in this Line. Note that true is only returned if both Points of the provided Line instance are on this Line.
		 * 
		 * @param	line	Line
		 * @param	round	bool indicating whether or not to round values before making equations.
		 * 
		 * @see		Line#containsLinePartially()
		 * @see		Line#containsPoint()
		 * @see		Line#equals()
		 * @see		InfiniteLine#isParallelTo()
		 * 
		 * @returns	bool
		 */
		  bool containsLine(Line line,[bool round=true]) {
			return (this.containsPoint(line.a, round) && this.containsPoint(line.b, round));
		}
		/**
		 * Returns true if the provided Line is partially in this Line.
		 * 
		 * @param	line	Line
		 * @param	round	bool indicating whether or not to round values before making equations.
		 * 
		 * @see		Line#containsLine()
		 * @see		Line#containsPoint()
		 * @see		Line#equals()
		 * @see		InfiniteLine#isParallelTo()
		 * 
		 * @returns	bool
		 */
		  bool containsLinePartially(Line line,[bool round=true]) {
			return ((this.containsPoint(line.a, round) || this.containsPoint(line.b, round)) && this.xCoefficient == line.xCoefficient);
		}
		
		
		/**
		 * Returns true if the provided Line instance is equal to this Line.
		 * 
		 * @param	line	Line
		 * @param	round	bool indicating whether or not to round values before making equations.
		 * 
		 * @see		Line#containsLine()
		 * @see		InfiniteLine#isParallelTo()
		 * 
		 * @return	bool
		 */
	 	@override 
		  bool equals(InfiniteLine line,[bool round=true]) {
			if (line is Line){
				Line castLine = (line);
				Point a1 = (round) ? SuperPoint.round(this.a) : this.a;
				Point b1 = (round) ? SuperPoint.round(this.b) : this.b;
				Point a2 = (round) ? SuperPoint.round(castLine.a) : castLine.a;
				Point b2 = (round) ? SuperPoint.round(castLine.b) : castLine.b;
				return ((a1 == (a2) && b1 == (b2)) || (a1 == (b2) && b1 == (a2)));
			}else{
				return super == (line);
			}
		}
		
		
		/**
		 * The outcome of Point B its x-position minus Point A its x-position.
		 * @see	Line#diffY
		 */
		  num get diffX {
			return this.b.x - this.a.x;
		}
		/**
		 * The outcome of Point B its y-position minus Point A its y-position.
		 * @see	Line#diffY
		 */
		  num get diffY {
			return this.b.y - this.a.y;
		}
		
		
		/**
		 * The exact center of the first and second Points of this Line.
		 */
		  Point get middle {
			return Point.interpolate(this.a, this.b, 0.5);
		}
		
		
		/**
		 * Line's first Point.
		 */
		  Point get a {
			return this._a;
		}
		  void set a(Point point) {
			this._a = point;
			super.syncToPoints(this.a, this.b);
		}
		
		
		/**
		 * Line's second Point.
		 */
		  Point get b {
			return this._b;
		}
		  void set b(Point point) {
			this._b = point;
			super.syncToPoints(this.a, this.b);
		}
		
		
		/**
		 * @inheritdoc
		 * @see	InfiniteLine#xIntersection
		 */
		@override 
		  num get xIntersection {
			return super.xIntersection;
		}
		@override 
		  void set xIntersection(num value) {
			this._a.x += value - this._xIntersection;
			this._b.x += value - this._xIntersection;
			this.setXIntersection(value);
		}
		/**
		 * @inheritdoc
		 * @see	InfiniteLine#yIntersection
		 */
		@override 
		  num get yIntersection {
			return super.yIntersection;
		}
		@override 
		  void set yIntersection(num value) {
			this._a.y += value - this._yIntersection;
			this._b.y += value - this._yIntersection;
			this.setYIntersection(value);
		}
		
		
		/**
		 * @inheritdoc
		 * @see	InfiniteLine#xCoefficient
		 */
		@override 
		  num get xCoefficient {
			return super.xCoefficient;
		}
		@override 
		  void set xCoefficient(num value) {
			// remember distances between both ends and the intersection with the x-axis:
			Point xIntersect = new Point(this.xIntersection, 0);
			num dist1 = Point.distance(this.a, xIntersect);
			num dist2 = Point.distance(this.b, xIntersect);
			// set property:
			this.setXCoefficient(value);
			// reposition both ends of this Line:
			num angle = this.getAngle();
			angle += PI;
			this._a = new Point(xIntersect.x + dist1 * cos(angle), xIntersect.y + dist1 * sin(angle));
			angle += PI;
			this._b = new Point(xIntersect.x + dist2 * cos(angle), xIntersect.y + dist2 * sin(angle));
		}
		
		
		/**
		 * @inheritdoc
		 * @see	InfiniteLine#yCoefficient
		 */
		@override 
		  num get yCoefficient {
			return super.yCoefficient;
		}
		@override 
		  void set yCoefficient(num value) {
			// remember distances between both ends and the intersection with the x-axis:
			Point xIntersect = new Point(this.xIntersection, 0);
			num dist1 = Point.distance(this.a, xIntersect);
			num dist2 = Point.distance(this.b, xIntersect);
			// set property:
			this.setYCoefficient(value);
			// reposition both ends of this Line:
			num angle = this.getAngle();
			angle += PI;
			this._a = new Point(xIntersect.x + dist1 * cos(angle), xIntersect.y + dist1 * sin(angle));
			angle += PI;
			this._b = new Point(xIntersect.x + dist2 * cos(angle), xIntersect.y + dist2 * sin(angle));
		}
		
		
	}
	
	
