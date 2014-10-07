 part of stagexl_commons;
	
	
	
	
	/**
	 * Stores line-styles.
	 * 
	 * @author		Ruben Swieringa
	 * 				ruben.swieringa@gmail.com
	 * 				www.rubenswieringa.com
	 * 				www.rubenswieringa.com/blog
	 * @version		1.0.0
	 * @see			DrawingTool
	 * @see			http://livedocs.adobe.com/flex/2/langref/flash/display/Graphics.html#lineStyle()
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
	 class LineStyle {
		
		
		/**
		 * @
		 */
		 num _dash = 2;
		/**
		 * @
		 */
		 num _space = -1;
		/**
		 * @
		 */
		 num _thickness = 1;
		/**
		 * @
		 */
		 num _alpha = 1.0;
		/**
		 * @
		 */
		 String _scaleMode = "normal";
		/**
		 * @
		 */
		 String _caps;
		/**
		 * @
		 */
		 String _joints;
		/**
		 * @
		 */
		 num _miterLimit = 3;
		
		/**
		 * If true, the line this LineStyle instance is applied to will have a dashed line.
		 * @default	false
		 * @see		LineStyle#dash
		 * @see		LineStyle#space
		 */
		 bool dashEnabled = false;
		/**
		 * Line color.
		 * @default	0
		 */
		 int color = 0;
		/**
		 * A bool value that specifies whether to hint strokes to full pixels.
		 * @default	false
		 */
		 bool pixelHinting = false;
		
		/**
		 * @see		LineStyle#dash
		 * @
		 */
		 static const num MIN_DASH = 0.1;
		
		
		/**
		 * Constructor.
		 * 
		 * @see		LineStyle#thickness
		 * @see		LineStyle#color
		 * @see		LineStyle#alpha
		 * @see		LineStyle#pixelHinting
		 * @see		LineStyle#scaleMode
		 * @see		LineStyle#caps
		 * @see		LineStyle#joints
		 * @see		LineStyle#miterLimit
		 * 
		 * @see		http://livedocs.adobe.com/flex/2/langref/flash/display/Graphics.html#lineStyle()
		 */
		  LineStyle([num thickness=1, int color=0, num alpha=1.0, bool pixelHinting=false, String scaleMode="normal", String caps=null, String joints=null, num miterLimit=3]) {
			
			this.thickness = thickness;
			this.color = color;
			this.alpha = alpha;
			this.pixelHinting = pixelHinting;
			this.scaleMode = scaleMode;
			this.caps = caps;
			this.joints = joints;
			this.miterLimit = miterLimit;
			
		}
		
		
		/**
		 * An integer that indicates the thickness of the line in points; valid values are 0 to 255.
		 */
		  num get thickness {
			return this._thickness;
		}
		  void set thickness(num value) {
			if (value < 0) value = 0;
			if (value > 255) value = 255;
			this._thickness = value;
		}
		/**
		 * A number that indicates the alpha value of the color of the line; valid values are 0 to 1.
		 */
		  num get alpha {
			return this._alpha;
		}
		  void set alpha(num value) {
			if (value < 0) value = 0;
			if (value > 1) value = 1;
			this._alpha = value;
		}
		/**
		 * A value from the LineScaleMode class that specifies which scale mode to use.
		 * @see		http://livedocs.adobe.com/flex/2/langref/flash/display/LineScaleMode.html
		 */
		  String get scaleMode {
			return this._scaleMode;
		}
		  void set scaleMode(String value) {
			//if (value == LineScaleMode.NONE || value == LineScaleMode.NORMAL || value == LineScaleMode.HORIZONTAL || value == LineScaleMode.VERTICAL ){
				this._scaleMode = value;
			//}
		}
		/**
		 * A value from the CapsStyle class that specifies the type of caps at the end of lines.
		 * @see		http://livedocs.adobe.com/flex/2/langref/flash/display/CapsStyle.html
		 */
		  String get caps {
			return (this._caps != null) ? this._caps : CapsStyle.ROUND;
		}
		  void set caps(String value) {
			//if (value == CapsStyle.NONE || value == CapsStyle.ROUND || value == CapsStyle.SQUARE){
				this._caps = value;
			//}
		}
		/**
		 * A value from the JointStyle class that specifies the type of joint appearance used at angles.
		 * @see		http://livedocs.adobe.com/flex/2/langref/flash/display/JointStyle.html
		 */
		  String get joints {
			return (this._joints != null) ? this._joints : JointStyle.ROUND;
		}
		  void set joints(String value) {
			if (value == JointStyle.BEVEL || value == JointStyle.MITER || value == JointStyle.ROUND){
				this._joints = value;
			}
		}
		/**
		 * A number that indicates the limit at which a miter is cut off. Valid values range from 1 to 255.
		 */
		  num get miterLimit {
			return this._miterLimit;
		}
		  void set miterLimit(num value) {
			if (value < 1) value = 1;
			if (value > 255) value = 255;
			this._miterLimit = value;
		}
		
		
		/**
		 * Sets a Graphics instance its lineStyle equal to the values of the native supported properties (all of which can be set through this class its constructor).
		 * 
		 * @param	graphics	A Graphics instance.
		 * 
		 * @see		LineStyle#thickness
		 * @see		LineStyle#color
		 * @see		LineStyle#alpha
		 * @see		LineStyle#pixelHinting
		 * @see		LineStyle#scaleMode
		 * @see		LineStyle#caps
		 * @see		LineStyle#joints
		 * @see		LineStyle#miterLimit
		 * 
		 */
		  void applyTo(Graphics graphics) {
		    graphics.strokeColor(((this.alpha* 256).round() << 24) + this.color, this.thickness, this.joints, this.caps);
		    
		    /*graphics.lineStyle (this.thickness, 
								this.color, 
								this.alpha, 
								this.pixelHinting, 
								this.scaleMode, 
								this.caps, 
								this.joints, 
								this.miterLimit);
								 */
		}
		
		
		/**
		 * The length of a dash in a dashed line. When this property is set, dashEnabled is automatically set to true.
		 * 
		 * @default	2
		 * 
		 * @see		LineStyle#space
		 * @see		LineStyle#dashEnabled
		 */
		  num get dash {
			return this._dash;
		}
		  void set dash(num value) {
			if (value < MIN_DASH) value = MIN_DASH;
			this._dash = value;
			this.dashEnabled = true;
		}
		
		
		/**
		 * The space between two dashes in a dashed line. If untouched, the value of the space property will be equal to that of the dash property.
		 * 
		 * @default	2
		 * 
		 * @see		LineStyle#dash
		 * @see		LineStyle#dashEnabled
		 */
		  num get space {
			return (this._space == -1) ? this._dash : this._space;
		}
		  void set space(num value) {
			if (value < MIN_DASH) value = MIN_DASH;
			this._space = value;
		}
		
		
	}
	
	
