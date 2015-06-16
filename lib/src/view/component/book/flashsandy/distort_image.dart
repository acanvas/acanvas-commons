 part of stagexl_commons;
	
	
	
	
	/**
	 * Tesselates an area into several triangles to allow free transform distortion on BitmapData objects.
	 * 
	 * @author		Thomas Pfeiffer (aka kiroukou)
	 * 				kiroukou@gmail.com
	 * 				www.flashsandy.org
	 * @author		Ruben Swieringa
	 * 				ruben.swieringa@gmail.com
	 * 				www.rubenswieringa.com
	 * 				www.rubenswieringa.com/blog
	 * @version		1.1.0
	 * 
	 * 
	 * edit 2
	 * 
	 * The original Actionscript2.0 version of the class was written by Thomas Pfeiffer (aka kiroukou),
	 *   inspired by Andre Michelle (andre-michelle.com).
	 *   Ruben Swieringa rewrote Thomas Pfeiffer's class in Actionscript3.0, making some minor changes/additions.
	 * 
	 * 
	 * Copyright (2005 as c) Thomas PFEIFFER. All rights reserved.
	 * 
	 * Licensed under the CREATIVE COMMONS Attribution-NonCommercial-ShareAlike 2.0 you may not use this
	 *   file except in compliance with the License. You may obtain a copy of the License at: dynamic   http://creativecommons.org/licenses/by-nc-sa/2.0/fr/deed.en_GB
	 * 
	 */
	 class DistortImage {
		
		
		// skew and translation matrix:
		/**
		 * @
		 */
		 Matrix _sMat, _tMat;
		/**
		 * @
		 */
		 num _xMin, _xMax, _yMin, _yMax;
		/**
		 * @
		 */
		 int _hseg, _vseg;
		/**
		 * @
		 */
		 num _hsLen, _vsLen;
		/**
		 * @
		 */
		 List _p;
		/**
		 * @
		 */
		 List _tri;
		
		// internals for accessors:
		/**
		 * @
		 */
		 num _w, _h;
		
		
		// plain  properties
		 /**
		 * Indicates whether or not use pixelsmoothing in the beginBitmapFill method of the Graphics class.
		 * @default	true
		 */
		 bool smoothing = true;
		
		
		/**
		 * Constructor.
		 * 
		 * @param	w		Width of the image to be processed
		 * @param	h		Height of image to be processed
		 * @param	hseg	Horizontal precision
		 * @param	vseg	Vertical precision
		 * 
		 */
		  DistortImage(num w,num h,[int hseg=2, int vseg=2]) {
			_w = w;
			_h = h;
			_vseg = vseg;
			_hseg = hseg;
			__init();
		}
		
		
		/**
		 * Tesselates the area into triangles.
		 * 
		 * @
		 */
		  void __init() {
			_p = new List();
			_tri = new List();
			num ix;
			num iy;
			num w2 = _w / 2;
			num h2 = _h / 2;
			_xMin = _yMin = 0;
			_xMax = _w; _yMax = _h;
			_hsLen = _w / ( _hseg + 1 );
			_vsLen = _h / ( _vseg + 1 );
			num x, y;
			// create points:
			for ( ix = 0 ; ix <_vseg + 2 ; ix++ ){
				for ( iy = 0 ; iy <_hseg + 2 ; iy++ ){
					x = ix * _hsLen;
					y = iy * _vsLen;
					_p.add( { "x": x, "y": y, "sx": x, "sy": y } );
				}
			}
			// create triangles:
			for ( ix = 0 ; ix <_vseg + 1 ; ix++ ){
				for ( iy = 0 ; iy <_hseg + 1 ; iy++ ){
					_tri.add([ _p[ iy + ix * ( _hseg + 2 ) ] , _p[ iy + ix * ( _hseg + 2 ) + 1 ] , _p[ iy + ( ix + 1 ) * ( _hseg + 2 ) ] ] );
					_tri.add([ _p[ iy + ( ix + 1 ) * ( _hseg + 2 ) + 1 ] , _p[ iy + ( ix + 1 ) * ( _hseg + 2 ) ] , _p[ iy + ix * ( _hseg + 2 ) + 1 ] ] );
				}
			}
		}
		
		
		/**
		 * Distorts the provided BitmapData according to the provided Point instances and draws it onto the provided Graphics.
		 * 
		 * @param	graphics	Graphics on which to draw the distorted BitmapData
		 * @param	bmd			The undistorted BitmapData
		 * @param	tl			Point specifying the coordinates of the top-left corner of the distortion
		 * @param	tr			Point specifying the coordinates of the top-right corner of the distortion
		 * @param	br			Point specifying the coordinates of the bottom-right corner of the distortion
		 * @param	bl			Point specifying the coordinates of the bottom-left corner of the distortion
		 * 
		 */
		  void setTransform(Graphics graphics,BitmapData bmd,Point tl,Point tr,Point br,Point bl) {
			
			num dx30 = bl.x - tl.x;
			num dy30 = bl.y - tl.y;
			num dx21 = br.x - tr.x;
			num dy21 = br.y - tr.y;
			num l = _p.length;
			while( --l> -1 ){
			  Map point = _p[ l ];
				num gx = ( point["x"] - _xMin ) / _w;
				num gy = ( point["y"] - _yMin ) / _h;
				num bx = tl.x + gy * ( dx30 );
				num by = tl.y + gy * ( dy30 );
				point["sx"] = bx + gx * ( ( tr.x + gy * ( dx21 ) ) - bx );
				point["sy"] = by + gx * ( ( tr.y + gy * ( dy21 ) ) - by );
			}
			__render(graphics, bmd);
		}
		
		
		/**
		 * Distorts the provided BitmapData and draws it onto the provided Graphics.
		 * 
		 * @param	graphics	Graphics
		 * @param	bmd			BitmapData
		 * 
		 * @
		 */
		  void __render(Graphics graphics,BitmapData bmd) {
			num t;
			List vertices;
			/*Object*/Map p0, p1, p2;
			_tMat = new Matrix.fromIdentity();
			_sMat = new Matrix.fromIdentity();
			List a;
			num l = _tri.length;
			while( --l> -1 ){
				a = _tri[ l ];
				p0 = a[0];
				p1 = a[1];
				p2 = a[2];
				num x0 = p0["sx"];
				num y0 = p0["sy"];
				num x1 = p1["sx"];
				num y1 = p1["sy"];
				num x2 = p2["sx"];
				num y2 = p2["sy"];
				num u0 = p0["x"];
				num v0 = p0["y"];
				num u1 = p1["x"];
				num v1 = p1["y"];
				num u2 = p2["x"];
				num v2 = p2["y"];
				
				_tMat.tx = u0;
				_tMat.ty = v0;
				_tMat.a = ( u1 - u0 ) / _w;
				_tMat.b = ( v1 - v0 ) / _w;
				_tMat.c = ( u2 - u0 ) / _h;
				_tMat.d = ( v2 - v0 ) / _h;
				
				_sMat.a = ( x1 - x0 ) / _w;
				_sMat.b = ( y1 - y0 ) / _w;
				_sMat.c = ( x2 - x0 ) / _h;
				_sMat.d = ( y2 - y0 ) / _h;
				_sMat.tx = x0;
				_sMat.ty = y0;
				
				_tMat.invert();
				_tMat.concat( _sMat );
				// draw:
				graphics.moveTo( x0, y0 );
				graphics.lineTo( x1, y1 );
				graphics.lineTo( x2, y2 );
				graphics.fillPattern(new GraphicsPattern.noRepeat(bmd.renderTextureQuad, _tMat /*smoothing*/));
			}
		}
		
		
		/**
		 * Sets the size of this DistortImage instance and re-initializes the triangular grid.
		 * 
		 * @param	width	New width.
		 * @param	height	New height.
		 * 
		 * @see	DistortImage#width
		 * @see	DistortImage#height
		 * 
		 */
		  void setSize(num width,num height) {
			this._w = width;
			this._h = height;
			this.__init();
		}
		
		
		/**
		 * Sets the precision of this DistortImage instance and re-initializes the triangular grid.
		 * 
		 * @param	horizontal	New horizontal precision.
		 * @param	vertical	New vertical precision.
		 * 
		 * @see	DistortImage#hPrecision
		 * @see	DistortImage#vPrecision
		 * 
		 */
		  void setPrecision(num horizontal,num vertical) {
			this._hseg = horizontal;
			this._vseg = vertical;
			this.__init();
		}
		
		
		/**
		 * Width of this DistortImage instance. Property can only be set through the class constructor.
		 * @see	DistortImage#setSize()
		 */
		  num get width {
			return _w;
		}
		/**
		 * Height of this DistortImage instance. Property can only be set through the class constructor.
		 * @see	DistortImage#setSize()
		 */
		  num get height {
			return _h;
		}
		
		
		/**
		 * Horizontal precision of this DistortImage instance. Property can only be set through the class constructor.
		 * @see	DistortImage#setPrecision()
		 */
		  int get hPrecision {
			return _hseg;
		}
		/**
		 * Vertical precision of this DistortImage instance. Property can only be set through the class constructor.
		 * @see	DistortImage#setPrecision()
		 */
		  int get vPrecision {
			return _vseg;
		}
		
		
	}
	
	
