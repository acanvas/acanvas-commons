 part of dart_commons;

	
	/**
	 * Dispatched when a page is added to or removed from the PageManager.
	 * @eventType	com.rubenswieringa.book.BookEvent.CONTENT_CHANGED
	 * @see			BookEvent#CONTENT_CHANGED
	 * @see			PageManager#pages
	 */
	// [Event(name="contentChanged", type="com.rockdot.library.view.component.book.view.BookEvent")]
	
	
	/**
	 * PageManager provides the core functionality for the Book class.
	 * 
	 * @author		Ruben Swieringa
	 * 				ruben.swieringa@gmail.com
	 * 				www.rubenswieringa.com
	 * 				www.rubenswieringa.com/blog
	 * @version		1.0.1
	 * @see			Book Book
	 * @see			Page Page
	 * 
	 * 
	 * @internal
	 * 
	 * edit 5
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
	 class PageManager extends ManagedSpriteComponent {
		
		
		/**
		 * Left-hand stack of Page instances.
		 * @
		 */
		 SuperViewStack pageL = new SuperViewStack();
		/**
		 * Left-hand stack of Page instances.
		 * @
		 */
		 SuperViewStack pageR = new SuperViewStack();
		/**
		 * Shape instance on which pageflips are drawn as BitmapData.
		 * @
		 */
		 Shape renderShape = new Shape();
		
		// internals for accessors:
		/**
		 * @see	PageManager#openAt
		 * @
		 */
		 int _openAt = -1;
		/**
		 * @see	PageManager#currentPage
		 * @see	PageManager#_currentPage
		 * @
		 */
		 int __currentPage = -1;
		/**
		 * @see	PageManager#pages
		 * @
		 */
		 List _pages = new List();
		
		
	// CONSTRUCTOR:
		
		/**
		 * Constructor.
		 */
		  PageManager(String id): super(id)  {
			
			StateManager.instance.register(this);
//			this._pages.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.onContentChanged);
		}
		
		
	// LISTENERS:
		
		
		/**
		 * Listener-method for the collectionChange Event of the pages property.
		 * 
		 * @see		PageManager#pages
		 * 
		 * @
		 */
		  void onContentChanged() {
			this.dispatchEvent(new BookEvent(BookEvent.CONTENT_CHANGED, this));
		}
		
		
	// OVERRIDES:
		
		/**
		 * @
		 */
		@override 
		  void redraw() {
			super.redraw();
			
			this.refreshViewStacks();
		}
		
		
		/**
		 * Adds the ViewStacks for left and right, also adds a render Shape (for during pageflips).
		 * 
		 * @
		 */
		@override 
		  void init([dynamic data=null]) {
			
			super.init(data);
			
			this.pageL.setSize(widthAsSet/2, heightAsSet);
			this.pageR.setSize(widthAsSet/2, heightAsSet);
			
			this.pageL.fade = this.pageR.fade = 0;
			this.pageR.x = this.renderShape.x = widthAsSet / 2;
			
			super.addChild(this.pageL);
			super.addChild(this.pageR);
			super.addChild(this.renderShape);
			
			// if the amount of Pages is uneven, add another Page:
			if (this._pages.length%2 == 1){
				Page page = new Page();
				this.addChild(page);
			}
			
			// set startup properties:
			this.openAt = this._openAt;
			this._currentPage = this._openAt;
			
			// activate children:
			this.refreshViewStacks();
		}
		
		
		
		/**
		 * Adds a child Page instance to this PageManager instance. Regardless of this method's signiature, the child parameter must always be an instance of the Page class.
		 * 
		 * @param	child	The Page instance to add as a child of this PageManager instance.
		 * 
		 * @return	The Page instance that you pass in the child parameter.
		 * 
		 * @throws	BookError	Gets thrown when the child parameter is not an instance of the Page class.
		 * @see		BookError#CHILD_NOT_PAGE
		 * 
		 */
		@override 
		  DisplayObject addChild(DisplayObject child) {
			return this.addPageAt(child, this._pages.length);
		}
		/**
		 * Adds a child Page instance to this PageManager instance at the index position specified.
		 * 
		 * @param	child	The Page instance to add as a child of this PageManager instance.
		 * @param	index	The index position to which the child is added.
		 * 
		 * @return	The Page instance that you pass in the child parameter.
		 * 
		 * @throws	BookError	Gets thrown when the child parameter is not an instance of the Page class.
		 * @see		BookError#CHILD_NOT_PAGE
		 * 
		 */
		  DisplayObject addPageAt(DisplayObject child,int index) {
			// only allow children that are instances of the Page class:
			if (child is Page){
				Page page = (child);
				// correct index so that it is within bounds:
				if (index < 0)					index = 0;
				if (index > this._pages.length)	index = this._pages.length;
				// initialize Page:
				this.initPage(page, index);
				// add Page to left or right ViewStack:
				if (index%2 == 1){
					this.pageL.addChildAt(child, this.generateStackIndex(page));
				}else{
					this.pageR.addChildAt(child, this.generateStackIndex(page));
				}
				// make sure all other Pages are in the right ViewStacks:
				if (index < this._pages.length-1){
					this.jumpViewStacks(index+1);
				}
				if (StateManager.instance.getState(this) == StateManager.UPDATE_COMPLETE){
					this.refreshViewStacks();
				}
				// return value:
				return page;
			}else{
				throw new BookError(BookError.CHILD_NOT_PAGE);
			}
		}
		
		
		/**
		 * Removes all children (Page instances) from the child list of this container.
		 */
		@override 
		  void destroy() {
			// remove all Pages children from ViewStacks:
			this.pageL.destroy();
			this.pageR.destroy();
			// clear book property of Pages:
			for (int i=0; i<this._pages.length; i++){
				(this._pages[i] as Page).setBook(null);
			}
			// reset properties:
			this._pages = new List();
			this._currentPage = -1;
			// refresh ViewStacks:
			this.refreshViewStacks();
			
			super.destroy();
		}
		/**
		 * Removes a child Page from the child list of this Container.
		 * 
		 * @param	child	The Page instance to remove.
		 * 
		 * @return	The removed child.
		 * 
		 * @throws	BookError		Gets thrown when the child parameter is not an instance of the Page class.
		 * @see		BookError#CHILD_NOT_PAGE
		 * 
		 * @throws	ArgumentsError	Gets thrown when the child parameter is not a child of this PageManager.
		 * @see		BookError#PAGE_NOT_CHILD
		 * 
		 */
		@override 
		  DisplayObject removeChild(DisplayObject child) {
			// only instances of the Page class are allowed as children:
			if (child is Page){
				int index = this._pages.indexOf(child);
				if ((child).book != this || index == -1){
					throw new ArgumentError(BookError.PAGE_NOT_CHILD);
				}
				return this.removeChildAt(index);
			}else{
			//	throw new BookError(BookError.CHILD_NOT_PAGE);
			}
		}
		/**
		 * Removes a child Page from the child list of this Container at the specified index.
		 * 
		 * @param	index	The child index of the Page to remove.
		 * 
		 * @return	The removed child.
		 * 
		 * @throws	ArgumentError	Gets thrown when the supplied index is out of bounds.
		 * @see		BookError#OUT_OF_BOUNDS
		 * 
		 */
		@override 
		  DisplayObject removeChildAt(int index) {
			// throw error if index is out of bounds:
			if (index < 0 || index > this._pages.length-1){
				throw new ArgumentError(BookError.OUT_OF_BOUNDS);
			}
			// define Page:
			Page page = (this._pages[index] as Page);
			// remove Page from left or right ViewStack:
			if (index%2 == 1){
				this.pageL.removeChild(page);
			}else{
				this.pageR.removeChild(page);
			}
			// remove Page from List and clear book property:
			this._pages.removeAt(index);
			onContentChanged();
			
			page.setBook(null);
			// adjust _currentPage if necessary:
			if (this._currentPage > this._pages.length-1){
				this._currentPage -= 2;
			}
			// make sure all other Pages are in the right ViewStacks:
			if (index <= this._pages.length-1){
				this.jumpViewStacks(index);
			}
			if (StateManager.instance.getState(this) >= StateManager.UPDATE_COMPLETE){
				this.refreshViewStacks();
			}
			
			// return value:
			return page;
		}
		
		
		/**
		 * Changes the position of an existing child in the PageManager container.
		 * 
		 * @param	child	The child Page instance for which you want to change the index number.
		 * @param	index	The resulting index number for the child display object.
		 * 
		 * @throws	BookError	Gets thrown when the child parameter is not an instance of the Page class.
		 * @see		BookError#CHILD_NOT_PAGE
		 * 
		 * @throws	ArgumentsError	Gets thrown when the child parameter is not a child of this PageManager.
		 * @see		BookError#PAGE_NOT_CHILD
		 * 
		 */
		@override 
		  void setChildIndex(DisplayObject child,int newIndex) {
			// only instances of the Page class are allowed as children:
			if (child is Page){
				if ((child ).book != this || (child ).index == -1){
					throw new ArgumentError(BookError.PAGE_NOT_CHILD);
				}
				this.removeChild(child);
				this.addChildAt(child, newIndex);
				(child ).refreshFoldGradient();
			}else{
				throw new BookError(BookError.CHILD_NOT_PAGE);
			}
		}
		/**
		 * Swaps the position of two Page instances in the PageManager.
		 * 
		 * @param	child1	The first child object.
		 * @param	child2	The second child object.
		 * 
		 * @throws	BookError	Gets thrown when the child parameter is not an instance of the Page class.
		 * @see		BookError#CHILD_NOT_PAGE
		 * 
		 * @throws	ArgumentsError	Gets thrown when the child parameter is not a child of this PageManager.
		 * @see		BookError#PAGE_NOT_CHILD
		 * 
		 */
		@override 
		  void swapChildren(DisplayObject child1,DisplayObject child2) {
			if (child1 is Page && child2 is Page){ // if both children are Pages, treat them special
				int index1 = (child1 ).index;
				int index2 = (child2 ).index;
				if ((child1 ).book != this || index1 == -1 || (child2 ).book != this || index2 == -1){
					throw new ArgumentError(BookError.PAGE_NOT_CHILD);
				}
				ChildTool.swapChildren(child1, child2);
				this._pages[index1] = (child2);
				this._pages[index2] = (child1);
				this.refreshViewStacks();
				(child1 ).refreshFoldGradient();
				(child2 ).refreshFoldGradient();
			}else{ // if children are not both Pages, then they don't belong to the externally visible part of this instance:
				throw new BookError(BookError.CHILD_NOT_PAGE);
			}
		}
		/**
		 * Swaps the position of two Page instances in the PageManager at the specified indexes.
		 * 
		 * @param	index1	The index position of the first child object.
		 * @param	index2	The index position of the second child object.
		 * 
		 */
		@override 
		  void swapChildrenAt(int index1,int index2) {
			this.swapChildren((this._pages[index1] as Page), (this._pages[index2] as Page));
		}
		
		
		/**
		 * Returns the child display object that exists with the specified name.
		 * 
		 * @param	name	The name of the child to return.
		 * 
		 * @return	The child Page with the specified name as a DisplayObject. You may want to cast the return value of this method back to a Page.
		 * 
		 */
		@override 
		  DisplayObject getChildByName(String name) {
			// see if child with provided name is in either one of the ViewStacks:
			Page child;
			for (int i=0; i<this._pages.length; i++){
				child = (this._pages[i] as Page);
				if (child.name == name){
					return child;
				}
			}
			// if not, return null:
			return null;
		}
		/**
		 * Returns the index position of a child Page instance.
		 * 
		 * @param	child	The Page instance to identify.
		 * 
		 * @return	The index position of the child Page to identify.
		 * 
		 */
		@override 
		  int getChildIndex(DisplayObject child) {
			return this._pages.indexOf(child);
		}
		/**
		 * Returns an array of objects that lie under the specified point and are children (or grandchildren, and so on) of this PageManager instance.
		 * 
		 * @param	point	The point under which to look.
		 * 
		 * @return	An array of objects that lie under the specified point and are children (or grandchildren, and so on) of this PageManager instance.
		 * 
		 */
		//FIXME NOT AVAILABLE IN STAGEXL
		/* 
		List getObjectsUnderPoint(Point point) {
			List pagesL = this.pageL.getObjectsUnderPoint(point);
			List pagesR = this.pageR.getObjectsUnderPoint(point);
			return new List.from(pagesL)..addAll(pagesR);
		}
		 */
		
		
		/**
		 * Determines whether the specified display object is a child of the PageManager instance or the instance itself.
		 * 
		 * @param	child	The child object to test.
		 * 
		 * @return	true if the child object is a child of the PageManager or the container itself; otherwise false.
		 * 
		 */
		@override 
		  bool contains(DisplayObject child) {
			return (this.pageL.contains(child) || this.pageR.contains(child) || child == this);
		}
		
	// COMMON USAGE:
		
		
		/**
		 * Sets standard settings (such as width and height) for Page instances, typically called by addChildAt().
		 * 
		 * @see		PageManager#addChildAt()
		 * 
		 * @param	page	Page of which to set the settings.
		 * @param	index	Index at which to insert this Page into the pages ListCollection.
		 * 
		 * @return	Page passed as a parameter, with settings set.
		 * 
		 * @
		 */
		  void initPage(Page page,int index) {
			// set properties:
			page.setBook(this);
			page.width =	widthAsSet / 2;
			page.height =	heightAsSet;
			// add Page to List:
			this._pages.add(page);
			onContentChanged();
		}
		
		
		/**
		 * Calculates the relative index at which a Page should be added to either one of the two ViewStacks. Not to be confused with the absolute index used in the pages property.
		 * 
		 * @param	page	Page for which to calculate the relative index.
		 * 
		 * @return	Relative index for the provided Page.
		 * 
		 * @
		 */
		  int generateStackIndex(Page page) {
			int index = this._pages.indexOf(page);
			if (index%2 == 1){
				return (this._pages.length/2).ceil()-(index/2).ceil();
			}else{
				return (index/2).round();
			}
		}
		
		
		/**
		 * Makes all Page instances above (or equal to) the provided index switch ViewStacks. Called, for example, by addChildAt because when a new Page is inserted lefthand-side Pages become righthand-side Pages, etc.
		 * 
		 * @param	fromIndex	Absolute index (indicating the Page its position in the pages property) from which to start switching ViewStacks.
		 * 
		 * @
		 */
		  void jumpViewStacks(int fromIndex) {
			Page page;
			for (int i=fromIndex; i<this._pages.length; i++){
				page = (this._pages[i] as Page);
				if (page.side != Page.LEFT){
					ChildTool.moveChild(page, this.pageR, this.generateStackIndex(page));
				}else{
					ChildTool.moveChild(page, this.pageL, this.generateStackIndex(page));
				}
			}
		}
		
		
		/**
		 * Displays the appropriate Pages in the two ViewStacks.
		 * 
		 * @
		 */
		  void refreshViewStacks() {
			
			this.pageL.visible = ((!this.isFirstPage(this._currentPage+1) || this._pages.length <= 1) && this.pageL.numChildren > 0);
			if (this.pageL.visible){
				this.pageL.selectedChild = (this._pages[this._currentPage] as Sprite);
			}
			this.pageL.redraw();
			
			this.pageR.visible = ((!this.isLastPage(this._currentPage) || this._pages.length <= 1) && this.pageR.numChildren > 0);
			if (this.pageR.visible){
				this.pageR.selectedChild = (this._pages[this._currentPage+1] as Sprite);
			}
			this.pageR.redraw();
			
		}
		
		
		/**
		 * Returns true if the provided Page is the first Page in the List, false if otherwise.
		 * 
		 * @param	page	int/int or Page, indicating the index or instance of a Page.
		 * 
		 * @return	bool indicating whether or not the Page is the first in line.
		 * 
		 * @throws	ArgumentsError	Gets thrown when the page parameter is a Page but not a child of this PageManager.
		 * @see		BookError#PAGE_NOT_CHILD
		 * 
		 * @
		 */
		  bool isFirstPage(dynamic page) {
			page = this.getPage(page, false);
			return (page != null && page.index == 0);
		}
		/**
		 * Returns true if the provided Page is the last Page in the List, false otherwise.
		 * 
		 * @param	page	int/int or Page, indicating the index or instance of a Page.
		 * 
		 * @return	bool indicating whether or not the Page is the last in line.
		 * 
		 * @throws	ArgumentsError	Gets thrown when the page parameter is a Page but not a child of this PageManager.
		 * @see		BookError#PAGE_NOT_CHILD
		 * 
		 * @
		 */
		  bool isLastPage(dynamic page) {
			page = this.getPage(page, false);
			return (page != null && page.index == this._pages.length-1);
		}
		
		
		/**
		 * Takes an index or Page instance and returns it as a Page instance.
		 * 
		 * @param	page	int/int or Page, indicating the index or instance of a Page to be returned.
		 * @param	varify	If true, this method will throw an Error if page is an out-of-bounds index or a Page that is not a child of this PageManager. If false, the method will return null under the previously described circumstances.
		 * 
		 * @return	Page
		 * 
		 * @
		 */
		  Page getPage(dynamic page,[bool varify=false]) {
			// throw Error if page is not a Page instance nor a numeric variable:
			if (!(page is Page) && !(page is int) && !(page is int)){
				throw new BookError(BookError.CHILD_NOT_PAGE);
			}
			// if page is numeric, transform it into a Page:
			if (!(page is Page)){
				// throw Error if index is out of bounds:
				if (page < 0 || page >= this._pages.length){
					if (varify && page != -1){ // even though -1 is not a valid index, it does virtually indicate a Page
						throw new ArgumentError(BookError.OUT_OF_BOUNDS);
					}else{
						page = null;
					}
				}else{
					page = (this._pages[page] as Page);
				}
			}
			// throw Error if Page its parent is not this PageManager instance:	
			if (page != null && page.book != this){
				throw new ArgumentError(BookError.PAGE_NOT_CHILD);
			}
			// return index:
			return page;
		}
		/**
		 * Takes an index or Page instance and returns it as the index of a Page instance.
		 * 
		 * @param	page	int/int or Page, indicating the index or instance of a Page-index to be returned.
		 * @param	varify	If true, this method will throw an Error if page is an out-of-bounds index or a Page that is not a child of this PageManager. If false, the method will return null under the previously described circumstances.
		 * 
		 * @return	int
		 * 
		 * @
		 */
		  int getPageIndex(dynamic page,[bool varify=false]) {
			page = this.getPage(page, varify);
			return (page == null) ? -1 : page.index;
		}
		
		
	// ACCESSORS:
		
		
		/**
		 * Flag indicating whether the instance has reached the creationComplete state.
		 * @
		 */
		  bool get created {
			return (StateManager.instance.getState(this) >= StateManager.CREATION_COMPLETE);
		}
		
		
		/**
		 * Index of the current left-hand page (-1 if the Book is unopened).
		 */
		// [Bindable(event='currentPageChanged')]
		  int get currentPage {
			return this._currentPage;
		}
		
		
		/**
		 * Internet accessor for the  currentPage property.
		 * @see	PageManager#currentPage
		 * @see	http://www.rubenswieringa.com/blog/binding-read-only-accessors-in-flex Rubens blog: Binding read-only accessors in Flex
		 * @
		 */
		  void set _currentPage(int value) {
			if (this._currentPage == value){
				return;
			}
			this.__currentPage = value;
			this.dispatchEvent(new Event(BookEvent.CURRENTPAGE_CHANGED));
		}
		/**
		 * @
		 */
		  int get _currentPage {
			return this.__currentPage;
		}
		
		
		/**
		 * Index of the Page at which the Book is opened at startup, can only be set once, and only at startup.
		 * @default	-1
		 */
		  int get openAt {
			return this._openAt;
		}
		  void set openAt(int value) {
			if (value < -1){
				value = -1;
			}
			if (value > this._pages.length-1 && this._pages.length > 0){
				value = this._pages.length-1;
			}
			if (value % 2 == 0){
				value--;
			}
			this._openAt = value;
		}
		
		
		/**
		 * List of all respective Pages in this Book instance.
		 */
		// [Bindable(event='contentChanged')]
		  List get pages{
			return this._pages;
		}
		
		
	}
	
	
