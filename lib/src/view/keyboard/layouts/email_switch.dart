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

part of stagexl_commons;

/**
 * The <code>Email</code> class defines a basic qwerty-inspired keyboard layout specially
 * designed for email address entry.
 */
class EmailSwitch extends Layout {
  /**
   * Creates a new Email object.
   */
  EmailSwitch(Layout switchKeyType) {
    /** The label to use on <code>SWITCH_LAYOUT</code> keys pointing to this layout. */
    _switchKeyLabel = 'ABC';

    // Define all rows of keys for that layout
    rows = [
      [
        new Key(CharCode.UPPERCASE_Q),
        new Key(CharCode.UPPERCASE_W),
        new Key(CharCode.UPPERCASE_E),
        new Key(CharCode.UPPERCASE_R),
        new Key(CharCode.UPPERCASE_T),
        new Key(CharCode.UPPERCASE_Y),
        new Key(CharCode.UPPERCASE_U),
        new Key(CharCode.UPPERCASE_I),
        new Key(CharCode.UPPERCASE_O),
        new Key(CharCode.UPPERCASE_P),
        new Key(CharCode.BACKSPACE, null, Key.EDITING_KEY, 'BACKSPACE', 2.5)
      ],
      [
        new Key(CharCode.UPPERCASE_A),
        new Key(CharCode.UPPERCASE_S),
        new Key(CharCode.UPPERCASE_D),
        new Key(CharCode.UPPERCASE_F),
        new Key(CharCode.UPPERCASE_G),
        new Key(CharCode.UPPERCASE_H),
        new Key(CharCode.UPPERCASE_J),
        new Key(CharCode.UPPERCASE_K),
        new Key(CharCode.UPPERCASE_L),
        new Key(CharCode.CAPS_LOCK, null, Key.SYSTEM_KEY, 'CAPSLOCK', 2)
      ],
      [
        new Key(CharCode.AT_SIGN),
        new Key(CharCode.UPPERCASE_Z),
        new Key(CharCode.UPPERCASE_X),
        new Key(CharCode.UPPERCASE_C),
        new Key(CharCode.UPPERCASE_V),
        new Key(CharCode.UPPERCASE_B),
        new Key(CharCode.UPPERCASE_N),
        new Key(CharCode.UPPERCASE_M),
        new Key(CharCode.PERIOD),
        new Key(CharCode.SWITCH_LAYOUT, null, Key.SYSTEM_KEY, switchKeyType.SWITCH_KEY_LABEL, 2.5, 1, switchKeyType)
      ]
    ];
  }
}
