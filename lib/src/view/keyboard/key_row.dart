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
	 * The <code>KeyRow</code> class contains all the keys in a single keyboard row. It basically 
	 * acts as a <code>DisplayObjectContainer</code> with a few extra properties.
	 * 
	 * @see cc.cote.feathers.softkeyboard.Key
	 */
	 class KeyRow extends LifecycleSprite
	{
		/** A vector of all <code>Key</code> objects in the <code>KeyRow</code>. */
		 List<Key> keys;
		
		/** Relative width of the <code>KeyRow</code> in arbitraty units. */
		 num relativeWidth = 0;
		
		 num _gap = 0;
		
		/**
		 * Creates a new <code>KeyRow</code> object.
		 * 
		 * @param keys Listof <code>Key</code> objects to add to the <code>KeyRow</code>.
		 * @param gap Gap to leave between keys (in arbitraty units).
		 */
	 KeyRow(List<Key> keys,num gap): super() {
			
			this.keys = keys;
			this._gap = gap;
			
			// Calculate relative width in units (including the gap between keys)
			for (Key key in keys) {
				addChild(key);
				relativeWidth += key.relativeWidth;
			}
			relativeWidth += (length - 1) * _gap;
			onInitComplete();
		}
		
		/** num of keys in the key row. */
		  int get length {
			return keys.length;
		}

	}
	
