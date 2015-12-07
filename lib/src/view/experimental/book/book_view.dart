part of stagexl_commons;

/**
 * Dispatched when the user picks up the corner of a page.
 * @eventType	com.rubenswieringa.book.BookEvent.PAGEFLIP_STARTED
 * @see			BookEvent#PAGEFLIP_STARTED
 */
// [Event(name="pageflipStarted", type="com.rockdot.library.view.component.book.view.BookEvent")]
/**
 * Dispatched when the user releases the corner of a page. Note that this Event is dispatched just before the page starts falling in place.
 * @eventType	com.rubenswieringa.book.BookEvent.PAGEFLIP_ENDING
 * @see			BookEvent#PAGEFLIP_FINISHED
 */
// [Event(name="pageflipEnding", type="com.rockdot.library.view.component.book.view.BookEvent")]
/**
 * Dispatched when a page falls in place after being flipped. This Event is dispatched regardless of whether or not the page has been turned, or has fallen back into its original position.
 * @eventType	com.rubenswieringa.book.BookEvent.PAGEFLIP_FINISHED
 * @see			BookEvent#PAGE_TURNED
 */
// [Event(name="pageflipFinished", type="com.rockdot.library.view.component.book.view.BookEvent")]
/**
 * Dispatched when the corner of a page is rolled over with the mouse.
 * Only applicable if the hover property is set to true.
 * @eventType	com.rubenswieringa.book.BookEvent.HOVER_STARTED
 * @see			BookEvent#HOVER_STARTED
 * @see			Book#hover
 */
// [Event(name="hoverStarted", type="com.rockdot.library.view.component.book.view.BookEvent")]
/**
 * Dispatched when the corner of a page is rolled out of with the mouse. Note that this Event is dispatched just before the page starts falling back in place.
 * Only applicable if the hover property is set to true.
 * @eventType	com.rubenswieringa.book.BookEvent.HOVER_ENDING
 * @see			BookEvent#PAGEFLIP_FINISHED
 * @see			Book#hover
 */
// [Event(name="hoverEnding", type="com.rockdot.library.view.component.book.view.BookEvent")]
/**
 * Dispatched when a page falls back in place after being rolled over with the mouse.
 * Only applicable if the hover property is set to true.
 * @eventType	com.rubenswieringa.book.BookEvent.HOVER_FINISHED
 * @see			BookEvent#PAGE_TURNED
 * @see			Book#hover
 */
// [Event(name="hoverFinished", type="com.rockdot.library.view.component.book.view.BookEvent")]
/**
 * Dispatched when a pageflip is successful.
 * @eventType	com.rubenswieringa.book.BookEvent.PAGE_TURNED
 * @see			BookEvent#PAGE_NOT_TURNED
 */
// [Event(name="pageTurned", type="com.rockdot.library.view.component.book.view.BookEvent")]
/**
 * Dispatched when a pageflip is not successful.
 * @eventType	com.rubenswieringa.book.BookEvent.PAGE_NOT_TURNED
 * @see			BookEvent#PAGE_TURNED
 */
// [Event(name="pageNotTurned", type="com.rockdot.library.view.component.book.view.BookEvent")]
/**
 * Dispatched when a Page is torn out of its Book.
 * @eventType	com.rubenswieringa.book.BookEvent.PAGE_TORN
 */
// [Event(name="pageTorn", type="com.rockdot.library.view.component.book.view.BookEvent")]
/**
 * Dispatched at the same time as the page-turned Event, when the Book was previously closed, and the first or last Page was flipped successfully.
 * @eventType	com.rubenswieringa.book.BookEvent.BOOK_OPENED
 * @see			BookEvent#PAGE_TURNED
 */
// [Event(name="bookOpened", type="com.rockdot.library.view.component.book.view.BookEvent")]
/**
 * Dispatched at the same time as the page-turned Event, when the Book was previously open, and the first or last Page was flipped successfully.
 * @eventType	com.rubenswieringa.book.BookEvent.BOOK_CLOSED
 * @see			BookEvent#PAGE_TURNED
 */
// [Event(name="bookClosed", type="com.rockdot.library.view.component.book.view.BookEvent")]
/**
 * Dispatched at the same time as the page-turned Event, when the Book was previously open, and the first or last Page was flipped successfully.
 * @eventType	com.rubenswieringa.book.BookEvent.BOOK_CLOSED
 * @see			BookEvent#STATUS_CHANGED
 * @see			Book#status
 */
// [Event(name="statusChanged", type="com.rockdot.library.view.component.book.view.BookEvent")]

/**
 * Book is a container class that creates a rich animated and interactive book from its contents, through which the end-user can browse by flipping the pages over (pageflip-effect).
 * Its core functionality (for example storage of Page instances) is defined by the PageManager class, which the Book class extends.<br />
 * Book itself describes the functionality for the management of pageflips. The actual pageflip class was written by Didier Brun (also mentioned in the credits).<br />
 * <br />
 * Ruben Swieringa created this component during his internship at the Factor.e (www.tfe.nl). Thanks to those guys for allowing me to publish the source-code online!
 *
 * @author		Ruben Swieringa
 * 				ruben.swieringa@gmail.com
 * 				www.rubenswieringa.com
 * 				www.rubenswieringa.com/blog
 * @version		1.0.1
 * @see			PageManager PageManager
 * @see			Page Page
 * @see			BookEvent BookEvent
 * @see			BookError BookError
 * @see			com.foxaweb.pageflip.PageFlip com.foxaweb.pageflip.PageFlip
 * @see			org.flashsandy.display.DistortImage org.flashsandy.display.DistortImage
 * @see			http://www.rubenswieringa.com/blog/flex-book-component-beta Rubens blog: Book component beta
 *
 *
 * @internal
 *
 *
 * Credits: dynamic    - Didier Brun
 * 		For making his pageflip rendering class (com.foxaweb.pageflip.PageFlip)
 * 		Site: www.foxaweb.com
 *    - Thomas Pfeiffer (aka Kiroukou)
 * 		For letting me use his distortion class (org.flashsandy.display.DistortImage)
 * 		Site: www.flashsandy.org
 *    - the Factor.e
 * 		For allowing me to publish the demo and the source-code.
 * 		Site: www.tfe.nl
 *    - Maikel Sibbald
 * 		For helping me with (among a lot of things) thinking out the structure of this component. He also made a usage-example of Didier's pageflip class (labs.flexcoders.nl/?p=33) which I used as reference in the early days of the Book class.
 * 		Site: labs.flexcoders.nl
 *    - Theo Aartsma (aka Sumeco)
 * 		For letting me use his artwork in the Book demo.
 * 		Site: www.sumeco.net
 *
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
class BookView extends PageManager {
  /**
   * List in which the BitmapData for Page instance is stored in. Note that after each pageflip this List is cleaned.
   * @
   */
  Map bitmapData = {};

  /**
   * DistortImage instance for rendering hard-back Pages during pageflips.
   * @see	org.flashsandy.display.DistortImage
   * @
   */
  DistortImage distortion;

  /**
   * @
   */
  Point pageCorner = new Point(0, 0);

  /**
   * @
   */
  Point pageCornerTarget = new Point(0, 0);

  /**
   * The direction of the last pageflip. 1 stands for forward flipping (flipping a page from right to left), -1 stands for backward flipping (left to right).
   * @
   */
  int lastFlippedDirection = 0;

  /**
   * The side on which the last flipped Page laid before it was flipped. 0 stands for left, 1 for right.
   * @see	Page#LEFT
   * @see	Page#RIGHT
   * @
   */
  int lastFlippedSide = 0;

  /**
   * The position of the last flipped page-corner. The x-value represents the horizontal value, the y-value represents the vertical value. So (0, 0) would be the upper-left corner, (1, 1) would be the lower right corner, etc.
   * @
   */
  Point lastFlippedCorner;

  /**
   * Stores the timestamp at which a pageflip was started (mouse was pressed).
   * This property is part of the mechanism that decides whether or not a click should fire an automated pageflip.
   * @see	Book#setLastFlippedTime()
   * @
   */
  int lastFlippedTime;

  /**
   * False if the last flipped page fell back into its original position after being flipped. True if it slided over to the opposite side.
   * @
   */
  bool lastFlipSucceeded;

  /**
   * Set by the gotoPage() method as a target-destination.
   * @see	Book#gotoPage()
   * @
   */
  int autoFlipIndex = -1;

  /**
   * False if the current pageflip is performed by the user dragging a pagecorner, true of not.
   * @see	Book#gotoPage()
   * @see	Book#tearPage()
   * @
   */
  bool autoFlipActive = false;

  /**
   * Indicates if an automated pageflip is allowed to be interrupted by the user.
   * @see	Book#gotoPage()
   * @see	Book#tearPage()
   * @
   */
  bool autoFlipCancelable = true;

  /**
   * True if a pageflip is triggered by a mouse-rollover, false if not.
   * @
   */
  bool hoverActive = false;

  /**
   * True if the current pageflip is performed upon a page its side (instead of one of its corners).
   * @see	Book#sideFlip
   * @
   */
  bool sideFlipActive = false;

  /**
   * True if this pageflip consists of a Page being torn out of this Book.
   * @see	Book#tearPage()
   * @
   */
  bool tearActive = false;

  /**
   * The side of the page that is being torn out. 0 stands for left, 1 for right.
   * @see	Book#tearPage()
   * @see	Page#LEFT
   * @see	Page#RIGHT
   * @
   */
  int tearSide;

  /**
   * True if a page is being torn out of the book top-first, false if bottom-first.
   * @see	Book#tearPage()
   * @
   */
  bool tearFromTop;

  /**
   * List of Rectangle instances that indicate the areas by which a page can be flipped.
   * @see	Book#createRegions()
   * @
   */
  List regions = [];

  // internals for accessors:
  /**
   * @see	Book#easing
   * @
   */
  num _easing = 0.3;

  /**
   * @see	Book#hardCover
   * @
   */
  bool _hardCover = true;

  /**
   * @see	Book#hover
   * @
   */
  bool _hoverEnabled;

  /**
   * @see	Book#regionSize
   * @
   */
  int _regionSize = 150;

  /**
   * @see	Book#status
   * @
   */
  String _status;

  // plain  properties
  /**
   * The time (it as milliseconds) takes to finish a pageflip performed by the gotoPage method.
   * The calculated speed will also be used for tearing out Pages.
   * @default	1000
   * @see		Book#gotoPage()
   */
  int autoFlipDuration = 1000;

  /**
   * Whether or not the page should be turned when a page corner is clicked.
   * @default	true
   */
  bool flipOnClick = true;

  /**
   * Amount of perspective in a pageflip of a Page that has its hard property set to true.
   * This value is used as the maximum with which the outer side of a page is extended on both sides (upper and lower) during a hard pageflip.
   * @default	45
   */
  int hardPerspective = 45;

  /**
   * Indicates whether or not this Book plays animation while flipping one of its Pages.
   * When this property is set to true, all Page instances will return true from their liveBitmapping property.
   * Note that enabling liveBitmapping may result in decreased performance.
   * @default	false
   * @see		Page#liveBitmapping
   */
  bool liveBitmapping = false;

  /**
   * Whether or not the outer side of a Page can be used to let it flip.
   * @default	true
   */
  bool sideFlip = true;

  /**
   * If true, no easing will be applied during pageflips.
   * @default	false
   * @see		Book#easing
   */
  bool snap = false;

  /**
   * If true, all Pages will have tearing enabled.
   * @see		Page#tearable
   * @default	false
   */
  bool tearable = false;

  // constants:
  /**
   * @
   */
  static const num AUTO_FLIP_CURVE = 0.15;

  /**
   * @
   */
  static const num SIDE_FLIP_CURVE = 0.04;

  /**
   * @
   */
  static const num MAX_EASING_DIFFERENCE = 0.5;

  /**
   * @
   */
  static const int CLICK_INTERVAL = 300;

  // CONSTRUCTOR:

  /**
   * Constructor.
   */
  BookView(String id) : super(id) {
//			 set initial status:
    this.setStatus(BookEvent.NOT_FLIPPING, false);

    // make sure certain getter/setter values are processed where appropriate:
    this.easing = 0.7;
    this.hover = true;

    // add event listener:
    this.addEventListener(MouseEvent.MOUSE_DOWN, this.startPageFlip);
  }

  // OVERRIDES:

  /**
   * Draw additional graphisc for Pages where necessary.
   *
   * @
   */
  @override
  void init({Map params: null}) {
    super.init(params: params);

    // make sure that non-hard pages whose flipsides are hard don't have fold-gradients:
    for (int i = 0; i < this._pages.length; i++) {
      (this._pages[i] as Page).refreshFoldGradient();
    }

    // create hit regions for page-corners:
    this.createRegions();

    onInitComplete();
  }

  /**
   * Resizes content where needed.
   *
   * @
   */
  @override
  void refresh() {
    super.refresh();

    this.createRegions();
    // now is a good time to create DistortImage since width and height will have been set:
    this.distortion = new DistortImage(spanWidth / 2, spanHeight);
  }

  /**
   * @inheritDoc
   *
   * @
   */
  @override
  void jumpViewStacks(int fromIndex) {
    super.jumpViewStacks(fromIndex);
    for (int i = fromIndex; i < this._pages.length; i++) {
      (this._pages[i] as Page).refreshFoldGradient(false);
    }
  }

  /**
   * @inheritDoc
   */
  @override
  void swapChildren(DisplayObject child1, DisplayObject child2) {
    super.swapChildren(child1, child2);
    List children = [];
    if (child1 is Page) children.add(child1);
    if (child2 is Page) children.add(child2);
    for (int i = 0; i < children.length; i++) {
      children[i].refreshFoldGradient();
    }
  }

  // PAGEFLIP PROCESSING:

  /**
   * Makes preparations for the pageflipping and sets certain listeners, typically called upon mouse-press.
   *
   * @param	event			MouseEvent
   * @param	attemptHover	Indicates whether or not this is a hover (or as true) a regular page-flip (false).
   *
   * @throws	BookError	A BookError is thrown when the flipped page has no flipside.
   * @see		BookError#NO_FLIPSIDE
   *
   * @
   */
  void startPageFlip([MouseEvent event = null, bool attemptHover = false]) {
    int side = this.getCurrentSide();
    Page oldPage = this.getPage(this._currentPage + this.lastFlippedSide, false);

    // no pageflips before creationComplete:
    if (!this.created) {
      return;
    }
    // if the Book was clicked and gotoPage is active then attempt to abort gotoPage:
    if (this.autoFlipActive &&
        !this.tearActive &&
        this.pageCorner.x >= 0 &&
        this.pageCorner.x <= spanWidth / 2 &&
        event != null) {
      this.cancelGotoPage(false);
      return;
    }
    // stop if the clicked SuperViewStack does not show any Pages:
    if (((!this.pageL.visible && side == Page.LEFT) || (!this.pageR.visible && side == Page.RIGHT)) &&
        this._status != BookEvent.PAGEFLIP_STARTED &&
        this._status != BookEvent.PAGEFLIP_ENDING &&
        this._status != BookEvent.HOVER_STARTED &&
        this._status != BookEvent.HOVER_ENDING) {
      return;
    }
    // stop if none of the pagecorners are hit:
    if (!this.isPageCornerHit() && (!this.sideFlip || !this.isPageSideHit()) && !this.autoFlipActive) {
      return;
    }
    // don't flip if Page isn't allowed to:
    if ((this._pages[this._currentPage + side] as Page).lock) {
      this.autoFlipActive = false; // shut-down auto-pageflip if active
      return;
    }
    // stop if a page corner is flipping back into position
    if ((this._status == BookEvent.PAGEFLIP_ENDING || this._status == BookEvent.HOVER_ENDING) &&
        !this.autoFlipActive &&
        !this.lastFlipSucceeded) {
      // switch back to flipping mode if the same page corner was picked up:
      if (this.lastFlippedCorner == (this.getCurrentCorner()) && this.sideFlipActive == this.isPageSideHit()) {
        this.stage.addEventListener(MouseEvent.MOUSE_UP, this.endPageFlip);
        String newStatus = (this.hoverActive) ? BookEvent.HOVER_STARTED : BookEvent.PAGEFLIP_STARTED;
        this.setStatus(newStatus, true, oldPage);
      }
      return;
    }
    // stop if the Book is not inactive and not hovering:
    if (this._status != BookEvent.NOT_FLIPPING && !this.hoverActive) {
      return;
    }
    // if the page is hovering and an actual pageflip should begin:
    if (this.hoverActive && this._status == BookEvent.HOVER_STARTED) {
      this.hoverActive = false;
      this.setLastFlippedTime(); // if necessary, remember time at which pageflip started
      this.setStatus(BookEvent.PAGEFLIP_STARTED, true, oldPage);
      return;
    }

    // throw an Error if the Page in question has no flipside:
    // in the above stated situation the right-hand side Page typically does not have a flipside, and consequently its index will be equal to the total amount of pages (minus one). Also note that any left-hand side Page will always have a flipside, because the first Page in a Book is always on the right-hand side.
    if (this._currentPage + 1 == this._pages.length - 1 && side == Page.RIGHT) {
      throw new BookError(BookError.NO_FLIPSIDE);
    }

    // set hover-flag:
    this.hoverActive = attemptHover;

    // set direction markers and position the render:
    if (this.autoFlipActive && !this.tearActive) this.lastFlippedCorner = new Point(side, 1);
    if (this.autoFlipActive && this.tearActive) this.lastFlippedCorner = new Point(side, (this.tearFromTop) ? 0 : 1);
    if (!this.autoFlipActive) this.lastFlippedCorner = this.getCurrentCorner();
    this.lastFlippedSide = this.lastFlippedCorner.x;
    this.lastFlippedDirection = (side == Page.LEFT) ? -1 : 1;
    this.sideFlipActive = (!this.tearActive && this.sideFlip && this.isPageSideHit());
    this.renderShape.x = this.lastFlippedSide * spanWidth / 2;

    // specify front and flipside indexes:
    int frontIndex = this._currentPage + this.lastFlippedSide;
    int backIndex = this._currentPage + this.lastFlippedSide + this.lastFlippedDirection;
    // save bitmapData:
    this.saveBitmapData((this._pages[frontIndex] as Page), (this._pages[backIndex]) as Page);

    // select pages in SuperViewStacks:
    if (this.lastFlippedSide == Page.LEFT) {
      // if left-hand page was flipped
      this.pageL.visible = !this.isFirstPage(this._currentPage + 1 - 2);
      if (this.pageL.visible) {
        this.pageL.selectedChild = (this._pages[this._currentPage - 2] as Sprite);
      } else {}
    }
    if (this.lastFlippedSide == Page.RIGHT) {
      // if right-hand page was flipped
      this.pageR.visible = !this.isLastPage(this._currentPage + 2);
      if (this.pageR.visible) {
        this.pageR.selectedChild = (this._pages[this._currentPage + 1 + 2] as Sprite);
      }
    }

    // set page corner markers:
    this.pageCorner = new Point(this.lastFlippedCorner.x * spanWidth / 2, this.lastFlippedCorner.y * spanHeight);
    if (this.autoFlipActive) {
      this.pageCornerTarget = this.pageCorner.clone();
    }

    // if necessary, remember time at which pageflip started:
    this.setLastFlippedTime();

    // set status:
    this.setStatus((this.hoverActive) ? BookEvent.HOVER_STARTED : BookEvent.PAGEFLIP_STARTED,
        false); // false = dispatch Event later

    // add listeners:
    this.dragPageCorner();
    this.addEventListener(Event.ENTER_FRAME, this.dragPageCorner);
    this.stage.addEventListener(MouseEvent.MOUSE_UP, this.endPageFlip);

    // dispatch event:
    Page page = (this._pages[this._currentPage + this.lastFlippedSide] as Page);
    if (this.hoverActive) {
      this.dispatchEvent(new BookEvent(BookEvent.HOVER_STARTED, this, page));
    } else {
      this.dispatchEvent(new BookEvent(BookEvent.PAGEFLIP_STARTED, this, page));
    }
  }

  /**
   * Performs the actual pageflip effect, typically called upon enter-frame.
   *
   * @see		com.foxaweb.pageflip.PageFlip#computeFlip()
   * @see		com.foxaweb.pageflip.PageFlip#drawBitmapSheet()
   *
   * @param	event	Event
   *
   * @
   */
  void dragPageCorner([Event event = null]) {
    // stop if the startPageFlip() or endPageFlip() have not been executed:
    if (this._status != BookEvent.PAGEFLIP_STARTED &&
        this._status != BookEvent.HOVER_STARTED &&
        this._status != BookEvent.PAGEFLIP_ENDING &&
        this._status != BookEvent.HOVER_ENDING) {
      return;
    }

    // create faux mouse to create easing:
    if (this._status == BookEvent.PAGEFLIP_STARTED || this._status == BookEvent.HOVER_STARTED) {
      if (this.movePageCornerTarget() && this.autoFlipActive) {
        this.endPageFlip();
        return;
      }
    }
    this.movePageCorner();

    // clear render:
    this.renderShape.graphics.clear();

    // check if the pageflip has ended:
    if (this.pageCorner == (this.pageCornerTarget) &&
        (this._status == BookEvent.PAGEFLIP_ENDING || this._status == BookEvent.HOVER_ENDING)) {
      this.finishPageFlip();
      return;
    }

    // specify front and flipside indexes:
    int frontIndex = this._currentPage + this.lastFlippedSide;
    int backIndex = this._currentPage + this.lastFlippedSide + this.lastFlippedDirection;
    Page front = (this._pages[frontIndex] as Page);
    Page back = (this._pages[backIndex] as Page);

    // if liveBitmapping is enabled, refresh corresponding values in bitmapData List:
    this.saveBitmapData(front, back);
//			if (front.liveBitmapping || back.liveBitmapping){
//			}

    // perform pageflip:
    if (!front.explicitHard && !back.explicitHard) {
      Map ocf = PageFlip.computeFlip(this.pageCorner.clone(), this.lastFlippedCorner, (spanWidth / 2).round(),
          spanHeight.round(), !this.tearActive, 1);
      this.addSmoothGradients(ocf);
      PageFlip.drawBitmapSheet(ocf, this.renderShape, this.bitmapData[frontIndex], this.bitmapData[backIndex]);
      // add shadows or highlights to the render:
//				this.addSmoothGradients(ocf);
      // take ocf and find out whether we should start tearing this Page off:
      if (this._status == BookEvent.PAGEFLIP_STARTED &&
          (this._pages[this._currentPage + this.lastFlippedSide] as Page).tearable &&
          ocf["cPoints"] != null) {
        this.evaluateTear(ocf["cPoints"][2].clone());
      }
    } else {
      this.drawHardPage(this.bitmapData[frontIndex], this.bitmapData[backIndex]);
    }
  }

  /**
   * Makes preparations for the end of the pageflip effect, typically called upon mouse-release.
   *
   * @param	event	MouseEvent
   *
   * @
   */
  void endPageFlip([MouseEvent event = null]) {
    // stop if the Book is not currently performing a pageflip:
    if (this._status != BookEvent.PAGEFLIP_STARTED && this._status != BookEvent.HOVER_STARTED) {
      return;
    }
    // ignore mouse-up event if a Page is being torn out of the Book:
    if (this.tearActive && event != null) {
      return;
    }

    // turn page if flipOnClick is enabled:
    if (this.flipOnClick && this.flipOnRelease && event != null) {
      this.gotoPage((this._currentPage + this.lastFlippedDirection * 2)
          .toInt()); // cast to int because gotoPage has its page parameter typed with a * and will assume the value is an int, and thus change any negative values to positives
      return;
    }

    // remove mouse-listener:
    this.stage.removeEventListener(MouseEvent.MOUSE_UP, this.endPageFlip);

    // make sure page corner slides to the appropriate position:
    if (!this.tearActive) {
      num x;
      num y = this.lastFlippedCorner.y * spanHeight;
      if (this.lastFlippedSide == Page.LEFT) {
        // if left-hand page was flipped
        this.lastFlipSucceeded = (this.pageCornerTarget.x > spanWidth / 2);
        x = (this.lastFlipSucceeded) ? spanWidth : 0;
      } else {
        // if right-hand page was flipped
        this.lastFlipSucceeded = (this.pageCornerTarget.x < 0);
        x = (this.lastFlipSucceeded) ? -spanWidth / 2 : spanWidth / 2;
      }
      this.pageCornerTarget = new Point(x, y);
    } else {
      this.lastFlipSucceeded = false;
    }

    // set status and dispatch event:
    String newStatus = (this._status == BookEvent.HOVER_STARTED) ? BookEvent.HOVER_ENDING : BookEvent.PAGEFLIP_ENDING;
    Page page = (this._pages[this._currentPage + this.lastFlippedSide] as Page);
    this.setStatus(newStatus, true, page);
  }

  /**
   * Ends the pageflip effect and displays the interactive content in the SuperViewStacks.
   *
   * @
   */
  void finishPageFlip() {
    // stop is endFlip() has not already been called:
    if (this._status != BookEvent.PAGEFLIP_ENDING && this._status != BookEvent.HOVER_ENDING) {
      return;
    }

    // stop the dragPageCorner() method from being executed:
    this.removeEventListener(Event.ENTER_FRAME, this.dragPageCorner);

    // remember current Page for Events dispatched later:
    Page page = (this._pages[this._currentPage + this.lastFlippedSide] as Page);

    bool wasLastPage = false;

    // remove Pages if they were torn out:
    if (this.tearActive) {
      bool wasLastPage = this.isLastPage(this._currentPage);
      this.removeChild(page.getFlipSide());
      this.removeChild(page);
    }

    // if the page has been flipped over, change the _currentPage property:
    if (this.lastFlipSucceeded && !this.tearActive) {
      // lastFlipSucceeded is always false when a Page was torn, but this makes the code more readable
      this._currentPage += this.lastFlippedDirection * 2;
    }
    // change _currentPage where appropriate after a page-tear:
    if (this.tearActive && this.lastFlippedSide == Page.LEFT && !wasLastPage) {
      this._currentPage -= 2;
    }

    // make sure the SuperViewStacks display the right Pages
    this.refreshViewStacks();

    // set status:
    this.setStatus(BookEvent.NOT_FLIPPING, true, page,
        (this.hoverActive) ? BookEvent.HOVER_FINISHED : BookEvent.PAGEFLIP_FINISHED);

    // dispatch additional events:
    if (!this.hoverActive) {
      if (!this.tearActive) {
        if (this.lastFlipSucceeded) {
          this.dispatchEvent(new BookEvent(BookEvent.PAGE_TURNED, this, page));
          if ((this.lastFlippedSide == Page.RIGHT && this._currentPage == 1) ||
              (this.lastFlippedSide == Page.LEFT && this._currentPage == this._pages.length - 3)) {
            this.dispatchEvent(new BookEvent(BookEvent.BOOK_OPENED, this));
          }
          if ((this.lastFlippedSide == Page.LEFT && this._currentPage == -1) ||
              (this.lastFlippedSide == Page.RIGHT && this._currentPage == this._pages.length - 1)) {
            this.dispatchEvent(new BookEvent(BookEvent.BOOK_CLOSED, this));
          }
        } else {
          this.dispatchEvent(new BookEvent(BookEvent.PAGE_NOT_TURNED, this, page));
        }
      } else {
        this.dispatchEvent(new BookEvent(BookEvent.PAGE_TORN, this, page));
      }
    }

    // if this was a pageflip triggered by gotoPage then switch back to normal mode:
    if (this.autoFlipActive) {
      if (this.tearActive) {
        this.tearActive = false;
        this.autoFlipActive = false;
      } else {
        if (this._currentPage == this.autoFlipIndex) {
          this.autoFlipActive = false;
        } else {
          this.startPageFlip();
        }
      }
    }

    // turn off flags:
    this.hoverActive = false;
    this.sideFlipActive = false;
    this.tearActive = false;
  }

  /**
   * Draws a hardcover Page, similar to the drawBitmapSheet method of the PageFlip class.
   *
   * @see		com.foxaweb.pageflip.PageFlip#drawBitmapSheet()
   *
   * @param	front	BitmapData of the facing side of a sheet
   * @param	back	BitmapData of the flipside of a sheet
   *
   * @
   *
   */
  void drawHardPage(BitmapData front, BitmapData back) {
    // calculate position correction:
    num w;
    if (this.lastFlippedDirection == 1) {
      w = this.pageCorner.x - (1 - this.lastFlippedSide) * spanWidth / 2;
    } else {
      w = this.pageCorner.x - spanWidth / 2;
    }
    if (w < -spanWidth / 2) w = -spanWidth / 2;
    if (w > spanWidth / 2) w = spanWidth / 2;

    // calculate perspective:
    num closeness = sin(acos(w / (spanWidth / 2)));

    // define positions of page-corners:
    List pPoints = [];
    pPoints.add(new Point((1 - this.lastFlippedSide) * spanWidth / 2, 0));
    pPoints.add(new Point(pPoints[0].x + w, 0 - closeness * this.hardPerspective));
    pPoints.add(new Point(pPoints[0].x + w, spanHeight + closeness * this.hardPerspective));
    pPoints.add(new Point((1 - this.lastFlippedSide) * spanWidth / 2, spanHeight));

    // make sure the first Point in the List is always the top-right, etc:
    List p = [];
    p.add((pPoints[0].x < pPoints[1].x) ? pPoints[0] : pPoints[1]);
    p.add((pPoints[0].x > pPoints[1].x) ? pPoints[0] : pPoints[1]);
    p.add((pPoints[2].x > pPoints[3].x) ? pPoints[2] : pPoints[3]);
    p.add((pPoints[2].x < pPoints[3].x) ? pPoints[2] : pPoints[3]);

    // draw page:
    BitmapData bmd;
    if (this.lastFlippedSide == 0) {
      bmd = (this.pageCorner.x > spanWidth / 2) ? back : front;
    } else {
      bmd = (this.pageCorner.x < 0) ? back : front;
    }
    this.distortion.setTransform(this.renderShape.graphics, bmd, p[0], p[1], p[2], p[3]);

    // draw gradients:
    this.addHardGradients(pPoints);
  }

  /**
   * Considers a hover-effect for the four outer page-corners. This method is typically called upon enter-frame.
   *
   * @param	event	Event
   *
   * @
   */
  void evaluateHover([Event event = null]) {
    if (!_initialized) {
      return;
    }

    int side = this.getCurrentSide();
    bool pageCornerHit = this.isPageCornerHit();

    // if the hovered ViewStack does not display any Pages:
    if (((side == Page.LEFT && !this.pageL.visible) || (side == Page.RIGHT && !this.pageR.visible)) &&
        (!this.hoverActive || this._status == BookEvent.HOVER_ENDING)) {
      return;
    }
    // don't hover hard Pages:
    if ((this._pages[this._currentPage + side] as Page).hard) {
      return;
    }

    // roll over:
    if ((pageCornerHit || (this.sideFlip && this.isPageSideHit())) &&
        ((!this.hoverActive && this._status == BookEvent.NOT_FLIPPING) || this._status == BookEvent.HOVER_ENDING)) {
      this.startPageFlip(null, true);
    }
    // roll out:
    if (!pageCornerHit && (!this.sideFlip || !this.isPageSideHit()) && this.hoverActive) {
      this.endPageFlip();
    }
  }

  /**
   * Looks at a provided Point and considers tearing off the Page currently being flipped. This method is typically called from within the dragPageCorner method.
   *
   * @param	point	Point used to evaluate whether or not this Page should be torn out of this Book.
   *
   * @see		Book#dragPageCorner()
   *
   * @
   */
  void evaluateTear(Point point) {
    // no evaluation necessary if the Book has not even started flipping yet:
    if (this._status != BookEvent.PAGEFLIP_STARTED) {
      return;
    }
    // stop if an auto-flip or page-tear is already active:
    if (this.tearActive || this.autoFlipActive) {
      return;
    }

    // evaluate:
    if ((point.x).round() == (1 - this.lastFlippedCorner.x) * spanWidth / 2 &&
        (point.y).round() == this.lastFlippedCorner.y * spanHeight) {
      this.tearActive = true;
      this.autoFlipActive = true;
      this.autoFlipCancelable = false;
    }
  }

  /**
   * Performs a pageflip without the user having to drag the pagecorner.
   *
   * @param	page		int/int or Page, indicating the index or instance of a Page.
   * @param	cancelable	Indicates whether or not this auto-flip should allow cancelGotoPage to be called.
   *
   * @see		Book#cancelGotoPage()
   * @see		Book#autoFlipDuration
   *
   * @throws	BookError		Gets thrown when the child parameter is not an instance of the Page class nor a int/int.
   * @see		BookError#CHILD_NOT_PAGE
   *
   * @throws	ArgumentsError	Gets thrown when the child parameter is not a child of this Book.
   * @see		BookError#PAGE_NOT_CHILD
   *
   */
  void gotoPage(dynamic page, [bool cancelable = true]) {
    page = this.getPageIndex(page, true);
    if (page % 2 != 1 && page != -1) page -= 1;

    // return if we're already at the specified Page:
    if (this._currentPage == page) {
      return;
    }

    // set target index and start pageflip:
    this.autoFlipIndex = page;
    this.autoFlipCancelable = cancelable;
    if (!this.autoFlipActive) {
      this.autoFlipActive = true;
      this.startPageFlip();
    }
  }

  /**
   * Aborts a pageflip started by the gotoPage method.
   *
   * @param	finishFlip	bool indicating whether or not to allow the auto-flip to finish. When true, the pageflip will finish. When false, the auto-flip will immediately stop, and the page corner will start sticking to the mouse.
   *
   * @see		Book#gotoPage()
   *
   */
  void cancelGotoPage([bool finishFlip = true]) {
    // stop if gotoPage is not active:
    if (!this.autoFlipActive) {
      return;
    }
    // stop if gotoPage is not cancelable:
    if (!this.autoFlipCancelable) {
      return;
    }

    // end the auto-flip:
    if (finishFlip != null || finishFlip == true) {
      this.autoFlipIndex = this._currentPage + 2 * this.lastFlippedDirection;
    } else {
      this.autoFlipActive = false;
    }
  }

  /**
   * Performs a pageflip to the next page, without the user having to drag the pagecorner.
   *
   * @see		Book#gotoPage()
   * @see		Book#autoFlipDuration
   *
   */
  void nextPage() {
    if (this._currentPage + 2 <= this._pages.length - 1) {
      this.gotoPage(this._currentPage + 2, false);
    }
  }

  /**
   * Performs a pageflip to the previous page, without the user having to drag the pagecorner.
   *
   * @see		Book#gotoPage()
   * @see		Book#autoFlipDuration
   *
   */
  void prevPage() {
    if (this._currentPage - 2 >= -1) {
      this.gotoPage(this._currentPage - 2, false);
    }
  }

  /**
   * Tears a Page out of this Book instance. When called, this method will be executed regardless of the value of the Page its tearable property.
   * Fails silently if the provided Page is not one of the currently visible Pages.
   *
   * @param	page	int/int or Page, indicating the index or instance of a Page to be torn out of this Book.
   * @param	fromTop	If true, the Page will be torn out by its upper outer corner, if false by its lower outer corner.
   *
   * @see		Book#tearPage()
   * @see		Page#tearable
   *
   * @throws	ArgumentError	Gets thrown when page is an index-value and out of bounds.
   * @see		BookError#OUT_OF_BOUNDS
   */
  void tearPage(dynamic page, [bool fromTop = true]) {
    page = this.getPage(page, true);

    // stop if we're not currently inactive or hovering:
    if (this._status != BookEvent.NOT_FLIPPING && this._status != BookEvent.HOVER_STARTED) {
      return;
    }
    // fail silently if the provided Page is not one of the currently visible Pages:
    if (page.index != this._currentPage && page.index != this._currentPage + 1) {
      return;
    }
    // don't tear hard Pages:
    if (page.hard) {
      return;
    }

    // set vars to let the pageflip processing methods know that we're tearing:
    this.tearActive = true;
    this.tearSide = page.side;
    this.tearFromTop = fromTop;
    this.autoFlipActive = true;
    this.autoFlipCancelable = false;
    this.startPageFlip();
  }

  // GRADIENTS:

  /**
   * Adds shadows and highlights to the pageflip process of a hard Page.
   *
   * @param	area	List of coordinates (Point instance) indicating the outlines of the flipping page
   *
   * @see		Gradients#drawOutside()
   * @see		Gradients#drawInside()
   *
   * @
   */
  void addHardGradients(List area) {
    // determine page:
    Page page = (this._pages[this._currentPage + this.lastFlippedSide] as Page);

    // determine shadow or highlight:
    String tint;
    if (this.lastFlippedSide == Page.LEFT) {
      // if left-hand page was flipped
      tint = (this.pageCornerTarget.x > spanWidth / 2) ? Gradients.DARK : Gradients.LIGHT;
    } else {
      // if right-hand page was flipped
      tint = (this.pageCornerTarget.x < 0) ? Gradients.LIGHT : Gradients.DARK;
    }

    // draw gradients:
    page.gradients.drawOutside(this.renderShape.graphics, area, tint);
    page.gradients.drawInside(this.renderShape.graphics, area, tint);
  }

  /**
   * Adds shadows and highlights to the pageflip process of a non-hard Page.
   *
   * @see		com.foxaweb.pageflip.PageFlip#computeFlip()
   * @see		com.foxaweb.pageflip.PageFlip#drawBitmapSheet()
   *
   * @see		Gradients#drawFlipside()
   * @see		Gradients#drawOutside()
   * @see		Gradients#drawInside()
   *
   * @param	ocf		Map returned by the computeFlip method of the PageFlip class
   *
   * @
   */
  void addSmoothGradients(Map ocf) {
    // determine page:
    Page page = (this._pages[this._currentPage + this.lastFlippedSide] as Page);

    // determine rotation correction:
    num rotate;
    if (this.lastFlippedCorner == (new Point(1, 0)) || this.lastFlippedCorner == (new Point(0, 1))) {
      // if the upper right or lower left corner is being flipped and the Page isn't torn out of its Book, correct the angle with 45 degrees:
      rotate = (!this.tearActive) ? Gradients.ROTATE_HALF : Gradients.ROTATE_FULL;
    }
    if (this.lastFlippedCorner == (new Point(0, 0)) || this.lastFlippedCorner == (new Point(1, 1))) {
      // if the upper left or lower right corner is being flipped and the Page isn't torn out of its Book, correct the angle with minus 45 degrees:
      rotate = (!this.tearActive) ? Gradients.ROTATE_FULL : Gradients.ROTATE_HALF;
    }

    // determine shadow or highlight:
    String tint1 = (this.lastFlippedSide == 1) ? Gradients.LIGHT : Gradients.DARK;
    String tint2 = (this.lastFlippedSide == 1) ? Gradients.DARK : Gradients.LIGHT;

    // draw gradients:
    if (ocf["cPoints"] != null) page.gradients.drawFlipside(this.renderShape.graphics, ocf["cPoints"], tint1, rotate);
    if (ocf["pPoints"] != null) page.gradients.drawOutside(this.renderShape.graphics, ocf["pPoints"], tint1, rotate);
    if (ocf["cPoints"] != null && !this.tearActive) page.gradients
        .drawInside(this.renderShape.graphics, ocf["cPoints"], tint2, rotate);
  }

  // PAGEFLIP ASSISTANCE:

  /**
   * Sets the position of the pageCorner property.
   *
   * @return	bool indicating, if the gotoPage method is active, whether or not pageCornerTarget has reached the opposite corner. If gotoPage is not active, the return value will always be false.
   *
   * @see	Book#movePageCorner()
   * @see	Book#gotoPage()
   *
   * @
   */
  bool movePageCornerTarget() {
    num x;
    num y;

    // if gotoPage is not active then set the page corner target equal to the mouse position:
    if (!this.autoFlipActive) {
      // calculate coordinates:
      x = this.mouseX;
      y = (!this.sideFlipActive) ? this.mouseY : this.lastFlippedCorner.y * spanHeight;
      // adjust x per position of render:
      if (this.lastFlippedSide == Page.RIGHT) {
        x -= (spanWidth / 2);
      }
      // adjust x and y if a side-flip is active:
      if (this.sideFlipActive) {
        // adjust x so that pageflip won't start acting weird when mouse is out of bounds:
        num xMin = 0 - this.lastFlippedSide * (spanWidth / 2);
        num xMax = xMin + spanWidth;
        if (x < xMin) x = xMin;
        if (x > xMax) x = xMax;
        // adjust y to make the pageflip a bit more pretty:
        if (!this.hoverActive) {
          y = this.getPageCornerYFromX(x, BookView.SIDE_FLIP_CURVE);
        }
      }
      // set position:
      this.pageCornerTarget = new Point(x, y);
    }

    // if gotoPage is active then move the page corner target to the opposite corner:
    if (this.autoFlipActive) {
      // calculate coordinates:
      x = (!this.tearActive) ? this.pageCornerTarget.x : this.lastFlippedSide * (spanWidth / 2);
      y = this.pageCornerTarget.y;
      Point opposite = new Point(0, 0);
      // if this is a normal auto-flip:
      if (!this.tearActive) {
        opposite.x = this.lastFlippedSide * (spanWidth / 2) - spanWidth * this.lastFlippedDirection;
        if ((x - opposite.x).abs() >= this.autoFlipSpeed) {
          x += this.autoFlipSpeed * -this.lastFlippedDirection;
        } else {
          x = opposite.x;
        }
        y = this.getPageCornerYFromX(x);
      }
      // if this is a tearing auto-flip:
      if (this.tearActive) {
        num directionY = (this.lastFlippedCorner.y == 0) ? 1 : -1;
        opposite.y = (spanHeight / 2) + (spanHeight * 1.5 * directionY);
        if ((y - opposite.y).abs() >= this.autoFlipSpeed) {
          y += this.autoFlipSpeed * directionY;
        } else {
          y = opposite.y;
        }
      }
      // set position:
      this.pageCornerTarget = new Point(x, y);
      // return true if pageCornerTarget has reached the opposite corner of where it started:
      if (this.pageCornerTarget == (this.pageCorner) &&
          ((this.tearActive && y == opposite.y) || (!this.tearActive && x == opposite.x))) {
        return true;
      }
    }

    // return value:
    return false;
  }

  /**
   * Moves the property pageCorner towards the position of pageCornerTarget.
   *
   * @see	Book#movePageCornerTarget()
   *
   * @
   */
  void movePageCorner() {
    // calculate differences:
    Point corner = this.pageCorner;
    Point target = this.pageCornerTarget;
    num diffX = target.x - corner.x;
    num diffY = target.y - corner.y;

    // apply easing if difference is substantial:
    if (Point.distance(this.pageCorner, this.pageCornerTarget) > BookView.MAX_EASING_DIFFERENCE &&
        (!this.snap || (this._status != BookEvent.PAGEFLIP_STARTED && this._status != BookEvent.HOVER_STARTED))) {
      this.pageCorner.x += diffX * this._easing;
      this.pageCorner.y += diffY * this._easing;
    } else {
      this.pageCorner = this.pageCornerTarget.clone();
    }

    // make sure pageCorner is within bounds so no weird animation will result:
    if ((this._status == BookEvent.PAGEFLIP_ENDING || this._status == BookEvent.HOVER_ENDING) && !this.tearActive) {
      if (this.pageCorner.y < 0) this.pageCorner.y = 0;
      if (this.pageCorner.y > spanHeight) this.pageCorner.y = spanHeight;
    }
  }

  /**
   * Stores a Page its BitmapData in the bitmapData List.
   *
   * @param	front	Facing side of a sheet
   * @param	back	Flipside of a sheet
   *
   * @
   */
  void saveBitmapData(Page front, Page back) {
    back.hideFoldGradient();
    this.bitmapData = {}; // dispose of BitmapData of pages we won't need right now
    this.bitmapData[front.index] = front.getBitmapData();
    this.bitmapData[back.index] = back.getBitmapData();
    back.showFoldGradient();
  }

  /**
   * Returns a Point instance indicating the current corner in which the mouse is.
   *
   * @return	Point
   *
   * @
   */
  Point getCurrentCorner() {
    Point corner = new Point(0, 0);
    // determine corner:
    corner.x = (this.mouseX < spanWidth / 2) ? 0 : 1;
    corner.y = (this.mouseY < spanHeight / 2) ? 0 : 1;
    // return value:
    return corner;
  }

  /**
   * Returns a Point instance indicating the corner that was last flipped.
   *
   * @return	Point
   */
  Point getLastFlippedCorner() {
    return this.lastFlippedCorner;
  }

  /**
   * Returns true if any of the four outer page-corners contain a specified Point.
   *
   * @param	point	Point checked for presence within any of the outer corners. If no value is provided then the mouse coordinates will be used.
   *
   * @return	bool
   *
   * @see		Book#isPageSideHit()
   *
   * @
   */
  bool isPageCornerHit([Point point = null]) {
    // if no point was provided, use the mouse coordinates:
    if (point == null) {
      point = new Point(this.mouseX, this.mouseY);
    }
    // return value:
    if (Geom.isPointInCorner(this.regions[0]["TL"], point, Geom.TL) ||
        Geom.isPointInCorner(this.regions[0]["BL"], point, Geom.BL) ||
        Geom.isPointInCorner(this.regions[1]["TR"], point, Geom.TR) ||
        Geom.isPointInCorner(this.regions[1]["BR"], point, Geom.BR)) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * Returns true if any of the two outer page-sides contain a specified Point.
   *
   * @param	point	Point checked for presence within any of the outer corners. If no value is provided then the mouse coordinates will be used.
   *
   * @return	bool
   *
   * @see		Book#isPageCornerHit()
   *
   * @
   */
  bool isPageSideHit([Point point = null]) {
    // if no point was provided, use the mouse coordinates:
    if (point == null) {
      point = new Point(this.mouseX, this.mouseY);
    }
    // return value:
    if (this.regions[0]["side"].containsPoint(point) || this.regions[1]["side"].containsPoint(point)) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * Returns an integer indicating the current side at which a pageflip should start.
   *
   * @see		Page#LEFT
   * @see		Page#RIGHT
   *
   * @return	Current side at which a pageflip should start.
   *
   * @
   */
  int getCurrentSide() {
    int side;
    if (!this.autoFlipActive) {
      side = (this.mouseX <= spanWidth / 2) ? Page.LEFT : Page.RIGHT;
    } else {
      if (!this.tearActive) {
        side = (this.autoFlipIndex < this._currentPage) ? Page.LEFT : Page.RIGHT;
      } else {
        side = this.tearSide;
      }
    }
    return side;
  }

  /**
   * Sets the time at which a pageflip started, if necessary.
   *
   * @
   */
  void setLastFlippedTime() {
    if (this.flipOnClick && !this.autoFlipActive) {
      this.lastFlippedTime = /*getTimer()*/
          (RdEnvironment.STAGE.elapsedTime * 1000).round();
    }
  }

  /**
   * Sets _status property and dispatches a BookEvent.
   *
   * @param	newStatus		New status.
   * @param	dispatchEvent	bool indicating whether or not a BookEvent should be dispatched.
   * @param	eventType		eventType for the dispatched Event. If not provided, the new status value will be used.
   *
   * @see		BookEvent
   *
   * @
   */
  void setStatus(String newStatus, [bool dispatchEvent = true, Page page = null, String eventType = ""]) {
    if (this._status != newStatus) {
      this._status = newStatus;
      this.dispatchEvent(new BookEvent(BookEvent.STATUS_CHANGED, this));
    }
    if (dispatchEvent != null || dispatchEvent == true) {
      if (eventType == "") eventType = newStatus;
      this.dispatchEvent(new BookEvent(eventType, this, page));
    }
  }

  /**
   * Calculates a y value for pageCornerTarget at the hand of its x value. The nearer the x value is to the horizontal middle of the Book, the nearer the calculated y will be to the vertical middle of the Book. This method is typically used by the movePageCornerTarget method.
   *
   * @param	x		Current x position of pageCornerTarget.
   * @param	curve	The maximum offset from the top or bottom of the Book, measured in a decimal value (for example, 0.25 means 25% of the Book its height). Typically this value is either AUTO_FLIP_CURVE or SIDE_FLIP_CURVE.
   *
   * @return	The calculated y value.
   *
   * @see		Book#movePageCornerTarget()
   * @see		Book#AUTO_FLIP_CURVE
   * @see		Book#SIDE_FLIP_CURVE
   *
   * @
   */
  num getPageCornerYFromX(num x, [num curve = BookView.AUTO_FLIP_CURVE]) {
    num middleX = this.lastFlippedSide * (spanWidth / 2) - (spanWidth / 2) * this.lastFlippedDirection;
    num progress = (middleX - x) / (spanWidth / 2).abs();
    num y;
    if (this.lastFlippedCorner.y == 0) {
      y = spanHeight * curve * (1 - progress);
    } else {
      y = spanHeight * (1 - curve) + progress * (spanHeight * curve);
    }
    return y;
  }

  // ACCESSORS:

  /**
   * Typically called by the endPageFlip method to find out whether the page was either dragged or clicked. In the case of the latter the gotoPage method should be called.
   * @see	Book#endPageFlip()
   * @see	Book#gotoPage()
   * @
   */
  bool get flipOnRelease {
    if (this.flipOnClick && !this.autoFlipActive) {
      return (/*getTimer()*/
          (RdEnvironment.STAGE.elapsedTime * 1000) - this.lastFlippedTime <= BookView.CLICK_INTERVAL);
    } else {
      return false;
    }
  }

  /**
   * The distance the pageCornerTarget travels along its x axis when gotoPage is active, calculated at the hand of the autoFlipDuration property.
   * @see		Book#gotoPage()
   * @see		Book#tearPage()
   * @see 	Book#autoFlipDuration
   * @
   */
  int get autoFlipSpeed {
    return (spanWidth / ((this.autoFlipDuration / 1000) * 20)).round();
  }

  /**
   * The precision with which the page-corner follows the mouse during a pageflip. Values range from 0 (no easing) to 1 (heavy easing).
   * @default	0.7
   */
  num get easing {
    return (1 - this._easing) / 0.9;
  }

  void set easing(num value) {
    if (value < 0) value = 0;
    if (value > 1) value = 1;
    this._easing = 1 - (value * 0.9);
  }

  /**
   * If true, the first and last Pages in this Book will be hard, regardless of the value of their own hard properties.
   * @default	true
   */
  bool get hardCover {
    return this._hardCover;
  }

  void set hardCover(bool value) {
    // return if there is no change in value:
    if (this._hardCover == value) {
      return;
    }
    // set value:
    this._hardCover = value;
    // erase or draw fold gradient for first and last Pages:
    if (StateManager.instance.getState(this) >= StateManager.CREATION_COMPLETE) {
      (this._pages[0] as Page).refreshFoldGradient();
      (this._pages[this._pages.length - 1] as Page).refreshFoldGradient();
    }
  }

  /**
   * Set this property to false if the four outer page-corners should not display a subtle flip-effect on mouse-over. Note that Pages with their hard property set to true do not display hover-effects at all.
   * @default	true
   */
  bool get hover {
    return this._hoverEnabled;
  }

  void set hover(bool value) {
    // return if there is no change in value:
    if (this._hoverEnabled == value) {
      return;
    }
    // set value:
    this._hoverEnabled = value;
    // add/remove listeners:
    if (this._hoverEnabled) {
      this.addEventListener(Event.ENTER_FRAME, this.evaluateHover);
    } else {
      this.removeEventListener(Event.ENTER_FRAME, this.evaluateHover);
    }
  }

  /**
   * Size of the hit-regions in the pagecorners.
   * @default	150
   */
  int get regionSize {
    return this._regionSize;
  }

  void set regionSize(int value) {
    this._regionSize = value;
    this.createRegions();
  }

  /**
   * Creates an List with hit-regions for pagecorners.
   *
   * @
   */
  void createRegions() {
    // specify regions for left-hand page:
    this.regions.add(new Map());
    this.regions[0]["TL"] = new Rectangle(0, 0, this._regionSize, this._regionSize);
    this.regions[0]["TR"] = new Rectangle(0, 0, this._regionSize, this._regionSize);
    this.regions[0]["BR"] = new Rectangle(0, 0, this._regionSize, this._regionSize);
    this.regions[0]["BL"] = new Rectangle(0, 0, this._regionSize, this._regionSize);
    this.regions[0]["TR"].x += spanWidth / 2 - this.regionSize;
    this.regions[0]["BR"].x += spanWidth / 2 - this.regionSize;
    this.regions[0]["BR"].y += spanHeight - this.regionSize;
    this.regions[0]["BL"].y += spanHeight - this.regionSize;
    // specify regions for right-hand page:
    this.regions.add(new Map());
    this.regions[1]["TL"] = new Rectangle(spanWidth / 2, 0, this._regionSize, this._regionSize);
    this.regions[1]["TR"] = new Rectangle(spanWidth / 2, 0, this._regionSize, this._regionSize);
    this.regions[1]["BR"] = new Rectangle(spanWidth / 2, 0, this._regionSize, this._regionSize);
    this.regions[1]["BL"] = new Rectangle(spanWidth / 2, 0, this._regionSize, this._regionSize);
    this.regions[1]["TR"].x += spanWidth / 2 - this.regionSize;
    this.regions[1]["BR"].x += spanWidth / 2 - this.regionSize;
    this.regions[1]["BR"].y += spanHeight - this.regionSize;
    this.regions[1]["BL"].y += spanHeight - this.regionSize;
    // specify side-flip regions for both pages:
    this.regions[0]
        ["side"] = new Rectangle(0, (spanHeight - this._regionSize) / 2, this._regionSize / 2, this._regionSize);
    this.regions[1]["side"] = this.regions[0]["side"].clone();
    this.regions[0]["side"].x = spanWidth - this._regionSize / 2;
  }

  /**
   * Current status of the Book.
   * @see		BookEvent#PAGEFLIP_STARTED
   * @see		BookEvent#NOT_FLIPPING
   * @see		BookEvent#PAGEFLIP_ENDING
   */
  // [Bindable(event='statusChanged')]
  String get status {
    return this._status;
  }
}
