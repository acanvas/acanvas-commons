 part of stagexl_commons;

	
	/**
	 * SuperViewStack in many ways behaves like the classic ViewStack.
	 * Additional features are reversed indexing (0=top, N=bottom) and fading of children.
	 * 
	 * @author		Ruben Swieringa
	 * 				ruben.swieringa@gmail.com
	 * 				www.rubenswieringa.com
	 * @version		1.0.3
	 * @see			mx.containers.ViewStack
	 * 
	 * 
	 * edit 3
	 * 
	 * Before modifying and/or redistributing this class, please contact Ruben Swieringa (ruben.swieringa@gmail.com)
	 * 
	 * 
	 * View code documentation at: dynamic  http://www.rubenswieringa.com/code/as3/flex/SuperViewStack/docs/
	 * 
	 */
	 class SuperViewStack extends SpriteComponent {
		
		
	// status variables:
		/**
		 * @
		 */
 		 bool _childrenCreated = false;
		
	// internals for accessors:
		/**
		 * @
		 */
 		 int _selectedIndex = -1;
		/**
		 * @
		 */
 		 List __fade = [DEFAULT_FADE, 1.0];
		/**
		 * @
		 */
 		 int _fadeColor = DEFAULT_FADECOLOR; 
 			
	// constants:
		/**
		 * Name of the Shape that is used to simulate fading of Containers.
		 */
 		 static final String FADESHAPE_NAME = "superviewstackfade";
		/**
		 * Event type for the Event that is dispatched when the selected child Container changes.
		 * 
		 * @see		SuperViewStack#behavior
		 */
		 static final String BEHAVIOR_CHANGED = "Behavior of SuperViewStack changed";
		/**
		 * Full-feature SuperViewStack behavior mode
		 * 
		 * @see		SuperViewStack#behavior
		 */
		 static final String SUPER = "SuperViewStack";
		/**
		 * Normal behavior mode, simulating the behavior of the classic ViewStack
		 * 
		 * @see		SuperViewStack#behavior
		 * @see		mx.containers.ViewStack
		 */
		 static final String NORMAL = "ViewStack";
		/**
		 * @
		 */
 		 static final num DEFAULT_FADE = 0.6;
		/**
		 * @
		 */
		 static final int DEFAULT_FADECOLOR = 0xFFFFFF;
		
		
	// CONSTRUCTOR:
		
		/**
		 * Constructor.
		 */
		  SuperViewStack(): super()  {
			_ignoreCallSetSize = true;
			
			this._childrenCreated = true;
			
			if (this._selectedIndex == -1){
				this.selectedIndex = 0;
			}
			this.showChildren();
			
		}
		
		/**
		 * @see		mx.containers.ViewStack#updateDisplayList()
		 * 
		 * @
		 */
		@override 
		  void redraw() {
			super.redraw();
			
			this.showChildren();
			
			for (int i=0; i<this.numChildren; i++){
				this.resizeFade(this.getChildAt(i) as Sprite);
			}
		}
		
		/**
		 * Adds a child DisplayObject instance to this DisplayObjectContainer instance.
		 *  Adjusted to make sure that (if reverse is set to true) children are created from top to bottom.
		 * 
		 * @param	child	The DisplayObject to add as a child of this Container.
		 * 
		 * @return	The added child as an object of type DisplayObject.
		 * 
		 * @see		mx.containers.ViewStack#addChild()
		 */
		@override 
		  DisplayObject addChild(DisplayObject child) {
			return this._addChild(child);
		}
		
		/**
		 * Adds a child DisplayObject to this Container. The child is added at the index specified.
		 *  Adjusted to make sure that (if reverse is set to true) children are created from top to bottom.
		 * 
		 * @param	child	The DisplayObject to add as a child of this Container.
		 * @param	index	The index to add the child at.
		 * 
		 * @return	The added child as an object of type DisplayObject.
		 * 
		 * @see		mx.containers.ViewStack#addChildAt
		 */
		@override 
		  DisplayObject addChildAt(DisplayObject child,int index) {
			return this._addChild(child, index);
		}
		
		/**
		 * @
		 */
		  DisplayObject _addChild(DisplayObject child,[int index=-1]) {
			if (index == -1){
				super.addChildAt(child, 0);
			}else{
				super.addChildAt(child, this.reverseIndex(index)+1);
			}
			
			// create a Shape for the fade to be drawn on and make sure it gets sized on the right time:
			this.drawFade(child as Sprite);
			child.addEventListener(Event.ADDED_TO_STAGE, this.childCreationComplete);
			
			// execute some additional tasks if this is during runtime:
			if (this._childrenCreated){
				if (index == -1){
					if (this.numChildren > this.selectedIndex) this._selectedIndex++;
				}else{
					if (index > this.selectedIndex) this._selectedIndex++;
				}
				this.applyFade();
				this.showChildren();
			}
			
			// return child:
			return child;
		}
		
		/**
		 * Event handler for the creationComplete event of an added child, calls resizeFade().
		 * 
		 * @param	event	.
		 * 
		 * @see		SuperViewStack#resizeFade()
		 * 
		 * @
		 */
		  void childCreationComplete(Event event) {
			this.resizeFade(event.target as Sprite);
		}
		
		/**
		 * Returns the child display object instance that exists at the specified index.
		 * 
		 * @param	index	The index position of the child object.
		 * 
		 * @return	The child display object at the specified index position.
		 * 
		 * @see		mx.containers.ViewStack#getChildAt()
		 */
		@override 
		  DisplayObject getChildAt(int index) {
			return super.getChildAt(this.reverseIndex(index));
		}
		
		/**
		 * Returns the index position of a child DisplayObject instance.
		 * 
		 * @param	child	The DisplayObject instance to identify.
		 * 
		 * @return	The index position of the child display object to identify.
		 * 
		 * @see		mx.containers.ViewStack#getChildIndex()
		 */
		@override 
		  int getChildIndex(DisplayObject child) {
			return this.reverseIndex(super.getChildIndex(child));
		}
		
		/**
		 * Removes a child DisplayObject from the specified index position in the child list of the DisplayObjectContainer.
		 * 
		 * @param	index	The child index of the DisplayObject to remove.
		 * 
		 * @return	The DisplayObject instance that was removed.
		 * 
		 * @see		mx.containers.ViewStack#removeChildAt()
		 */
		@override 
		void removeChildAt(int index) {
			this.unregisterChildAt(index);
			super.removeChildAt(this.reverseIndex(index));
		}
		/**
		 * Removes a child DisplayObject from the child list of this Container.
		 * 
		 * @param	child	The DisplayObject to remove.
		 * 
		 * @return	The DisplayObject instance that was removed.
		 * 
		 * @see		mx.containers.ViewStack#removeChild()
		 */
		@override 
		void removeChild(DisplayObject child) {
			this.unregisterChildAt(this.getChildIndex(child));
			super.removeChild(child);
		}
		/**
		 * Clears a child to be removed of event listeners added by this class and refreshes visuals.
		 * 
		 * @param	index	The index of the DisplayObject to be removed.
		 * 
		 * @see		SuperViewStack#removeChild()
		 * @see		SuperViewStack#removeChildAt()
		 * 
		 * @
		 */
		  void unregisterChildAt(int index) {
			DisplayObject child = this.getChildAt(index);

			child.removeEventListener(Event.ADDED_TO_STAGE, this.childCreationComplete);
			
			if (this._childrenCreated){
				if (index < this.selectedIndex) this._selectedIndex--;
				this.applyFade();
				this.showChildren();
			}
		}
		
		/**
		 * Changes the position of an existing child in the display object container.
		 * 
		 * @param	child	The child DisplayObject instance for which you want to change the index number.
 		 * @param	index	The resulting index number for the child display object.
		 * 
		 * @see		mx.containers.ViewStack#setChildIndex()
		 */
		@override 
		  void setChildIndex(DisplayObject child,int index) {
			super.setChildIndex(child, this.reverseIndex(index));
		}
		
		/**
		 * Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the child list.
		 * 
		 * @param	index1	The index position of the first child object.
		 * @param	index2	The index position of the second child object.
		 * 
		 * @see		mx.containers.ViewStack#swapChildrenAt()
		 */
		@override 
		  void swapChildrenAt(int index1,int index2) {
			index1 = this.reverseIndex(index1);
			index2 = this.reverseIndex(index2);
			super.swapChildrenAt(index1, index2);
		}
		
		/**
		 * Removes all children from the child list of this container.
		 * 
		 * @see		mx.containers.ViewStack#removeAllChildren()
		 */
		@override 
		  void destroy() {
			super.destroy();
			this._selectedIndex = -1;
		}
		
		
	// CUSTOM:
		
		/**
		 * Set visibility to true for the children underneath selectedChild (and selectedChild itself), false for the rest.
		 * 
		 * @
		 */
		  void showChildren() {
			
			for (int i=0; i<this.numChildren; i++){
				Sprite child = super.getChildAt(i) as Sprite;
				if (this._fade == 1.0){
					child.visible = (i == this._selectedIndex);
				}else{
					child.visible = (i <= this._selectedIndex);
				}
			}
			
			// make sure fading is adjusted:
			this.applyFade();
			
		}
		
		/**
		 * Creates an empty Shape (for the fade to be drawn on) inside a child.
		 * 
		 * @param	child	Child of this SuperViewStack instance
		 * 
		 * @
		 */
		  void drawFade(Sprite child) {
			
			Shape shape = new Shape();
			shape.name = SuperViewStack.FADESHAPE_NAME;
			child.addChild(shape);
			
		}
		
		/**
		 * Sizes of resizes the Shape in which the fade is drawn, called by childCreationComplete()
		 * 
		 * @param	child	Child of this SuperViewStack instance whose fade Shape to resize.
		 * 
		 * @see		SuperViewStack#childCreationComplete()
		 * 
		 * @
		 */
		  void resizeFade(Sprite child) {
			
			// point out the Shape:
			Shape shape = child.getChildByName(SuperViewStack.FADESHAPE_NAME) as Shape;
			
			// size and position:
			shape.x = -child.x;
			shape.y = -child.y;
			//shape.width = child.getExplicitOrMeasuredWidth();
			//shape.height = child.getExplicitOrMeasuredHeight();
			shape.width = child.width;
			shape.height = child.height;
			
		}
		
		/**
		 * Loops through this SuperViewStack its children and draws a fade for one.
		 * 
		 * @
		 */
		  void applyFade() {
			
			Sprite child;
			Shape shape;
			
			for (int i=0; i<this.numChildren; i++){
				
				child = super.getChildAt(i) as Sprite;
				shape = child.getChildByName(SuperViewStack.FADESHAPE_NAME) as Shape;
				
				shape.visible = (this._fade != 0);
				if (!shape.visible) continue;
				
				shape.graphics.clear();
				if (i != this._selectedIndex){
					shape.graphics.rect(0, 0, 100, 100);
					shape.graphics.fillColor(((this._fade * 256).round() << 24) + this._fadeColor);
				}
				
			}
			
		}
		
		/**
		 * Returns the reverse value of a specified index.
		 * 
		 * @param	index	Index (for as int) a specific child
		 * 
		 * @return	Reverse value (of as int) the specified index
		 * 
		 * @
		 */
		  int reverseIndex(int value) {
			return this.numChildren - 1 - value;
		}
		
		
	// ACCESSORS:
		
		/**
		 * The zero-based index of the currently visible child container.
		 * 
		 * @copy	mx.containers.ViewStack#selectedIndex
		 * @see		mx.containers.ViewStack#selectedIndex
		 */
		  int get selectedIndex {
			int index = (this._selectedIndex != -1) ? this._selectedIndex : 0;
			return this.reverseIndex(index);
		}
		  void set selectedIndex(int value) {

			// store old value:
			IndexChangedEvent event = new IndexChangedEvent(IndexChangedEvent.CHANGE);
			event.oldIndex = this.selectedIndex;
			
			// make sure value is within bounds:
			if (value < 0) value = 0;
			if (value > this.numChildren-1) value = this.numChildren-1;
			
			// reverse value:
			value = this.reverseIndex(value);
			
			// return if there is no change:
			if (this._selectedIndex == value) return;
			
			// set internal and refresh children:
			this._selectedIndex = value;
			this.showChildren();
			
			// store new value and dispatch event:
			event.newIndex = this.selectedIndex;
			if(numChildren > 0){
				event.relatedObject = this.selectedChild;
			}
	        dispatchEvent(event);
		}
		
		/**
		 * A reference to the currently visible child container.
		 * 
		 * @copy	mx.containers.ViewStack#selectedChild
		 * @see		mx.containers.ViewStack#selectedChild
		 */
		  Sprite get selectedChild {
			return super.getChildAt(this._selectedIndex) as Sprite;
		}
		  void set selectedChild(Sprite child) {
			this.selectedIndex = this.getChildIndex(child);
		}
		
		/**
		 * Degree to which a child should be faded if it's underneath another visible child.
		 *  Values range from 0.0 (completely transparent) to 1.0 (no transparency), defaults to 0.6.
		 */
		  num get fade {
			return this._fade;
		}
		  void set fade(num value) {
			// make sure value is within bounds:
			if (value < 0) value = 0;
			if (value > 1) value = 1;
			// return if there is no change:
			if (this._fade == value) return;
			// switch back to SuperViewStack behavior (if necessary):
			this.behavior = SuperViewStack.SUPER;
			// set internal and refresh children:
			this._fade = value;
			this.showChildren();
		}
		
		/**
		 * First value in __fade (List), indicating the transparency of fades
		 * 
		 * @
		 */
		  num get _fade {
			return this.__fade[0];
		}
		/**
		 * @
		 */
		  void set _fade(num value) {
			this.__fade[0] = value;
		}
		
		/**
		 * Color with which to fade a child, defaults to white (0xFFFFFF).
		 */
		  int get fadeColor {
			return this._fadeColor;
		}
		  void set fadeColor(int value) {
			// switch back to SuperViewStack behavior (if necessary):
			this.behavior = SuperViewStack.SUPER;
			// set internal and refresh children:
			this._fadeColor = value;
			this.applyFade();
		}
		
		/**
		 * Behavior of this SuperViewStack. Can be adjusted during runtime.
		 *  Values can be either SuperViewStack.SUPER or SuperViewStack.NORMAL.
		 *  If normal, the SuperViewStack will act like the classic ViewStack.
		 * 
		 * @see		SuperViewStack#BEHAVIOR_CHANGED
		 * @see		SuperViewStack#SUPER
		 * @see		SuperViewStack#NORMAL
		 */
		  String get behavior {
			if (this._fade == 1.0){
				return SuperViewStack.NORMAL;
			}else{
				return SuperViewStack.SUPER;
			}
		}
		  void set behavior(String value) {
			if (value == this.behavior || (value != SuperViewStack.SUPER && value != SuperViewStack.NORMAL)){
				return;
			}
			this.__fade = this.__fade.reversed;
			this.showChildren();
			this.dispatchEvent(new Event(SuperViewStack.BEHAVIOR_CHANGED));
		}
		
		
	}
	
	
