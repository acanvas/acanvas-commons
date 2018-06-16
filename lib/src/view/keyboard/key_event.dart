/*

Copyright (2013 as c), Jean-Philippe Côté (jp@cote.cc)
All rights reserved.

This library can be used freely for non-profit purposes. For-profit usage requires written 
approval or a donation (see http://cote.cc/projects/softkeyboard). The donation amount is set to 
whatever the user deems fair.

Even though this library is open source, it cannot be redistributed or modified without prior 
consent from its author. Comments and suggestions are always encouraged.

This library is provided "as is" with no guarantees whatsoever. Use it at your own risk.

*/

part of acanvas_commons;

/**
 * A <code>KeyEvent</code> object is dispatched in response to a user pressing or releasing one
 * of the keys on a <code>SoftKeyboard</code> object. Please note that this object inherits
 * properties and methods from <code>starling.events.event</code>. You will have to look up
 * <a href="http://doc.starling-framework.org/" target="blank">Starling's API documentation</a>
 * for those inherited elements.
 *
 * @see cc.cote.feathers.softkeyboard.SoftKeyboard
 * @see http://doc.starling-framework.org/ Starling API documentation
 */
class KeyEvent extends Event {
  static final String KEY_UP_PRINTABLE = "cc.cote.feathers.softkeyboard.KeyEvent.keyUpPrintable";
  static final String KEY_UP_VISIBLE = "cc.cote.feathers.softkeyboard.KeyEvent.keyUpVisible";

  /**
   * The <code>KEY_UP</code> constant defines the value of the <code>type</code> property of a
   * <code>keyUp</code> event object.
   *
   * @eventType cc.cote.feathers.softkeyboard.KeyEvent.keyUp
   */
  static final String KEY_UP = "cc.cote.feathers.softkeyboard.KeyEvent.keyUp";

  /**
   * The <code>KEY_DOWN</code> constant defines the value of the <code>type</code> property of
   * a <code>keyDown</code> event object.
   *
   * @eventType cc.cote.feathers.softkeyboard.KeyEvent.keyDown
   */
  static final String KEY_DOWN = "cc.cote.feathers.softkeyboard.KeyEvent.keyDown";

  /**
   * The <code>SHOW_VARIANTS</code> constant defines the value of the <code>type</code>
   * property of a <code>showVariants</code> event object.
   *
   * @eventType cc.cote.feathers.softkeyboard.KeyEvent.showVariants
   */
  static final String SHOW_VARIANTS = "cc.cote.feathers.softkeyboard.KeyEvent.showVariants";

  String _char;
  int _charCode;

  /**
   * Creates a new <code>SoftKeyboardEvent</code> object.
   *
   * @param type Type of the event
   * @param charCode The code of the character associated to the key that triggered the event.
   * @param char The actual printable character associated to the key that triggered the event.
   * @param data Arbitrary data to pass along with the event
   */
  KeyEvent(String type, int charCode, [String char = null, Map data = null]) : super(type, false /*, data*/) {
    _charCode = charCode;
    _char = char;
  }

  /**
   * The actual printable character associated to the key that triggered the event. The value
   * for non-printable characters will be <code>null</code>.
   */
  String get char {
    return _char;
  }

  /**
   * The code of the character associated to the key that triggered the event. Many basic
   * characters have constants defined for them in the <code>CharCode</code> class. For others,
   * use Unicode as a base reference.
   *
   * @see cc.cote.feathers.softkeyboard.CharCode
   * @see http://www.unicode.org/charts/
   */
  int get charCode {
    return _charCode;
  }
}
