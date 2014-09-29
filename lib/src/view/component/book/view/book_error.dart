 part of dart_commons;
	
	
	/**
	 * Error class specifying exceptions for certain situations that may occur when working with the Book class.
	 * 
	 * @author		Ruben Swieringa
	 * 				ruben.swieringa@gmail.com
	 * 				www.rubenswieringa.com
	 * 				www.rubenswieringa.com/blog
	 * @version		1.0.0
	 * @see			PageManager PageManager
	 * @see			Book Book
	 * 
	 * 
	 * @internal
	 * 
	 * edit 2
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
	 class BookError extends StateError {
		
		
		/**
		 * Error message indicating that a method expecting a Page instance parameter was passed a non-Page DisplayObject.
		 * Due to the lack of covariance in Actionscript overriding methods need to have the exact same signiature as the super-class' method.
		 * Methods like PageManager's addChild, however, need to prohibit non-Page instances from being added to the container, this is accomplish by throwing a BookError in the case of a non-Page instance being passed as a parameter.
		 */
		 static final String CHILD_NOT_PAGE =	"Non-Page instances not allowed as children.";
		/**
		 * Error message indicating that a Page and a Book are not associated with eachother.
		 * For instance, in a situation where pageX is not a child of bookY, and bookY its removeChild method is called with pageX as a parameter, a ArgumentsError will be thrown with its message set to PAGE_NOT_CHILD its value.
		 * Note that this error message is typically applied to an ArgumentError.
		 */
		 static final String PAGE_NOT_CHILD =	"Page does not exist in container.";
		/**
		 * Error message indicating that the index indicating the z-index of a Page is out of bounds.
		 * For instance, providing PageManager's removeChildAt with an index parameter which is smaller than 0 or greater than (or equal to) the length of PageManager's pages property, will result in a BookError with its message set to OUT_OF_BOUNDS its value.
		 */
		 static final String OUT_OF_BOUNDS =	"Supplied index is below zero or greater than the amount of pages in PageManager (minus one).";
		/**
		 * Error message indicating the value of the message of a BookError when a pageflip is attempted on a Page that has no flipside.
		 * Note that when an inequal amount of children is added to the PageManager class before its () childrenCreated method is called, the PageManager class will automatically add a last blank Page to make the amount of children equal.
		 */
		 static final String NO_FLIPSIDE =	"Page must have a flipside.";
		
		
		/**
		 * Creates a new BookError object. If message is specified, its value is assigned to the object's message property.
		 * 
		 * @param	message	A string associated with the BookError object.
		 * @param	id		A reference number to associate with the specific error message.
		 */
		  BookError([String message="", int id=0]): super(message)  {
		}
		
		
	}
	
	
