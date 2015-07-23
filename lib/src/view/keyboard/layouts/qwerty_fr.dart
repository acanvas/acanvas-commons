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
	 * The <code>QwertyFr</code> class defines a qwerty-inspired keyboard layout including the most 
	 * useful key variants in a French context.
	 */
	 class QwertyFr extends Layout
	{
		
		
		/** 
		 * Creates a new QwertyFr object.
		 */
		   QwertyFr() {
				/** The label to use on <code>SWITCH_LAYOUT</code> keys pointing to this layout. */
  		 _switchKeyLabel = 'ABC';
			
			// Define all rows of keys for that layout
			rows = [
				[
					new Key(CharCode.UPPERCASE_Q),
					new Key(CharCode.UPPERCASE_W),
					new Key(CharCode.UPPERCASE_E, FrenchKeyVariants.E),
					new Key(CharCode.UPPERCASE_R),
					new Key(CharCode.UPPERCASE_T, FrenchKeyVariants.T),
					new Key(CharCode.UPPERCASE_Y, FrenchKeyVariants.Y),
					new Key(CharCode.UPPERCASE_U, FrenchKeyVariants.U),
					new Key(CharCode.UPPERCASE_I, FrenchKeyVariants.I),
					new Key(CharCode.UPPERCASE_O, FrenchKeyVariants.O),
					new Key(CharCode.UPPERCASE_P)
				],
				[
					new Key(CharCode.TAB, null, Key.NAVIGATION_KEY, null, 1.55),
					new Key(CharCode.UPPERCASE_A, FrenchKeyVariants.A),
					new Key(CharCode.UPPERCASE_S, FrenchKeyVariants.S),
					new Key(CharCode.UPPERCASE_D),
					new Key(CharCode.UPPERCASE_F),
					new Key(CharCode.UPPERCASE_G),
					new Key(CharCode.UPPERCASE_H),
					new Key(CharCode.UPPERCASE_J),
					new Key(CharCode.UPPERCASE_K),
					new Key(CharCode.UPPERCASE_L)
				],
				[
					new Key(CharCode.CAPS_LOCK, null, Key.SYSTEM_KEY, null, 1.55),
					new Key(CharCode.UPPERCASE_Z, FrenchKeyVariants.Z),
					new Key(CharCode.UPPERCASE_X),
					new Key(CharCode.UPPERCASE_C, FrenchKeyVariants.C),
					new Key(CharCode.UPPERCASE_V),
					new Key(CharCode.UPPERCASE_B),
					new Key(CharCode.UPPERCASE_N, FrenchKeyVariants.N),
					new Key(CharCode.UPPERCASE_M),
					new Key(CharCode.BACKSPACE, null, Key.EDITING_KEY, '', 1.55)
				],
				[
					new Key(CharCode.SPACE, null, Key.CHARACTER_KEY, '', 8),
					new Key(CharCode.RETURN, null, Key.EDITING_KEY, '', 1.55)
				]
			];
			
		}					
		
	}
	
