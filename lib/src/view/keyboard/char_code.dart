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
 * The <code>CharCode</code> class is an enumeration class containing constants associated to
 * common characters or keys. Each constant contains the <code>charCode</code> value of the
 * character in question. All ASCII characters are currently included as well as codes for the
 * special <code>SWITCH_LAYOUT</code>, <code>DONE</code> and <code>SPACER</code> keys.
 *
 * <p>These constants are particularly useful when building <code>Layout</code> classes and key
 * collections or when checking input received in a <code>KeyEvent</code> object.</p>
 *
 * @see cc.cote.feathers.softkeyboard.layouts
 * @see cc.cote.feathers.softkeyboard.keycollections
 */
class CharCode {
  /** Constant associated with the character code value for the special <code>SWITCH_LAYOUT</code> key. */
  static final int SWITCH_LAYOUT = -1;

  /** Constant associated with the character code value for the special <code>DONE</code> key. */
  static final int DONE = -2;

  /** Constant associated with the character code value for the special <code>SPACER</code> key. */
  static final int SPACER = -3;

  /** Constant associated with the character code value for the <code>BACKSPACE</code> key. */
  static final int BACKSPACE = 8;

  /** Constant associated with the character code value for the <code>TAB</code> key. */
  static final int TAB = 9;

  /** Constant associated with the character code value for the <code>ENTER/RETURN</code> key. */
  static final int RETURN = 13;

  /** Constant associated with the character code value for the <code>ENTER/RETURN</code> key. */
  static final int ENTER = RETURN;

  /** Constant associated with the character code value for the <code>SHIFT</code> key. */
  static final int SHIFT = 16;

  /** Constant associated with the character code value for the <code>CONTROL</code> key. */
  static final int CONTROL = 17;

  /** Constant associated with the character code value for the <code>PAUSE_BREAK</code> key. */
  static final int PAUSE_BREAK = 19;

  /** Constant associated with the character code value for the <code>CAPS_LOCK</code> key. */
  static final int CAPS_LOCK = 20;

  /** Constant associated with the character code value for the <code>ESCAPE</code> key. */
  static final int ESCAPE = 27;

  /** Constant associated with the character code value for the <code>SPACE</code> character. */
  static final int SPACE = 32;

  /** Constant associated with the character code value for the <code>!</code> character. */
  static final int EXCLAMATION_MARK = 33;

  /** Constant associated with the character code value for the <code>"</code> character. */
  static final int QUOTE = 34;

  /** Constant associated with the character code value for the <code>#</code> character. */
  static final int HASH = 35;

  /** Constant associated with the character code value for the <code>$</code> character. */
  static final int DOLLAR = 36;

  /** Constant associated with the character code value for the <code>%</code> character. */
  static final int PERCENT = 37;

  /** Constant associated with the character code value for the <code>&amp;</code> character. */
  static final int AMPERSAND = 38;

  /** Constant associated with the character code value for the <code>'</code> character. */
  static final int APOSTROPHE = 39;

  /** Constant associated with the character code value for the <code>(</code> character. */
  static final int LEFT_PARENTHESIS = 40;

  /** Constant associated with the character code value for the <code>)</code> character. */
  static final int RIGHT_PARENTHESIS = 41;

  /** Constant associated with the character code value for the <code>~~</code> character. */
  static final int ASTERISK = 42;

  /** Constant associated with the character code value for the <code>+</code> character. */
  static final int PLUS = 43;

  /** Constant associated with the character code value for the <code>,</code> character. */
  static final int COMMA = 44;

  /** Constant associated with the character code value for the <code>-</code> character. */
  static final int HYPHEN = 45;

  /** Constant associated with the character code value for the <code>-</code> character. */
  static final int MINUS = HYPHEN;

  /** Constant associated with the character code value for the <code>.</code> character. */
  static final int PERIOD = 46;

  /** Constant associated with the character code value for the <code>/</code> character. */
  static final int SLASH = 47;

  /** Constant associated with the character code value for digit 0. */
  static final int DIGIT_0 = 48;

  /** Constant associated with the character code value for digit 1. */
  static final int DIGIT_1 = 49;

  /** Constant associated with the character code value for digit 2. */
  static final int DIGIT_2 = 50;

  /** Constant associated with the character code value for digit 3. */
  static final int DIGIT_3 = 51;

  /** Constant associated with the character code value for digit 4. */
  static final int DIGIT_4 = 52;

  /** Constant associated with the character code value for digit 5. */
  static final int DIGIT_5 = 53;

  /** Constant associated with the character code value for digit 6. */
  static final int DIGIT_6 = 54;

  /** Constant associated with the character code value for digit 7. */
  static final int DIGIT_7 = 55;

  /** Constant associated with the character code value for digit 8. */
  static final int DIGIT_8 = 56;

  /** Constant associated with the character code value for digit 9. */
  static final int DIGIT_9 = 57;

  /** Constant associated with the character code value for the <code>:</code> character. */
  static final int COLON = 58;

  /** Constant associated with the character code value for the <code>;</code> character. */
  static final int SEMICOLON = 59;

  /** Constant associated with the character code value for the <code>&lt;</code> character. */
  static final int LESS_THAN = 60;

  /** Constant associated with the character code value for the <code>=</code> character. */
  static final int EQUAL = 61;

  /** Constant associated with the character code value for the <code>&gt;</code> character. */
  static final int GREATER_THAN = 62;

  /** Constant associated with the character code value for the <code>?</code> character. */
  static final int QUESTION_MARK = 63;

  /** Constant associated with the character code value for the <code>&#64;</code> character. */
  static final int AT_SIGN = 64;

  /** Constant associated with the character code value for the uppercase <code>A</code> character. */
  static final int UPPERCASE_A = 65;

  /** Constant associated with the character code value for the uppercase <code>B</code> character. */
  static final int UPPERCASE_B = 66;

  /** Constant associated with the character code value for the uppercase <code>C</code> character. */
  static final int UPPERCASE_C = 67;

  /** Constant associated with the character code value for the uppercase <code>D</code> character. */
  static final int UPPERCASE_D = 68;

  /** Constant associated with the character code value for the uppercase <code>E</code> character. */
  static final int UPPERCASE_E = 69;

  /** Constant associated with the character code value for the uppercase <code>F</code> character. */
  static final int UPPERCASE_F = 70;

  /** Constant associated with the character code value for the uppercase <code>G</code> character. */
  static final int UPPERCASE_G = 71;

  /** Constant associated with the character code value for the uppercase <code>H</code> character. */
  static final int UPPERCASE_H = 72;

  /** Constant associated with the character code value for the uppercase <code>I</code> character. */
  static final int UPPERCASE_I = 73;

  /** Constant associated with the character code value for the uppercase <code>J</code> character. */
  static final int UPPERCASE_J = 74;

  /** Constant associated with the character code value for the uppercase <code>K</code> character. */
  static final int UPPERCASE_K = 75;

  /** Constant associated with the character code value for the uppercase <code>L</code> character. */
  static final int UPPERCASE_L = 76;

  /** Constant associated with the character code value for the uppercase <code>M</code> character. */
  static final int UPPERCASE_M = 77;

  /** Constant associated with the character code value for the uppercase <code>N</code> character. */
  static final int UPPERCASE_N = 78;

  /** Constant associated with the character code value for the uppercase <code>O</code> character. */
  static final int UPPERCASE_O = 79;

  /** Constant associated with the character code value for the uppercase <code>P</code> character. */
  static final int UPPERCASE_P = 80;

  /** Constant associated with the character code value for the uppercase <code>Q</code> character. */
  static final int UPPERCASE_Q = 81;

  /** Constant associated with the character code value for the uppercase <code>R</code> character. */
  static final int UPPERCASE_R = 82;

  /** Constant associated with the character code value for the uppercase <code>S</code> character. */
  static final int UPPERCASE_S = 83;

  /** Constant associated with the character code value for the uppercase <code>T</code> character. */
  static final int UPPERCASE_T = 84;

  /** Constant associated with the character code value for the uppercase <code>U</code> character. */
  static final int UPPERCASE_U = 85;

  /** Constant associated with the character code value for the uppercase <code>V</code> character. */
  static final int UPPERCASE_V = 86;

  /** Constant associated with the character code value for the uppercase <code>W</code> character. */
  static final int UPPERCASE_W = 87;

  /** Constant associated with the character code value for the uppercase <code>X</code> character. */
  static final int UPPERCASE_X = 88;

  /** Constant associated with the character code value for the uppercase <code>Y</code> character. */
  static final int UPPERCASE_Y = 89;

  /** Constant associated with the character code value for the uppercase <code>Z</code> character. */
  static final int UPPERCASE_Z = 90;

  /** Constant associated with the character code value for the <code>[</code> character. */
  static final int LEFT_BRACKET = 91;

  /** Constant associated with the character code value for the <code>\</code> character. */
  static final int BACKSLASH = 92;

  /** Constant associated with the character code value for the <code>]</code> character. */
  static final int RIGHT_BRACKET = 93;

  /** Constant associated with the character code value for the <code>^</code> character. */
  static final int CIRCUMFLEX_ACCENT = 94;

  /** Constant associated with the character code value for the <code>_</code> character. */
  static final int UNDERSCORE = 95;

  /** Constant associated with the character code value for the <code>`</code> character. */
  static final int BACKTICK = 96;

  /** Constant associated with the character code value for the lowercase <code>A</code> character. */
  static final int LOWERCASE_A = 97;

  /** Constant associated with the character code value for the lowercase <code>B</code> character. */
  static final int LOWERCASE_B = 98;

  /** Constant associated with the character code value for the lowercase <code>C</code> character. */
  static final int LOWERCASE_C = 99;

  /** Constant associated with the character code value for the lowercase <code>D</code> character. */
  static final int LOWERCASE_D = 100;

  /** Constant associated with the character code value for the lowercase <code>E</code> character. */
  static final int LOWERCASE_E = 101;

  /** Constant associated with the character code value for the lowercase <code>F</code> character. */
  static final int LOWERCASE_F = 102;

  /** Constant associated with the character code value for the lowercase <code>G</code> character. */
  static final int LOWERCASE_G = 103;

  /** Constant associated with the character code value for the lowercase <code>H</code> character. */
  static final int LOWERCASE_H = 104;

  /** Constant associated with the character code value for the lowercase <code>I</code> character. */
  static final int LOWERCASE_I = 105;

  /** Constant associated with the character code value for the lowercase <code>J</code> character. */
  static final int LOWERCASE_J = 106;

  /** Constant associated with the character code value for the lowercase <code>K</code> character. */
  static final int LOWERCASE_K = 107;

  /** Constant associated with the character code value for the lowercase <code>L</code> character. */
  static final int LOWERCASE_L = 108;

  /** Constant associated with the character code value for the lowercase <code>M</code> character. */
  static final int LOWERCASE_M = 109;

  /** Constant associated with the character code value for the lowercase <code>N</code> character. */
  static final int LOWERCASE_N = 110;

  /** Constant associated with the character code value for the lowercase <code>O</code> character. */
  static final int LOWERCASE_O = 111;

  /** Constant associated with the character code value for the lowercase <code>P</code> character. */
  static final int LOWERCASE_P = 112;

  /** Constant associated with the character code value for the lowercase <code>Q</code> character. */
  static final int LOWERCASE_Q = 113;

  /** Constant associated with the character code value for the lowercase <code>R</code> character. */
  static final int LOWERCASE_R = 114;

  /** Constant associated with the character code value for the lowercase <code>S</code> character. */
  static final int LOWERCASE_S = 115;

  /** Constant associated with the character code value for the lowercase <code>T</code> character. */
  static final int LOWERCASE_T = 116;

  /** Constant associated with the character code value for the lowercase <code>U</code> character. */
  static final int LOWERCASE_U = 117;

  /** Constant associated with the character code value for the lowercase <code>V</code> character. */
  static final int LOWERCASE_V = 118;

  /** Constant associated with the character code value for the lowercase <code>W</code> character. */
  static final int LOWERCASE_W = 119;

  /** Constant associated with the character code value for the lowercase <code>X</code> character. */
  static final int LOWERCASE_X = 120;

  /** Constant associated with the character code value for the lowercase <code>Y</code> character. */
  static final int LOWERCASE_Y = 121;

  /** Constant associated with the character code value for the lowercase <code>Z</code>character. */
  static final int LOWERCASE_Z = 122;

  /** Constant associated with the character code value for the <code>{</code> character. */
  static final int LEFT_BRACE = 123;

  /** Constant associated with the character code value for the <code>|</code> character. */
  static final int PIPE = 124;

  /** Constant associated with the character code value for the <code>}</code> character. */
  static final int RIGHT_BRACE = 125;

  /** Constant associated with the character code value for the <code>~</code> character. */
  static final int TILDE = 126;

  /** Constant associated with the character code value for the <code>DELETE</code> key. */
  static final int DELETE = 127;

  /** Constant associated with the character code value for the <code>DELETE</code> key. */
  static final int NUM_LOCK = 144;

  /** Constant associated with the character code value for the <code>DELETE</code> key. */
  static final int SCROLL_LOCK = 145;
}
