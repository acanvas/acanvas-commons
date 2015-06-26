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
	 * The <code>NumPad</code> class defines a numpad-style keypad.
	 */
	 class NumPad extends Layout
	{
		
		
		/** 
		 * Creates a new NumPad object.
		 */
		   NumPad() {
				/** The label to use on <code>SWITCH_LAYOUT</code> keys pointing to this layout. */
  		 _switchKeyLabel = '123';
			
			verticalGap = .2;
			
			// Define all rows of keys for that layout
			rows = [
				[
					new Key(CharCode.DIGIT_7),
					new Key(CharCode.DIGIT_8),
					new Key(CharCode.DIGIT_9)
				],
				[
					new Key(CharCode.DIGIT_4),
					new Key(CharCode.DIGIT_5),
					new Key(CharCode.DIGIT_6)
				],
				[
					new Key(CharCode.DIGIT_1),
					new Key(CharCode.DIGIT_2),
					new Key(CharCode.DIGIT_3)
				],
				[
					new Key(CharCode.DIGIT_0, null, Key.CHARACTER_KEY, null, 2.1),
					new Key(CharCode.PERIOD)
				]
			];
			
		}					
		
	}
	
