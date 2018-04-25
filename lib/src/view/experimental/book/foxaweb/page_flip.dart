part of rockdot_commons;

/**
 * Computes, generates, and draws a pageflip.
 *
 * @notice	PageFlip drawer
 * @author	Foxy
 * @version	1.0
 * @date	2007-01-18
 *
 * Original author : dynamic -----------------
 * Didier Brun aka Foxy
 * webmaster@foxaweb.com
 * http://www.foxaweb.com
 *
 * 	AUTHOR * *****************************************************************************
 *
 * authorName : 	Didier Brun - www.foxaweb.com
 * 	contribution : 	the original class
 * 	date :			2007-01-18
 *
 * 	VISIT www.byteList.org
 *
 *
 * LICENSE ******************************************************************************
 *
 * 	This class is under RECIPROCAL PUBLIC LICENSE.
 * 	http://www.opensource.org/licenses/rpl.php
 *
 * 	Please, keep this header and the list of all authors
 *
 *
 *
 * Nomenclature
 * ------------
 *
 *    PT(0,0)                                           PT(1,0)
 *   ---------------------------------------------------
 *      |  <-------------------PW---------------------->  |
 *      | ^ Offset(0,0)  x-->					       |
 *      | |						                 |
 *      | | y                                             |
 *      | | |                                             |
 *      | | |                                             |
 *      | | V                                             |
 *      | |              pPoints[]                        |
 *      | |                                               |
 *      | |                                               |
 *      | |                                               |
 *      | |                                          (T3) |
 *      | PH                                           ---|
 *      | |                                         --- /
 *      | |                                      ---   /
 *      | |                                   ---     /
 *      | |                                ---       /
 *      | |                             ---         /
 *      | |                          ---           /
 *      | |                    PTD  --- cPoints[] /
 *      | |                         \            /
 *      | |                          \          /
 *      | |                           \        /
 *      | |                            \      /
 *      | |                             \    /
 *      | V                              \  /
 *      |-------------------------------- \/
 * PT(0,1)                                           PT(1,1)
 */
class PageFlip {
  // ------------------------------------------------
  //
  // ---o  static methods
  //
  // ------------------------------------------------

  /**
   * Compute and generate a new flip.
   *
   * @param	ptd		Point indicating the position of the PTD point (the drag one) relative to the upper-left corner.
   * @param	pt		Point indicating the original position of the dragged point. The two possible values for its x and y properties are 0 or 1. pt(0,0) is the upper-left corner, for example, pt (1,1) is the bottom-right one.
   * @param	pw		int indicating the sheet width in pixels.
   * @param	ph		int indicating the sheet height in pixels.
   * @param	ish		If true, horizontal mode is provided, if false, vertical.
   * @param	sens	num indicating the constraints sensibility. This parametter is a multiplicator for the constraints values. It's intended to prevent some awefull flickering effects. Its possible value is ranged between 0.9 and 1. 0.9 -> when ptd move is free (drag'n'drop), 1 -> when ptd move is progresive (tween when release). At best, you should never swap it from .9 to 1. A progressive incrementation is better. If flickering effects don't disturb you or if your ptd moves is coded, keep this parametter to 1.
   *
   * @return	Map containing:<br />
   * 				cPoints:List - List of points which describes the flipped part of the sheet. Note that in case of the ptd point is aligned with its original position or if the height of the shape is very small (<1) this array is set to null.<br />
   * 				pPoints:List - List of points wich describes the fixed part of the sheet.<br />
   * 				matrix:Matrix - Transformation matrix for the flipped part of the sheet.<br />
   * 				width:num - Sheet width.<br />
   * 				height:num - Sheet height.
   *
   */
  static Map<String, dynamic> computeFlip(Point ptd, Point pt, int pw, int ph, bool ish, int sens) {
    // useful vars
    num dfx = ptd.x - pw * pt.x;
    num dfy = ptd.y - ph * pt.y;
    Point spt = pt.clone();
    int opw = pw;
    int oph = ph;

    // offset corections
    num temp;

    // transform matrix
    Matrix mat = new Matrix.fromIdentity();

    if (!ish) {
      // size
      temp = pw;
      pw = ph;
      ph = temp.round();

      // ptd
      temp = ptd.x;
      ptd.x = ptd.y;
      ptd.y = temp;

      // pt
      temp = pt.x;
      spt.x = pt.y;
      spt.y = temp;
    }

    //	pt1 & pt2 are the two fixed points of the sheet. opposed to ptd drag one.
    Point pt1 = new Point(0, 0);
    Point pt2 = new Point(0, ph);

    // default points array
    // cPoints -> the fliped part
    List<Point<num>> cPoints = [new Point(0,0), new Point(0,0), new Point(0,0), new Point(0,0)];
    // pPoints -> the fixed part
    List<Point<num>> pPoints = [new Point(0, 0), new Point(pw, 0), null, null, new Point(0, ph)];

    // compute some flip
    flipDrag(ptd, spt, pw, ph);

    // ditstance
    // it allows you to have a valid position for ptd.
    // the limit is the diagonal of the sheet here
    limitPoint(ptd, pt1, (pw * pw + ph * ph) * sens);
    // the limit is about the opposite fixed point
    limitPoint(ptd, pt2, (pw * pw) * sens);

    // first fliped point
    cPoints[0] = new Point(ptd.x, ptd.y);

    num dy = pt2.y - ptd.y;
    num tot = pw - ptd.x - pt1.x;
    num drx = getDx(dy, tot);

    // fliped angle
    num theta = atan2(dy, drx);
    if (dy == 0) theta = 0;

    // another fliped angle
    num beta = pi / 2 - theta;
    num hyp = (pw - cPoints[0].x) / cos(beta);

    // vhyp is the hypotenuse of the fliped part
    num vhyp = hyp;
    // if hyp is greater than the height of the sheet or hyp is
    // negative, the fliped part has 4 points
    // else, it's just a 3 points part (simple corner).
    if (hyp > ph || hyp < 0) vhyp = ph;

    // second fliped point
    cPoints[1] = new Point(cPoints[0].x + cos(-beta) * vhyp, cPoints[0].y + sin(-beta) * vhyp);

    // last fliped point
    cPoints[3] = new Point(cPoints[0].x + drx, pt2.y);

    // if we have a 4 points shape
    if (hyp != vhyp) {
      dy = pt1.y - cPoints[1].y;
      tot = pw - cPoints[1].x;
      drx = getDx(dy, tot);

      //.add the before the last point
      cPoints[2] = new Point(cPoints[1].x + drx, pt1.y);

      // we can now find the fixed points of the sheet
      pPoints[1] = cPoints[2].clone();
      pPoints[2] = cPoints[3].clone();
      pPoints.removeAt(3);
    } else {
      // else we delete the point
      cPoints.removeAt(2);

      // we can now find the fixed points of the sheet
      pPoints[2] = cPoints[1].clone();
      pPoints[3] = cPoints[2].clone();
    }

    // these two polygons are always convex !

    // now we can flip the two arrays
    flipPoints(cPoints, spt, pw, ph);
    flipPoints(pPoints, spt, pw, ph);

    // if !ish (vertical mode)
    // we have to change the points orientation
    if (!ish) {
      oriPoints(cPoints, spt, pw, ph);
      oriPoints(pPoints, spt, pw, ph);
    }

    // flipped part transfrom matrix

    num gama = theta;

    if (pt.y == 0) gama = -gama;
    if (pt.x == 0) gama = pi + pi - gama;
    if (!ish) gama = pi - gama;

    mat.a = cos(gama);
    mat.b = sin(gama);
    mat.c = -sin(gama);
    mat.d = cos(gama);

    ordMatrix(mat, spt, opw, oph, ish, cPoints, pPoints, gama, beta);

    // here we fix some mathematical bugs or instabilities
    if (vhyp == 0) cPoints = null;
    if ((dfx).abs() < 1 && dfy.abs() < 1) cPoints = null;

    // now we just have to return all the stuff
    return <String, dynamic>{"cPoints": cPoints, "pPoints": pPoints, "matrix": mat, "width": opw, "height": oph};
  }

  /**
   * Draw a sheet using two Bitmap objects.
   *
   * @param	ocf			computeFlip() returned object
   * @param	mc			Target
   * @param	bmp0		First page bitmap (left-top aligned)
   * @param	bmp1		Second page bitmap (left-top aligned)
   *
   */
  static void drawBitmapSheet(Map ocf, Sprite mc, BitmapData bmp0, BitmapData bmp1) {
    // affectations
    int nb;
    List<Point<num>> ppts = ocf["pPoints"] as List<Point<num>>;
    List<Point<num>> cpts = ocf["cPoints"] as List<Point<num>>;

    // draw the fixed part
    nb = ppts.length;
    mc.graphics.beginPath();
    mc.graphics.moveTo(ppts[nb - 1].x, ppts[nb - 1].y);
    while (--nb >= 0) mc.graphics.lineTo(ppts[nb].x, ppts[nb].y);
    mc.graphics.fillPattern(new GraphicsPattern.noRepeat(bmp0.renderTextureQuad, new Matrix.fromIdentity()));
    mc.graphics.closePath();

    // draw the flipped part
    if (cpts == null) return;

    nb = cpts.length;
    mc.graphics.beginPath();
    mc.graphics.moveTo(cpts[nb - 1].x, cpts[nb - 1].y);
    while (--nb >= 0) mc.graphics.lineTo(cpts[nb].x, cpts[nb].y);
    mc.graphics.fillPattern(new GraphicsPattern.noRepeat(bmp1.renderTextureQuad, ocf["matrix"] as Matrix));
    mc.graphics.closePath();
  }

  // ------------------------------------------------
  //
  // ---o  static methods
  //
  // ------------------------------------------------

  /**
   * orientation correction
   * @
   */
  static void oriPoints(List<Point<num>> pts, Point po, num pw, num ph) {
    int nb = pts.length;
    num temp;

    while (--nb >= 0) {
      temp = pts[nb].x;
      pts[nb].x = pts[nb].y;
      pts[nb].y = temp;
    }
  }

  /**
   * ptdarg correction
   * @
   */
  static void flipDrag(Point ptd, Point po, num pw, num ph) {
    // flip y
    if (po.y == 0) ptd.y = ph - ptd.y;

    // flip x
    if (po.x == 0) ptd.x = pw - ptd.x;
  }

  /**
   * flip correction
   * @
   */
  static void flipPoints(List<Point<num>> pts, Point po, num pw, num ph) {
    int nb = pts.length;
    // flip
    if (po.y == 0 || po.x == 0) {
      while (--nb >= 0) {
        if (po.y == 0) pts[nb].y = ph - pts[nb].y;
        if (po.x == 0) pts[nb].x = pw - pts[nb].x;
      }
    }
  }

  /**
   * compute some trigonometry equation
   *
   * this one is more stable than Math.atan2 for our case
   *
   * @
   */
  static num getDx(num dy, num tot) {
    return (tot * tot - dy * dy) / (tot * 2);
  }

  /**
   * limit the ptdrag position
   * @
   */
  static void limitPoint(Point ptd, Point pt, num dsquare) {
    num theta;
    num lim;

    num dy = ptd.y - pt.y;
    num dx = ptd.x - pt.x;

    num dis = dx * dx + dy * dy;

    // we save some times using square
    if (dis > dsquare) {
      theta = atan2(dy, dx);
      lim = sqrt(dsquare);
      ptd.x = pt.x + cos(theta) * lim;
      ptd.y = pt.y + sin(theta) * lim;
    }
  }

  /**
   * matric correction
   * @
   */
  static void ordMatrix(Matrix mat, Point spt, num opw, num oph, bool ish, List<Point<num>> cPoints,
      List<Point<num>> pPoint, num gama, num beta) {
    if (spt.x == 1 && spt.y == 0) {
      mat.tx = cPoints[0].x;
      mat.ty = cPoints[0].y;
      if (!ish) {
        mat.tx = cPoints[0].x - cos(gama) * opw - cos(-beta) * oph;
        mat.ty = cPoints[0].y - sin(gama) * opw - sin(-beta) * oph;
      }
    }

    if (spt.x == 1 && spt.y == 1) {
      mat.tx = cPoints[0].x + cos(-beta) * oph;
      mat.ty = cPoints[0].y + sin(-beta) * oph;
      if (!ish) {
        mat.tx = cPoints[0].x + cos(-beta) * oph;
        mat.ty = cPoints[0].y - sin(-beta) * oph;
      }
    }

    if (spt.x == 0 && spt.y == 0) {
      mat.tx = cPoints[0].x - cos(gama) * opw;
      mat.ty = cPoints[0].y - sin(gama) * opw;
    }

    if (spt.x == 0 && spt.y == 1) {
      mat.tx = cPoints[0].x - cos(gama) * opw - cos(-beta) * oph;
      mat.ty = cPoints[0].y - sin(gama) * opw + sin(-beta) * oph;
      if (!ish) {
        mat.tx = cPoints[0].x;
        mat.ty = cPoints[0].y;
      }
    }
  }
}
