part of rockdot_commons;

/**
 * All-static class providing functionality for making basic geometric calculations.
 *
 * @author		Ruben Swieringa
 * 				ruben.swieringa@gmail.com
 * 				www.rubenswieringa.com
 * 				www.rubenswieringa.com/blog
 * @version		1.0.0
 *
 *
 * edit 9b*
 *
 * * This class is a slightly stripped-down version of the original Geom class (the unfinished methods isClockwise() and trim() have been removed)
 *
 * Before modifying and/or redistributing this class, please contact Ruben Swieringa (ruben.swieringa@gmail.com).
 *
 *
 * View code documentation at: dynamic  http://www.rubenswieringa.com/code/as3/flex/Geom/docs/
 *
 */
class Geom {
  /**
   * String representation for top.
   */
  static final String TOP = "top";

  /**
   * String representation for left.
   */
  static final String LEFT = "left";

  /**
   * String representation for bottom.
   */
  static final String BOTTOM = "bottom";

  /**
   * String representation for right.
   */
  static final String RIGHT = "right";

  /**
   * String representation for top-left.
   */
  static final String TL = "topleft";

  /**
   * String representation for bottom-left.
   */
  static final String BL = "bottomleft";

  /**
   * String representation for bottom-right.
   */
  static final String BR = "bottomright";

  /**
   * String representation for top-right.
   */
  static final String TR = "topright";

  /**
   * @see	Geom#getHVLineIntersection()
   * @
   */
  static final String HORIZONTAL = "h";

  /**
   * @see	Geom#getHVLineIntersection()
   * @
   */
  static final String VERTICAL = "v";

  /**
   * Constructor.
   * @
   */
  Geom() {}

  /**
   * Calculates angle (in radians) between two Points.
   *
   * @param	point1	Point
   * @param	point2	Point
   *
   * @return	num
   *
   */
  static num getAngle(Point point1, Point point2) {
    return atan2(point2.y - point1.y, point2.x - point1.x);
  }

  /**
   * Takes a value and transforms it from degrees into radians.
   *
   * @param	radians	An angle in radians.
   *
   * @return	The angle in degrees.
   *
   * @see		Geom#radians()
   *
   */
  static num degrees(num radians) {
    return radians * 180 / PI;
  }

  /**
   * Takes a value and transforms it from radians into degrees.
   *
   * @param	degrees	An angle in degrees.
   *
   * @return	The angle in radians.
   *
   * @see		Geom#degrees()
   *
   */
  static num radians(num degrees) {
    return PI / 180 * degrees;
  }

  /**
   * Calculates the position of Point #2, which is positioned on a certain amount of pixels (radius parameter) from Point #1 (point parameter) at a certain angle (angle parameter).
   *
   * @param	point	Point #1.
   * @param	angle	The angle (in radians) that Point #2 makes with Point #1.
   * @param	radius	The distances between Point #1 and Point #2.
   *
   * @return	Point #2.
   */
  static Point getPointFromAngle(Point point, num angle, num radius) {
    num x = point.x + radius * cos(angle);
    num y = point.y + radius * sin(angle);
    return new Point(x, y);
  }

  /**
   * Indicates whether or not a Point is in a certain corner of a Rectangle.
   *
   * @param	rect		Rectangle who's area to inspect.
   * @param	point		Point of which to find out whether or not it is in the specified corner of rect.
   * @param	corner		Either Geom.TL, Geom.TR, Geom.BR, or Geom.BL.
   * @param	triangular	If true, the Rectangle is imaginary split in half diagonally before the calculations are conducted. If false, the method will use Rectangle corners instead of triangular ones.
   *
   * @see		Geom#TL
   * @see		Geom#TR
   * @see		Geom#BR
   * @see		Geom#BL
   *
   * @return	true if point is in the specified corner of rect.
   *
   */
  static bool isPointInCorner(Rectangle rect, Point point, String corner, [bool triangular = true]) {
    // if the value of the corner parameter is invalid, return false:
    if (corner != Geom.BL && corner != Geom.BR && corner != Geom.TL && corner != Geom.TR) {
      return false;
    }
    // if the Rectangle does not contain Point at all, return false:
    if (!rect.containsPoint(point)) {
      return false;
    }

    // find out whether or not the provided corner of Rectangle contains Point:
    if (triangular == true) {
      bool value;
      Point relativeMouse = new Point(point.x - rect.left, point.y - rect.top);
      // if we're working with an imaginary seperation-line going from top-right to bottom-left:
      if (relativeMouse.y * (rect.width / rect.height) > relativeMouse.x) {
        if (corner == Geom.BL) value = true;
        if (corner == Geom.TR) value = false;
      } else {
        if (corner == Geom.BL) value = false;
        if (corner == Geom.TR) value = true;
      }
      // if we're working with an imaginary seperation-line going from top-left to bottom-right:
      if (rect.width - (relativeMouse.y * (rect.width / rect.height)) > relativeMouse.x) {
        if (corner == Geom.TL) value = true;
        if (corner == Geom.BR) value = false;
      } else {
        if (corner == Geom.TL) value = false;
        if (corner == Geom.BR) value = true;
      }
      // return value:
      return value;
    } else {
      // create inner Rectangle describing the value of the corner parameter provided:
      Rectangle innerRect = rect.clone();
      if (corner == Geom.TR || corner == Geom.BR) innerRect.left = rect.left + rect.width / 2;
      if (corner == Geom.TL || corner == Geom.BL) innerRect.width = rect.width / 2;
      if (corner == Geom.TR || corner == Geom.TL) innerRect.height = rect.height / 2;
      if (corner == Geom.BR || corner == Geom.BR) innerRect.top = rect.left + rect.height / 2;
      // return value:
      return innerRect.containsPoint(point);
    }
  }

  /**
   * Returns an List of Points indicating where a Line intersects with a Rectangle.
   * This method loops through all sides (of as Lines) a Rectangle and stores intersections in the returned List.
   * Note that instead of looking up (for instance) the bottom intersection by using 2 as an index value om the returned List, you can also use the BOTTOM constant of the SuperRectangle class. Needless to say, the same goes for the TOP, RIGHT, and LEFT constants of the SuperRectangle class.
   *
   * @param	line		A Line instance.
   * @param	rect		A Rectangle instance.
   * @param	includeNull	When set to true non-intersections values (when the getHVLineIntersection method returns null) are also inserted into the returned List. This might come in handy when you want to find out where an intersection from the List occured, the first value in the List (0) is actually the returned intersection with the top side of the Rectangle, the second (1) is the intersection with the right side of the Rectangle, and so forth. This parameter defaults to false.
   *
   * @see		Geom#getHLineIntersection()
   * @see		Geom#getVLineIntersection()
   * @see		Line
   * @see		SuperRectangle
   * @see		SuperRectangle#TOP
   * @see		SuperRectangle#RIGHT
   * @see		SuperRectangle#BOTTOM
   * @see		SuperRectangle#LEFT
   *
   * @return	List
   */
  static List getRectIntersections(Line line, Rectangle rect, [bool includeNull = false]) {
    List intersections = [];
    List lines = SuperRectangle.createSuperRectangle(rect).getLines();
    Point intersection;
    for (int i = 0; i < lines.length; i++) {
      intersection = Line.getIntersection(line, lines[i]);
      if (intersection != null || includeNull) {
        intersections.add(intersection);
      }
    }
    return intersections;
  }

  /**
   * Indicates whether or not two Points are in such a position on a SuperRectangle its border that they need extra inbetween Points to describe the inbetween path from one to another along the SuperRectangle its border. This method is typically used by the trim method.
   *
   * @see	Geom#trim()
   *
   * @
   */
  static bool needsCorners(Map point1, Map point2, SuperRectangle rect) {
    if (point1["isOriginal"] != point2["isOriginal"]) {
      Map one = (point1["isOriginal"]) ? point2 : point1;
      Map two = (point2["isOriginal"]) ? point2 : point1;
      if (!one["parent"].a.equals(two["point"]) && !one["parent"].b.equals(two["point"])) {
        return true;
      }
    }

    if (!point1["isOriginal"] && !point2["isOriginal"]) {
      if (!point1["parent"].equals(point2["parent"])) {
        if (rect.isOnSide(point1["point"]) != rect.isOnSide(point2["point"])) {
          return true;
        }
        if (rect.isOnSide(point1["point"]) == rect.isOnSide(point2["point"])) {
          switch (rect.isOnSide(point1["point"])) {
            case SuperRectangle.NONE:
              return true;
            case SuperRectangle.TOP:
              if (point2["point"].x < point1["point"].x) return true;
              break;
            case SuperRectangle.RIGHT:
              if (point2["point"].y < point1["point"].y) return true;
              break;
            case SuperRectangle.BOTTOM:
              if (point2["point"].x > point1["point"].x) return true;
              break;
            case SuperRectangle.LEFT:
              if (point2["point"].y > point1["point"].y) return true;
              break;
          }
        }
      }
    }

    return false;
  }

  /**
   * Returns the List index of the Point that is the nearest to a given coordinate.
   *
   * @param	area	An List consisting of Points.
   * @param	point	Point for which to look up the nearest coordinate.
   *
   * @return	Index of the nearest Point. Returns -1 if no Point instance was found in the provided List.
   */
  static int getNearest(List area, Point point) {
    int nearest = -1;
    for (int i = 0; i < area.length; i++) {
      if (area[i] == null || !(area[i] is Point)) {
        continue;
      }
      if (nearest == -1 || Point.distance(area[i], point) < Point.distance(area[nearest], point)) {
        nearest = i;
      }
    }
    return nearest;
  }

  /**
   * Returns the coordinates of a star shape.
   *
   * @param	radius		The radius of the outer corners of the star.
   * @param	center		Center of the star.
   * @param	rotation	Rotation (of as radians) the star.
   * @param	points		Amount of points (outer corners) that the star has. Defaults to 5.
   *
   * @returns	List of Points.
   */
  static List star(num radius, Point center, [num rotation = 0, int points = 5]) {
    List area = [];
    num angle = (PI * 2) / (points * 2);
    rotation -= PI / 2;
    for (int i = 0; i < points; i++) {
      area.add(Geom.getPointFromAngle(center, rotation + angle * (i * 2), radius));
      area.add(Geom.getPointFromAngle(center, rotation + angle * (i * 2 + 1), radius / 2));
    }
    return area;
  }
}
