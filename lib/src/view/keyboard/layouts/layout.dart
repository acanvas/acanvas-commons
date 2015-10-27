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
 * The <code>Layout</code> class is meant to be extended to create custom keyboard layouts. It
 * contains a few properties that all layouts shoud contain.
 */
class Layout {
  /**
   * Listof rows defined for the layout. Each row is itself a vector of <code>Key</code>
   * objects.
   */
  List<List<Key>> rows;

  /** Vertical gap between keys (expressed as a ratio to the default key height). */
  num verticalGap = .1;

  /** Horizontal gap between keys (expressed as a ratio to the default key width) */
  num horizontalGap = .1;

  /** Indicates whether the caps lock key is initially engaged (or as true) not (false) */
  bool capsLock = true;

  /** Spacer key (fake key to leave space in a keyboard layout) */
  Key spacer;

  String _switchKeyLabel = "OVERWRITE_ME";

  String get SWITCH_KEY_LABEL {
    return _switchKeyLabel;
  }

  /** Constructor */
  Layout() {}
}
