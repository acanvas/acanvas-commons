part of stagexl_commons;

/**
 * Event class specifying type property values for Events broadcasted by the Book class.
 *
 * @author		Ruben Swieringa
 * 				ruben.swieringa@gmail.com
 * 				www.rubenswieringa.com
 * 				www.rubenswieringa.com/blog
 * @version		1.0.0
 * @see			Book Book
 *
 *
 * @internal
 *
 * edit 3
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
class BookEvent extends Event {
  /**
   * @
   */
  PageManager _pageManager;

  /**
   * @
   */
  Page _page;

  /**
   * Dispatched when the the corner of a page is picked up.
   */
  static final String PAGEFLIP_STARTED = "pageflipStarted";

  /**
   * Dispatched when the corner of a page is released. Note that this Event is dispatched just before the page starts falling back in place.
   * @see	BookEvent#PAGEFLIP_FINISHED
   */
  static final String PAGEFLIP_ENDING = "pageflipEnding";

  /**
   * Dispatched when a page falls back in place after being flipped. This Event is dispatched regardless of whether or not the page has been turned, or has fallen back into its original position.
   * @see	BookEvent#PAGE_TURNED
   */
  static final String PAGEFLIP_FINISHED = "pageflipFinished";

  /**
   * Dispatched when the corner of a page is rolled over with the mouse.
   * Only applicable if the hover property of the accompanying Book instance is set to true.
   * @see	Book#hover
   */
  static final String HOVER_STARTED = "hoverStarted";

  /**
   * Dispatched when the corner of a page is rolled out of with the mouse. Note that this Event is dispatched just before the page starts falling back in place.
   * Only applicable if the hover property of the accompanying Book instance is set to true.
   * @see	Book#hover
   * @see	BookEvent#HOVER_FINISHED
   */
  static final String HOVER_ENDING = "hoverEnding";

  /**
   * Dispatched when a page falls back in place after being rolled over with the mouse.
   * Only applicable if the hover property of the accompanying Book instance is set to true.
   * @see	Book#hover
   */
  static final String HOVER_FINISHED = "hoverFinished";

  /**
   * Dispatched when a pageflip is successful.
   * @see	BookEvent#PAGE_NOT_TURNED
   */
  static final String PAGE_TURNED = "pageTurned";

  /**
   * Dispatched when a pageflip is not successful.
   * @see	BookEvent#PAGE_TURNED
   */
  static final String PAGE_NOT_TURNED = "pageNotTurned";

  /**
   * Dispatched when a Page is torn out of its Book.
   */
  static final String PAGE_TORN = "pageTorn";

  /**
   * Dispatched at the same time as the page-turned, when the Book was previously closed, and the first or last Page was flipped successfully.
   * @see	BookEvent#PAGE_TURNED
   */
  static final String BOOK_OPENED = "bookOpened";

  /**
   * Dispatched at the same time as the page-turned, when the Book was previously open, and the first or last Page was flipped successfully.
   * @see	BookEvent#PAGE_TURNED
   */
  static final String BOOK_CLOSED = "bookClosed";

  /**
   * Book state indicating that no pageflip is currently being executed.
   */
  static final String NOT_FLIPPING = "notFlipping";

  /**
   * Dispatched when a page is added to or removed from the PageManager.
   * @see	PageManager#pages
   */
  static final String CONTENT_CHANGED = "contentChanged";

  /**
   * Dispatched when the status of the Book changes.
   * @see	Book#status
   */
  static final String STATUS_CHANGED = "statusChanged";

  /**
   * Dispatched when the value of a PageManager its currentPage property changes.
   * @see	PageManager#currentPage
   */
  static final String CURRENTPAGE_CHANGED = "currentPageChanged";

  /**
   * Creates a BookEvent object to pass as a parameter to event listeners.
   *
   * @param	type		The type of the event, accessible as BookEvent.type.
   * @param	bubbles		Determines whether the BookEvent object participates in the bubbling stage of the event flow.
   * @param	cancelable	Determines whether the BookEvent object can be canceled.
   *
   */
  BookEvent(String type, PageManager book, [Page page = null, bool bubbles = false, bool cancelable = false])
      : super(type, bubbles /*, cancelable*/) {
    this._pageManager = book;
    this._page = page;
  }

  /**
   * Returns the PageManager instance associated with this BookEvent.
   * @see		BookEvent#book
   */
  PageManager get pageManager {
    return this._pageManager;
  }

  /**
   * Returns the Book instance associated with this BookEvent (actually the PageManager instance casted to a Book type).
   * @see		BookEvent#pageManager
   */
  BookView get book {
    return (this._pageManager as BookView);
  }

  /**
   * Returns the Page instance associated with this BookEvent.
   */
  Page get page {
    return this._page;
  }
}
