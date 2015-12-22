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

part of rockdot_commons;

/**
 * Dispatched when an on-screen key is pressed.
 *
 * @eventType cc.cote.feathers.softkeyboard.KeyEvent.KEY_DOWN
 */
// [Event(name="cc.cote.feathers.softkeyboard.KeyEvent.keyDown",type="cc.cote.feathers.softkeyboard.KeyEvent")]

/**
 * Dispatched when an on-screen key is released. The release must be above the key that was
 * initially pressed otherwise the event is not fired.
 *
 * @eventType cc.cote.feathers.softkeyboard.KeyEvent.KEY_UP
 */
// [Event(name="cc.cote.feathers.softkeyboard.KeyEvent.keyUp",type="cc.cote.feathers.softkeyboard.KeyEvent")]

/**
 * This class allows the creation of virtual on-screen keyboards. Various types of keyboard
 * configurations are included in the package such as QWERTY, NUMPAD, etc. However, if a custom
 * layout is needed, it is easy to create one by extending the <code>Layout</code> base class.
 *
 * <p>Creating a keyboard and listening for input is very easy. All you need to do is pass the
 * desired layout to the SoftKeyboard constructor and add an event listener:</p>
 *
 * <listing version="3.0">
 * SoftKeyboard keyboard = new SoftKeyboard(new QwertyEn());
 * keyboard.addEventListener(SoftKeyboardEvent.KEY_UP, _onKeyUp);
 * addChild(keyboard);</listing>
 *
 * <p>It is also possible to create keyboards with multiple layouts by passing a vector of
 * <code>Layout</code> objects to the constructor. This makes it easy to have a keyboard with
 * one layout for regular letters and another one for numbers and symbols, for example.
 * Switching between them is possible by pressing the special <code>SWITCH_LAYOUT</code> key.</p>
 *
 * <p>Layouts that have a <code>SWITCH_LAYOUT</code> key generally accept as a constructor
 * parameter the class of the layout that the <code>SWITCH_LAYOUT</code> key should instantiate
 * when pressed. Here is an example that will toggle between the <code>QwertyEnSingleSwitch</code>
 * and <code>numsAndSymbolsSingleSwitch</code> layouts:</p>
 *
 * <listing version="3.0">
 * List layouts&lt;Layout&gt; = new &lt;Layout&gt;[
 *     new QwertyEnSingleSwitch(numsAndSymbolsSingleSwitch),
 *     new numsAndSymbolsSingleSwitch(QwertyEnSingleSwitch)
 * ];
 * SoftKeyboard keyboard = new SoftKeyboard(layouts);
 * addChild(keyboard);</listing>
 *
 * <p>A full, working code example is provided with the <code>SoftKeyboard</code> download
 * package.</p>
 *
 * <p>In order for the keyboard to display properly, you must skin it through the use of a
 * Feathers' theme (a sample theme is provided in the download package). If you don't, a generic
 * grey skin will be used for reference. Besides assigning skins in your theme, you should also
 * define a TextRenderer and assign a TextFormat. For more information, see the
 * <a href="http://wiki.starling-framework.org/feathers/start">Feathers documentation</a>.</p>
 *
 * <p><code>SoftKeyboard</code> requires <a href="http://feathersui.com/">Feathers 1.0 or newer</a>
 * which itself requires the <a href="http://gamua.com/starling/">Starling framework</a>.</p>
 *
 * @see cc.cote.feathers.softkeyboard.layouts
 * @see cc.cote.feathers.softkeyboard.KeyEvent
 * @see http://cote.cc/projects/softkeyboard
 * @see http://feathersui.com/
 * @see http://gamua.com/starling/
 *
 *	@TODO	When the keyboard is small, the _callout makes the variants keys taller than
 * 				they should be. This probably warrants a support request to Josh. I SHOULD JUST
 * 				GET RID OF THE FUCKING CALLOUT AND DO IT MYSELF!!!! When I fix this, the callout
 * 				arrow of bottom key rows is screwed...
 *
 * Ideas for later : dynamic
 * 		@TODO	Add left/rigth key padding
 * 		@TODO	Add the ability to temporarily switch to another layout while pressing the
 * 				SWITCH_LAYOUT key
 * 		@TODO 	Should we use some sort of autoscale on the key labels ? This is a minor problem
 * 				since the size can be changed in the theme.
 * 		@TODO	Remove the KeyRow object. It just feels silly. Use a layout machin ?
 * 		@TODO	Do we need to bother with the NUM_LOCK key ?
 * 		@TODO	The key icons should be resized according to the key's size (this is not such a
 * 				big problem since you can always change the icons themselves).
 * 		@TODO 	Add the ability to modify the layouts var. This means adding several methods
 * 				(addLayout, addLayoutAt, etc) or finding a way to trap modifications done
 * 				directly on the vector).
 * 		@TODO	Can we do something about the fact that the callout component requires a
 * 				background skin ?
 *
 */
class SoftKeyboard extends BoxSprite {
  /** Version of this SoftKeyboard library */
  static const String VERSION = '1.0a rev8';

  /** The background to use for the SoftKeyboard. */
  DisplayObject backgroundSkin;

  /** The free space between the outside of the keyboard and the keys. */
  num padding = 0;

  /**
   * The vector containing all active keyboard configurations. A single keyboard can have more
   * than one configuration. A configuration is the container of all keys defined by a layout.
   * Configurations are place on the display list, they are DisplayObjects.
   */
  List<LifecycleSprite> _configurations = new List<LifecycleSprite>();

  /** A vector containing all layouts passed in via the constructor. */
  List<Layout> _layouts;

  /** The index of the currently displayed layout. */
  int _currentLayoutIndex = 0;

  /** The container of key variants displayed when the user holds down a key. */
  Callout _callout;

  /**
   * Creates a new SoftKeyboard object.
   *
   * @param layouts A single <code>Layout</code> object or a vector of <code>Layout</code>
   * objects to use with the keyboard
   * @param width Full outer width of the keyboard (including any padding)
   * @param height Full outer height of the keyboard (including any padding)
   *
   * @see cc.cote.feathers.softkeyboard.layouts
   *
   * @throws Error First parameter must be a Layout object or a vector of Layout objects.
   */
  SoftKeyboard(List<Layout> layouts, [num width = 320, num height = 160]) {
    _layouts = layouts;

    // Assign parameters locally
    if (width > 0) this.spanWidth = width;
    if (height > 0) this.spanHeight = height;

    // Build all configurations from the specified layouts
    for (Layout layout in _layouts) {
      _configurations.add(_buildConfiguration(layout));
    }

    // Add the currently selected configuration to the stage and set up key listeners
    addChild(_configurations[_currentLayoutIndex]);
    _addKeyListenersToConfiguration(_configurations[_currentLayoutIndex]);
    capsLock = _layouts[_currentLayoutIndex].capsLock;

    // Add background skin (if any has been specified)
    if (backgroundSkin != null) addChildAt(backgroundSkin, 0);
  }

  /** @ */
  void _addKeyListenersToConfiguration(Sprite conf) {
    for (int i = 0; i < conf.numChildren; i++) {
      KeyRow kr = conf.getChildAt(i) as KeyRow;

      for (int j = 0; j < kr.numChildren; j++) {
        Key k = kr.getChildAt(j) as Key;
        k.addEventListener(KeyEvent.KEY_UP_PRINTABLE, _onKeyUpPrintableOrVisible);
        k.addEventListener(KeyEvent.KEY_UP_VISIBLE, _onKeyUpPrintableOrVisible);
        k.addEventListener(KeyEvent.KEY_DOWN, _onKeyDown);
        k.addEventListener(KeyEvent.KEY_DOWN, _onKeyDown);
        k.addEventListener(KeyEvent.KEY_UP, _onKeyUp);
        k.addEventListener(KeyEvent.SHOW_VARIANTS, _onShowVariants);
      }
    }
  }

  /** @ */
  void _removeKeyListenersFromConfiguration(Sprite conf) {
    for (int i = 0; i < conf.numChildren; i++) {
      KeyRow kr = conf.getChildAt(i) as KeyRow;

      for (int j = 0; j < kr.numChildren; j++) {
        Key k = kr.getChildAt(j) as Key;
        k.removeEventListener(KeyEvent.KEY_UP_PRINTABLE, _onKeyUpPrintableOrVisible);
        k.removeEventListener(KeyEvent.KEY_UP_VISIBLE, _onKeyUpPrintableOrVisible);
        k.removeEventListener(KeyEvent.KEY_DOWN, _onKeyDown);
        k.removeEventListener(KeyEvent.KEY_UP, _onKeyUp);
        k.removeEventListener(KeyEvent.SHOW_VARIANTS, _onShowVariants);
      }
    }
  }

  /** @ */
  void _onShowVariants(KeyEvent e) {
    // If the callout is already on the stage, it means that the user rolled out and back in
    // while keeping the key pressed. In that case, it shouldn't be displayed again.
    if (_callout != null && _callout.stage != null) return;

    // Retrieve the key that was originally pressed
    Key key = e.currentTarget as Key;

    // The callout should always be displayed above the key to prevent fingers from hiding
    // it (unless there's no room).
    Point globalPos = key.parent.localToGlobal(new Point(key.x, key.y));
    String direction = Callout.DIRECTION_UP;
    if (key.height * 1.5 > globalPos.y) direction = Callout.DIRECTION_DOWN;

    // A background image must be defined on the callout or else it dies
    try {
      _callout = new Callout.show(key.variantsContainer, key, direction, true);
    } catch (e) {
//				Error error = new Error(
//					"The Callout subcomponent requires that it's 'backgroundSkin' property be set."
//				);
//				error.name = 'SoftKeyboard error';
//				throw(error);
    }

    addChild(_callout);

    // For whatever reason, we need to manually resize the Callout otherwise in some cases
    // (when the keyboard is small for instance) the variant keys are too small.
    _callout.span(key.height, (key.width * key.variants.length) + (key.variants.length - 1) * 5);

    // THIS BREAKS THE TOP ARROW !!!!!
  }

  /** @ */
  Sprite _buildConfiguration(Layout layout) {
    BoxSprite keyboard = new BoxSprite();
    keyboard.inheritSpan = true;

    // Check if rows have been defined properly in the layout
    if (layout.rows == null || !(layout.rows is List<List<Key>>) || layout.rows.length < 1) {
      throw new StateError('SoftKeyboard error: no rows have been defined in the specified layout.');
    }

    for (int i = 0; i < layout.rows.length; i++) {
      keyboard.addChild(new KeyRow(layout.rows[i], layout.horizontalGap));
    }

    return keyboard;
  }

  /** @ */
  void _onKeyDown(KeyEvent e) {
    // Re-dispatch the event so implementors can easily listen on the SoftKeyboard object
    // directly
    dispatchEvent(e);
  }

  void _onKeyUpPrintableOrVisible(KeyEvent e) {
    // Re-dispatch the event so implementors can easily listen on the SoftKeyboard object
    // directly
    dispatchEvent(e);
  }

  /** @ */
  void _onKeyUp(KeyEvent e) {
    Key key = e.currentTarget as Key;

    // Treat the special SWITCH_LAYOUT case
    if (e.charCode == CharCode.SWITCH_LAYOUT) {
      // If a layout to switch to has been defined on the key, use it first. If not, go to
      // next layout by default.
      //Layout currentLayout = layouts[layoutIndex];

      if (key.switchToLayoutType != null) {
        layoutIndex = _getLayoutIndex(key.switchToLayoutType);
      } else {
        // Otherwise, go to next layout
        if (layoutIndex + 1 < layouts.length) {
          layoutIndex++;
        } else {
          layoutIndex = 0;
        }
      }

      return;
    }

    // Treat the special CAPS_LOCK case
    if (e.charCode == CharCode.CAPS_LOCK) capsLock = !capsLock;

    // Re-dispatch the key event so implementors can easily listen on the SoftKeyboard object
    // directly
    dispatchEvent(e);

    // If the key also happens to have a switchToLayoutType, switch layout
    if (key.switchToLayoutType != null) {
      layoutIndex = _getLayoutIndex(key.switchToLayoutType);
    }
  }

  /** @ */
  int _getLayoutIndex(Layout layoutType) {
    for (int i = 0; i < _layouts.length; i++) {
      if (_layouts[i] == layoutType) return i;
    }

    return _currentLayoutIndex;
  }

  /** @ */
  @override
  void refresh() {
    // Fetch info about current keyboard
    Sprite keyboard = _configurations[_currentLayoutIndex];
    int rowCount = keyboard.numChildren;
    Layout currentLayout = _layouts[_currentLayoutIndex];

    // Calculate horizontal unit size (in pixels) based on the largest row and vertical unit
    // size based on the number of rows;
    KeyRow widest = _getWidestRow(keyboard);
    num hUnit = (spanWidth - 2 * padding) / widest.relativeWidth;
    num vUnit = (spanHeight - 2 * padding) / (rowCount + ((rowCount - 1) * currentLayout.verticalGap));

    Key key;
    // Loop through all rows of keys
    for (int i = 0; i < rowCount; i++) {
      KeyRow row = keyboard.getChildAt(i) as KeyRow;

      // Position and size each key (keeping track of where we are with xPos)
      num xPos = 0;
      for (int j = 0; j < row.keys.length; j++) {
        key = row.keys[j];

        key.span(key.relativeWidth * hUnit, key.relativeHeight * vUnit);

        key.x = xPos.round();
        xPos += key.spanWidth + currentLayout.horizontalGap * hUnit;
      }
    }

    // Key rows are centered in a second stage because they do not all have the same width.
    for (int k = 0; k < rowCount; k++) {
      KeyRow r = (keyboard.getChildAt(k) as KeyRow);
      r.x = (((width - 2 * padding) - r.width) / 2 + padding).round();
      r.y = (((key.spanHeight + currentLayout.verticalGap * vUnit) * k) + padding).round();
    }

    // Size background (if any is present)
    if (backgroundSkin != null || backgroundSkin == true) {
      backgroundSkin.width = width;
      backgroundSkin.height = height;
    }
  }

  /** @ */
  KeyRow _getWidestRow(Sprite keyboard) {
    KeyRow widest = (keyboard.getChildAt(0) as KeyRow);

    for (int i = 0; i < keyboard.numChildren; i++) {
      KeyRow row = keyboard.getChildAt(i) as KeyRow;
      if (row.relativeWidth > widest.relativeWidth) widest = row;
    }

    return widest;
  }

  /** @ */
  void _changeCapsLockKeyStatus([bool highlight = true]) {
    Sprite config = _configurations[_currentLayoutIndex];

    for (int i = 0; i < config.numChildren; i++) {
      KeyRow keyRow = config.getChildAt(i) as KeyRow;

      // This allows for more than one capsLock keys on the same layout
      for (Key key in keyRow.keys) {
        if (key.charCode == html.KeyCode.CAPS_LOCK) {
          key.isSelected = highlight;
        }
      }
    }
  }

  /** Indicates whether the caps lock key is currently activated (or as true) not (false). */
  bool get capsLock {
    return _layouts[_currentLayoutIndex].capsLock;
  }

  /** @  */
  void set capsLock(bool value) {
    _layouts[_currentLayoutIndex].capsLock = value;

    if (value == true) {
      _changeKeyCase(Key.UPPERCASE);
    } else {
      _changeKeyCase(Key.LOWERCASE);
    }

    _changeCapsLockKeyStatus(value);
  }

  /** @ */
  void _changeKeyCase(String keyCase) {
    Sprite c = _configurations[layoutIndex];

    for (int i = 0; i < c.numChildren; i++) {
      KeyRow keyRow = c.getChildAt(i) as KeyRow;
      for (Key key in keyRow.keys) key.changeCase(keyCase);
    }
  }

  /** A vector of all Layout objects assigned to the keyboard. */
  List<Layout> get layouts {
    return _layouts;
  }

  /** The index of the currently displayed layout from the <code>layouts</code> vector. */
  int get layoutIndex {
    return _currentLayoutIndex;
  }

  /** @ */
  void set layoutIndex(int value) {
    // Check if value is valid
    if (value >= layouts.length) {
      throw (new StateError('Requested layout index is invalid.'));
      return;
    }

    // Remove previous configuration
    _removeKeyListenersFromConfiguration(_configurations[layoutIndex]);
    removeChild(_configurations[layoutIndex]);

    // Add new one
    _currentLayoutIndex = value;
    addChild(_configurations[layoutIndex]);
    _addKeyListenersToConfiguration(_configurations[layoutIndex]);
    capsLock = _layouts[_currentLayoutIndex].capsLock;
//			invalidate(INVALIDATION_FLAG_STATE);
  }
}
