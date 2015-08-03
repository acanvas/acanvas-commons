part of stagexl_commons;


/**
 * Describes a line consisting of a slope (and as coefficient) an intersection-point with either the x or y axis.
 *
 * @author		Ruben Swieringa
 * 				ruben.swieringa@gmail.com
 * 				www.rubenswieringa.com
 * 				www.rubenswieringa.com/blog
 * @version		1.0.0
 *
 *
 * edit 3
 *
 * Before modifying and/or redistributing this class, please contact Ruben Swieringa (ruben.swieringa@gmail.com).
 *
 *
 * View code documentation at: dynamic  http://www.rubenswieringa.com/code/as3/flex/Geom/docs/
 *
 */
class InfiniteLine {


  /**
   * @
   */
  num _xIntersection = 0;

  /**
   * @
   */
  num _yIntersection = 0;

  /**
   * @
   */
  num _xCoefficient = 1;

  /**
   * @
   */
  static final int ROUND = 100;


  /**
   * Constructor.
   *
   * @param	xIntersection
   * @param	xCoefficient
   *
   * @see		InfiniteLine#xIntersection
   * @see		InfiniteLine#xCoefficient
   * @see		InfiniteLine#yIntersection
   * @see		InfiniteLine#yCoefficient
   *
   */
  InfiniteLine([num xIntersection=0, num xCoefficient=1]) {
    this.setXCoefficient(xCoefficient);
    this.setXIntersection(xIntersection);
  }


  /**
   * Returns a Point instance that represents the coordinate at which two InfiniteLine instances intersect.
   * Many thanks to Arno van Oordt for taking the time to explain the concept of intersection to me, check out his blog at http://blog.justgreat.nl
   *
   * @internal	Note that the below code is actually a slightly modified version of the intersection method from a class Arno wrote some time ago.
   *
   * @param	line1	InfiniteLine
   * @param	line2	InfiniteLine
   *
   * @return	A Point instance if intersections occurs, null of otherwise.
   */
  static Point getIntersection(InfiniteLine line1, InfiniteLine line2) {

    if (line1.horizontal) return line2.getPointByY(line1.yIntersection);
    if (line1.vertical) return line2.getPointByX(line1.xIntersection);
    if (line2.horizontal) return line1.getPointByY(line2.yIntersection);
    if (line2.vertical) return line1.getPointByX(line2.xIntersection);

    num lengthA = (line2.yIntersection - line1.yIntersection).abs();
    num lengthB;
    num lengthC;

    num arcB;
    num arcC;
    num arcA;
    if (line1.yIntersection > line2.yIntersection) {
      arcB = (PI / 2 + line1.getAngle()).abs();
      arcC = (PI / 2 - line2.getAngle()).abs();
    } else {
      arcB = (PI / 2 - line1.getAngle()).abs();
      arcC = (PI / 2 + line2.getAngle()).abs();
    }
    arcA = PI - arcB - arcC;

    num ratio = sin(arcA) / lengthA;
    lengthB = sin(arcB) / ratio;
    lengthC = sin(arcC) / ratio;

    num x = sin(arcC) * lengthB;

    return line1.getPointByX(x);
  }


  /**
   * Creates an InfiniteLine at the hand of two Points.
   *
   * @param	a	Point
   * @param	b	Point
   *
   * @see		InfiniteLine#syncToPoints()
   *
   * @return	InfiniteLine
   */
  static InfiniteLine createFromPoints(Point a, Point b) {
    InfiniteLine line = new InfiniteLine();
    line.syncToPoints(a, b);
    return line;
  }


  /**
   * Returns a cloned instance of this InfiniteLine.
   *
   * @return	InfiniteLine
   */
  dynamic clone() {
    InfiniteLine line = new InfiniteLine(this.xIntersection, this.xCoefficient);
    line.yIntersection = this.yIntersection;
    return line;
  }


  /**
   * The String representation of this InfiniteLine instance.
   *
   * @return	String
   */
  String toString() {
    return "InfiniteLine(xIntersection=${this.xIntersection}, xCoefficient=${this.xCoefficient})";
  }


  /**
   * Synchronizes this InfiniteLine instance to contain two Points.
   *
   * @param	a	First Point.
   * @param	b	Second Point.
   *
   */
  void syncToPoints(Point a, Point b) {
    Point point1;
    Point point2;
    // calculate coefficient:
    point1 = (a.x < b.x) ? a : b;
    point2 = (a.x > b.x) ? a : b;
    this.setXCoefficient((b.y - a.y) / (b.x - a.x));
    // calculate intersection:
    point1 = (a.y < b.y) ? a : b;
    point2 = (a.y > b.y) ? a : b;
    this.setXIntersection(point2.x - (point2.y / (point2.y - point1.y)) * (point2.x - point1.x));
    // don't lose yIntersection:
    if (this.horizontal) {
      this.setYIntersection(a.y);
    }
  }


  /**
   * Creates an InfiniteLine instance at the hand of an x-intersection and an x-coefficient. Note that this method is exactly the same as the class its constructor.
   *
   * @param	xIntersection	x-position of this InfiniteLine's intersection-point with the x-axis.
   * @param	xCoefficient	x-coefficient.
   *
   * @see		InfiniteLine#createFromY()
   * @see		InfiniteLine#xIntersection
   * @see		InfiniteLine#xCoefficient
   *
   * @return	InfiniteLine
   */
  static InfiniteLine createFromX(num xIntersection, num xCoefficient) {
    return new InfiniteLine(xIntersection, xCoefficient);
  }

  /**
   * Creates an InfiniteLine instance at the hand of an y-intersection and an y-coefficient.
   *
   * @param	xIntersection	y-position of this InfiniteLine's intersection-point with the y-axis.
   * @param	xCoefficient	y-coefficient.
   *
   * @see		InfiniteLine#createFromX()
   * @see		InfiniteLine#yIntersection
   * @see		InfiniteLine#yCoefficient
   *
   * @return	InfiniteLine
   */
  static InfiniteLine createFromY(num yIntersection, num yCoefficient) {
    InfiniteLine line = new InfiniteLine();
    line.yIntersection = yIntersection;
    line.yCoefficient = yCoefficient;
    return line;
  }


  /**
   * Returns the angle of this InfiniteLine with the x-axis.
   *
   * @return	Angle in radians.
   */
  num getAngle() {
    if (this.horizontal) return 0;
    if (this.vertical) return PI / 2;
    Point point1 = new Point(this.xIntersection, 0);
    Point point2 = new Point(this.xIntersection + 1, this.xCoefficient);
    return atan2(point2.y - point1.y, point2.x - point1.x);
  }


  /**
   * Return a Point on this InfiniteLine where the x-position equals the specified value.
   *
   * @see		InfiniteLine#getPointByY()
   *
   * @return	Point
   */
  Point getPointByX(num x) {
    num y = (this.horizontal) ? this.yIntersection : this.yIntersection + x * this.xCoefficient;
    return new Point(x, y);
  }

  /**
   * Return a Point on this InfiniteLine where the y-position equals the specified value.
   *
   * @see		InfiniteLine#getPointByX()
   *
   * @return	Point
   */
  Point getPointByY(num y) {
    num x = (this.vertical) ? this.xIntersection : this.xIntersection + y * this.yCoefficient;
    return new Point(x, y);
  }


  /**
   * Returns true if the provided Point is on this InfiniteLine.
   *
   * @param	point	Point instance representing a coordinate.
   * @param	round	bool indicating whether or not to round values before making equations.
   *
   * @see		InfiniteLine#contains()
   *
   * @returns	bool
   */
  bool containsPoint(Point point, [bool round=true]) {
    num value1;
    num value2;
    // single-axis equation for horizontal and vertical Lines:
    if (this.horizontal) {
      value1 = point.y;
      value2 = this.yIntersection;
    }
    if (this.vertical) {
      value1 = point.x;
      value2 = this.xIntersection;
    }
    // otherwise calculate by slope of this Line:
    if (!this.horizontal && !this.vertical) {
      value1 = (point.x - this.xIntersection) * this.xCoefficient;
      value2 = point.y;
    }
    // round if necessary:
    if (round != null || round == true) {
      value1 = (value1).round();
      value2 = (value2).round();
    }
    // return value:
    return (value1 == value2);
  }


  /**
   * Returns true if the provided InfiniteLine instance is parallel to this InfiniteLine.
   *
   * @param	line	InfiniteLine
   * @param	round	bool indicating whether or not to round values before making equations.
   *
   * @return	bool
   */
  bool isParallelTo(InfiniteLine line, [bool round=true]) {
    num value1 = this.xCoefficient;
    num value2 = line.xCoefficient;
    if (round != null || round == true) {
      value1 = (value1 * InfiniteLine.ROUND).round() / InfiniteLine.ROUND;
      value2 = (value2 * InfiniteLine.ROUND).round() / InfiniteLine.ROUND;
    }
    return (value1 == value2);
  }

  /**
   * Returns true if the intersection-points and coefficients of both InfiniteLine instances are equal.
   *
   * @param	line	InfiniteLine
   * @param	round	bool indicating whether or not to round values before making equations.
   *
   * @return	bool
   */
  bool equals(InfiniteLine line, [bool round=true]) {
    num value1 = this.xIntersection;
    num value2 = line.xIntersection;
    num value3 = this.yIntersection;
    num value4 = line.yIntersection;
    if (round != null || round == true) {
      value1 = (value1).round();
      value2 = (value2).round();
      value3 = (value3).round();
      value4 = (value4).round();
    }
    return (this.isParallelTo(line) && (value1 == value2 || value3 == value4));
  }


  /**
   * Indicates whether or not this InfiniteLine instance is horizontal.
   * @see	InfiniteLine#vertical
   */
  bool get horizontal {
    return (this.xCoefficient == 0);
  }

  void set horizontal(bool value) {
    if (this.horizontal == value) {
      return;
    }
    if (value != null || value == true) {
      this.setXCoefficient(0);
    } else {
      this.setXCoefficient(1);
    }
  }

  /**
   * Indicates whether or not this InfiniteLine instance is vertical.
   * @see	InfiniteLine#horizontal
   */
  bool get vertical {
    return (this.yCoefficient == 0);
  }

  void set vertical(bool value) {
    if (this.vertical == value) {
      return;
    }
    if (value != null || value == true) {
      this.yCoefficient = (this.yCoefficient >= 0) ? double.INFINITY : double.NEGATIVE_INFINITY;
    } else {
      this.yCoefficient = 1;
    }
  }


  /**
   * The x-position of the coordinate where this InfiniteLine crosses the x-axis (and consequently the y-position will be equal to zero).
   * @see	InfiniteLine#xCoefficient
   * @see	InfiniteLine#yCoefficient
   * @see	InfiniteLine#yIntersection
   */
  num get xIntersection {
    return this._xIntersection;
  }

  void set xIntersection(num value) {
    this.setXIntersection(value);
  }

  /**
   * Sets the value of the internal for the xIntersection property.
   * This method is used internally by the InfiniteLine class and its subclasses, whereas outer classes use the  accompanying setter-method.
   * Where the getter methods sometimes also synchronize properties to eachother (in subclasses), this method is purely for setting its own internal property.
   * @see	InfiniteLine#xIntersection
   * @
   */
  void setXIntersection(num value) {
    this._xIntersection = value;
    this._yIntersection = -value * this.xCoefficient;
  }


  /**
   * The y-position of the coordinate where this InfiniteLine crosses the y-axis (and consequently the x-position will be equal to zero).
   * @see	InfiniteLine#xCoefficient
   * @see	InfiniteLine#xIntersection
   * @see	InfiniteLine#yCoefficient
   */
  num get yIntersection {
    return this._yIntersection;
  }

  void set yIntersection(num value) {
    this.setYIntersection(value);
  }

  /**
   * Sets the value of the internal for the yIntersection property.
   * This method is used internally by the InfiniteLine class and its subclasses, whereas outer classes use the  accompanying setter-method.
   * Where the getter methods sometimes also synchronize properties to eachother (in subclasses), this method is purely for setting its own internal property.
   * @see	InfiniteLine#yIntersection
   * @
   */
  void setYIntersection(num value) {
    this._yIntersection = value;
    this._xIntersection = -value / this.xCoefficient;
  }


  /**
   * Value with which the y-position of this InfiniteLine increases, relative to that with which the x-position increases.
   * @see	InfiniteLine#yCoefficient
   * @see	InfiniteLine#xIntersection
   * @see	InfiniteLine#yIntersection
   */
  num get xCoefficient {
    return this._xCoefficient;
  }

  void set xCoefficient(num value) {
    this.setXCoefficient(value);
  }

  /**
   * Sets the value of the internal for the xCoefficient property.
   * This method is used internally by the InfiniteLine class and its subclasses, whereas outer classes use the  accompanying setter-method.
   * Where the getter methods sometimes also synchronize properties to eachother (in subclasses), this method is purely for setting its own internal property.
   * @see	InfiniteLine#xCoefficient
   * @
   */
  void setXCoefficient(num value) {
    this._xCoefficient = value;
    this.setXIntersection(this.xIntersection);
  }


  /**
   * Value with which the x-position of this InfiniteLine increases, relative to that with which the y-position increases.
   * @see	InfiniteLine#xCoefficient
   * @see	InfiniteLine#xIntersection
   * @see	InfiniteLine#yIntersection
   */
  num get yCoefficient {
    return 1 / this.xCoefficient;
  }

  void set yCoefficient(num value) {
    this.setYCoefficient(value);
  }

  /**
   * Sets the value of the internal for the yCoefficient property.
   * This method is used internally by the InfiniteLine class and its subclasses, whereas outer classes use the  accompanying setter-method.
   * Where the getter methods sometimes also synchronize properties to eachother (in subclasses), this method is purely for setting its own internal property.
   * @see	InfiniteLine#yCoefficient
   * @
   */
  void setYCoefficient(num value) {
    this.setXCoefficient(1 / value);
  }


}
	
	
