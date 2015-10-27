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
 * Dispatched when a key is pressed down.
 *
 * @eventType cc.cote.feathers.softkeyboard.KeyEvent.KEY_DOWN
 */
// [Event(name="cc.cote.feathers.softkeyboard.KeyEvent.keyDown",type="cc.cote.feathers.softkeyboard.KeyEvent")]

/**
 * Dispatched when a the key is released. The release position must be above the key that was
 * initially pressed down otherwise the event is not fired. This allows the user to cancel the
 * <code>keyUp</code> event.
 *
 * @eventType cc.cote.feathers.softkeyboard.KeyEvent.KEY_UP
 */
// [Event(name="cc.cote.feathers.softkeyboard.KeyEvent.keyUp",type="cc.cote.feathers.softkeyboard.KeyEvent")]

/**
 * Dispatched when the variants for a key should be displayed.
 *
 * @eventType cc.cote.feathers.softkeyboard.KeyEvent.SHOW_VARIANTS
 */
// [Event(name="cc.cote.feathers.softkeyboard.KeyEvent.showVariants",type="cc.cote.feathers.softkeyboard.KeyEvent")]

/**
 * The <code>Key</code> class creates individual soft-keyboard keys to use in keyboard
 * <code>Layouts</code> and key collections.
 *
 * <p>Both the key and its label have several tokens in their <code>nameList</code> property to
 * facilitate skinning of individual keys. First, they have a <code>charCodeXX</code> token
 * where <code>XX</code> is the character code. Second, their label's text is also a token in
 * their <code>nameList</code>. Finally, when appropriate, they will have the
 * <code>hasVariant</code> token in their <code>nameList</code> to identify keys with
 * variants.</p>
 *
 * @see cc.cote.feathers.softkeyboard.layouts
 * @see cc.cote.feathers.softkeyboard.keycollections
 */
class Key extends BoxSprite {
  //feathers
  List nameList = [];
  static final String UPPERCASE = 'Uppercase';
  static final String LOWERCASE = 'Lowercase';

  /**
   * Constant associated with the text representation of the label's name as used in the
   * label's nameList property (for theming purposes).
   */
  static final String SOFTKEYBOARD_KEY_LABEL = 'softkeyboard-key-label';

  /** Constant associated with the text representation of the key up state */
  static final String UP_STATE = 'Up';

  /** Constant associated with the text representation of the key down state */
  static final String DOWN_STATE = 'Down';

  /** Constant associated with the text representation of the key hover state */
  static final String HOVER_STATE = 'Hover';

  /** List of valid key states */
  static final List AVAILABLE_STATES = [UP_STATE, DOWN_STATE, HOVER_STATE];

  /** An identifier for regular alphanumeric character keys. */
  static final String CHARACTER_KEY = 'characterKey';

  /** An identifier for modifier keys. */
  static final String MODIFIER_KEY = 'modifierKey';

  /** An identifier for editing keys. */
  static final String EDITING_KEY = 'editingKey';

  /** An identifier for system keys. */
  static final String SYSTEM_KEY = 'systemKey';

  /** An identifier for navigation keys. */
  static final String NAVIGATION_KEY = 'navigationKey';

  /** An identifier for function keys. */
  static final String FUNCTION_KEY = 'functionKey';

  /** An identifier for numeric keypad keys. */
  static final String NUMERIC_KEYPAD_KEY = 'numericKeypadKey';

  /** An identifier for lock keys. */
  static final String LOCK_KEY = 'lockKey';

  /**
   * A layout (specified by its class) to switch to when the key is released. It is mostly
   * used with the <code>SWITCH_LAYOUT</code> key but also works with other keys.
   */
  Layout switchToLayoutType;

  /**
   * The number of milliseconds to wait after a key has been pressed before displaying the
   * variants (if any are available).
   */
  int keyVariantsDelay = 150;

  /**
   * The key's icon (if any). Icons are usually reserved for 'special' keys such as: dynamic CAPS_LOCK, ENTER, TAB, etc.
   */
  DisplayObject icon;

  /** The key's icon while in 'selected' state. */
  DisplayObject selectedIcon;

  /** The skin to use for regular keys in the 'up' state. */
  DisplayObject regularKeyUpSkin;

  /** The skin to use for regular keys in the 'hover' state. */
  DisplayObject regularKeyHoverSkin;

  /** The skin to use for regular keys in the 'down' state. */
  DisplayObject regularKeyDownSkin;

  /** The skin to use for special keys in the 'up' state. */
  DisplayObject specialKeyUpSkin;

  /** The skin to use for special keys in the 'hover' state. */
  DisplayObject specialKeyHoverSkin;

  /** The skin to use for special keys in the 'down' state. */
  DisplayObject specialKeyDownSkin;

  /** The skin to use for keys that have variants, the 'up' state. */
  DisplayObject hasVariantsKeyUpSkin;

  /** The skin to use for keys that have variants, in the 'hover' state. */
  DisplayObject hasVariantsKeyHoverSkin;

  /** The skin to use for keys that have variants, in the 'hover' state. */
  DisplayObject hasVariantsKeyDownSkin;

  String _character;
  int _charCode;
  DisplayObject _icon;
  bool _isSelected;
  bool _isVariant = false;
  Label _label;
  num _relativeWidth;
  num _relativeHeight;
  DisplayObject _skin;
  String _state;
  String _type;
  List<Key> _variants;
  Timer _variantsTimer;
  Sprite _variantsContainer;

  /**
   * Creates a new instance of the Key object.
   *
   * @param charCode Character-code to assign to the key.
   * @param variants A vector of <code>Keys</code> to use as variations of the main key. The
   * key variants are displayed when the user keeps its finger for a little while on a key.
   * For example, variants of the 'e' key could be 'é', 'è', 'ë', etc.
   * @param type The type of key (CHARACTER_KEY, SYSTEM_KEY, etc.).
   * @param label The textual label to display on the key.
   * @param relativeWidth A ratio of the normal key width used to relatively enlarge or make a
   * key smaller. For example, if you wanted a key to be twice as wide as usual, you would
   * specify a relative width of 2.
   * @param relativeHeight A ratio of the normal key height used to enlarge or make a key
   * smaller. For example, if you wanted a key to be twice as high as usual, you would specify
   * a relative height of 2.
   * @param switchToType A layout (specified by its class) to switch to when the key is
   * released. Only works with <code>Softhtml.KeyCode.SWITCH_LAYOUT</code> keys.
   */
  Key(int charCode,
      [List<Key> variants = null,
      String type = 'characterKey',
      String label = null,
      num relativeWidth = 1,
      num relativeHeight = 1,
      Layout switchToLayoutType = null])
      : super() {
    name = "Key_${charCode.toString()}";

    inheritSpan = true;
    // Keep parameters locally
    _charCode = charCode;
    _variants = variants;
    _type = type;
    _relativeWidth = relativeWidth;
    _relativeHeight = relativeHeight;
    this.switchToLayoutType = switchToLayoutType;

    // Flag each variant as such (if any)
    if (variants != null || variants == true) {
      for (Key k in variants) k.isVariant = true;
    }

    // Create the label and name it so it can be specifically styled through a theme
    _label = new Label();
    _label.nameList.add(SOFTKEYBOARD_KEY_LABEL);

    // Define the label. If no label has been specified, use the character as the label (if
    // printable and visible). By the same token, assign names to the individual label for
    // custom skinning.
    if (label != null) {
      _label.text = label;
      if (label == '') {
        _label.nameList.add('SPACE');
        nameList.add('SPACE');
      } else {
        _label.nameList.add(label.replaceAll(' ', '_'));
        nameList.add(label.replaceAll(' ', '_'));
      }
    } else if (isPrintable && isVisible) {
      _character = new String.fromCharCode(_charCode);
      _label.text = character;
      _label.nameList.add(character);
      nameList.add(character);
    } else if (isPrintable != null || isPrintable == true) {
      _character = new String.fromCharCode(_charCode);
    }

    // A string representation of the charCode is added to the nameList so keys can be
    // styled individually (if needed).
    nameList.add('charCode' + (charCode).toString());
    _label.nameList.add('charCode' + (charCode).toString());

    // Modify the name list to reflect the fact that a key has variants
    if (variants != null || variants == true) {
      nameList.add('hasVariants');
      _label.nameList.add('hasVariants');
    }

    // If the key is the special SPACER type, hide it
    if (_charCode == CharCode.SPACER) visible = false;

    // This is for desktop usage and easier debugging
    useHandCursor = true;

    // If there are variants, prepare the timer and the container.
    if (_variants != null) {
      //_variantsTimer = new Timer(new Duration(milliseconds: keyVariantsDelay));
      _variantsContainer = new Sprite();
    }

    // Assign icon (if any has been defined in the theme)
    if (icon != null) _icon = icon;

    // Assign default state. This also loads the appropriate skin (uses builtin default if
    // none is available)
    changeState(UP_STATE);
    //addChild(_skin);

    // If an icon is specified, the label is made invisible
    if (_icon != null) {
      _label.visible = false;
      addChild(_icon);
    }
    addChild(_label);
    //if (variants != null) addChild(_variantsContainer);

    // Now that everything is ready, listen to touch events
    if (ContextTool.TOUCH) {
      addEventListener(TouchEvent.TOUCH_BEGIN, _onTouch);
      addEventListener(TouchEvent.TOUCH_END, _onTouch);
      addEventListener(TouchEvent.TOUCH_MOVE, _onTouch);
    } else {
      addEventListener(MouseEvent.MOUSE_DOWN, _onTouch);
      addEventListener(MouseEvent.MOUSE_UP, _onTouch);
      addEventListener(MouseEvent.MOUSE_MOVE, _onTouch);
    }

    addEventListener(Event.REMOVED_FROM_STAGE, _onRemovedFromStage);
  }

  void _onRemovedFromStage(Event e) {
    if (_variantsTimer != null) {
      _variantsTimer.cancel();

      /*
				if (_variantsTimer.hasEventListener(TimerEvent.TIMER_COMPLETE)) {
					_variantsTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, _onShowAlternates);
				}
				 */
    }
  }

  void dispose() {
    super.dispose();

    if (_variantsTimer != null) {
      _variantsTimer.cancel();
      /*if (_variantsTimer.hasEventListener(TimerEvent.TIMER_COMPLETE)) {
					_variantsTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, _onShowAlternates);
				}
				 */
    }

    if (ContextTool.TOUCH) {
      removeEventListener(TouchEvent.TOUCH_BEGIN, _onTouch);
      removeEventListener(TouchEvent.TOUCH_END, _onTouch);
      removeEventListener(TouchEvent.TOUCH_MOVE, _onTouch);
    } else {
      removeEventListener(MouseEvent.MOUSE_DOWN, _onTouch);
      removeEventListener(MouseEvent.MOUSE_UP, _onTouch);
      removeEventListener(MouseEvent.MOUSE_MOVE, _onTouch);
    }
    removeEventListener(Event.REMOVED_FROM_STAGE, _onRemovedFromStage);

    //super.dispose();
  }

  @override
  void refresh() {
//			if (_skin) {

    GraphicsUtil.rectangle(0, 0, spanWidth, spanHeight, color: PaperColor.BLUE, sprite: _skin);
//			} else {
//				spanInternal(44, 52, false);
//				_skin.width = 44;
//				_skin.height = 52;
//			}

    //_label.validate();
    _label.width = _label.textWidth;
    _label.x = (spanWidth / 2 - _label.width / 2).round();
    _label.y = (spanHeight / 2 - _label.height / 2).round();

    // If an icon has been defined, center it.
    if (_icon != null) {
      _icon.x = (spanWidth / 2 - _icon.width / 2).round();
      _icon.y = (spanHeight / 2 - _icon.height / 2).round();
    }
  }

  /**
   * Changes the key's current state (which in turn will likely change its skin).
   *
   * @param state The state to change to. Allowed states are defined in the
   * <code>AVAILABLE_STATES</code> constant array.
   */
  void changeState(String state) {
    // If the state is invalid or not being changed, abort!
    if (AVAILABLE_STATES.indexOf(state) == -1 || state == _state) return;
    _state = state;

    // Remove old skin
    int index = getChildIndex(_skin);
    if (index >= 0) removeChildAt(index);
    /*
			// Fetch new skin by using dynamic variable name
			if( isSpecial != null || isSpecial == true) {
				_skin = this['specialKey' + _state + 'Skin'];
			} else if( hasVariants != null || hasVariants == true) {
				_skin = this['hasVariantsKey' + _state + 'Skin'];
			} else {
				_skin = this['regularKey' + _state + 'Skin'];
			}
			*/
    // If the requested skin cannot be found, use the generic template
    if (_skin == null) _skin = _buildGenericSkin();

    // Insert new skin
    addChildAt(_skin, 0);
  }

  /** @ */
  void _onTouch(InputEvent e) {
    e.stopImmediatePropagation();

    num localX = e.stageX;
    num localY = e.stageY;

    // Check if the event is a MOUSE_OUT (which, in Starling, is a TouchEvent with no touch
    // object attached)
    /*
		    if( touch == null || touch == false) {
				changeState(UP_STATE);
				return;
			}
			*
			 */

    // Positions of the original touch and variants touch (if any)
    Point touchPosInOriginalKeySpace = new Point(localX, localY);

    if (e.type == TouchEvent.TOUCH_BEGIN || e.type == MouseEvent.MOUSE_DOWN) {
      changeState(DOWN_STATE);

      // Trigger keyDown event (unless its the SWITCH_LAYOUT button which is ignored)
      if (charCode != CharCode.SWITCH_LAYOUT) {
        _triggerEvent(this, KeyEvent.KEY_DOWN);
      }

      // Check if the key has variants attached to it
      if (hasVariants) {
        _variantsTimer = new Timer(new Duration(milliseconds: keyVariantsDelay), _onShowAlternates);
      }
    }
    /*else if (touch.phase == TouchPhase.HOVER) {
				
				// For mouse input only
				changeState(HOVER_STATE);
				
			} */
    else if (_state == DOWN_STATE && (e.type == TouchEvent.TOUCH_MOVE || e.type == MouseEvent.MOUSE_MOVE)) {
      // Moving while pressing

      // Check if the user is staying over the original key when moving or not.
      if (hitTestPoint(touchPosInOriginalKeySpace.y, touchPosInOriginalKeySpace.y, false)) {
        changeState(DOWN_STATE);
        if (hasVariants && !_variantsTimer.isActive) {
          _variantsTimer = new Timer(new Duration(milliseconds: keyVariantsDelay), _onShowAlternates);
        }
      } else {
        changeState(UP_STATE);
        if (_variantsTimer != null) {
          _variantsTimer.cancel();
        }
      }

      // If the key has variants and the variants are currently being displayed, check if
      // one should be highlighted
      if (hasVariants && _variantsContainer.numChildren > 0) {
        // Loop through all alternate keys to see if we are above one
        for (Key altKey in variants) {
          if (altKey.hitTestPoint(touchPosInOriginalKeySpace.x, touchPosInOriginalKeySpace.y, false)) {
            altKey.changeState(DOWN_STATE);
          } else {
            altKey.changeState(UP_STATE);
          }
        }
      }
    } else if (e.type == TouchEvent.TOUCH_END || e.type == MouseEvent.MOUSE_UP) {
      if (variants != null || variants == true) {
        // Reset
        _variantsTimer.cancel();

        // Loop through all alternate keys to see if we are above one of them. If it's
        // the case, trigger event for that variant key
        for (Key altK in variants) {
          if (altK.hitTestPoint(touchPosInOriginalKeySpace.x, touchPosInOriginalKeySpace.y, false)) {
            _triggerEvent(altK, KeyEvent.KEY_UP);
            altK.changeState(UP_STATE);
            break;
          }
        }

        // Empty the callout container when done.
        _variantsContainer.removeChildren();
      }

      // Abort if the release is outside the original key
      if (!hitTestPoint(touchPosInOriginalKeySpace.x, touchPosInOriginalKeySpace.y, true)) {
        return;
      }

      // Trigger event
      changeState(UP_STATE);
      _triggerEvent(this, KeyEvent.KEY_UP);

      if (isPrintable) {
        _triggerEvent(this, KeyEvent.KEY_UP_PRINTABLE);
      }
      if (isVisible || _charCode == CharCode.SPACE) {
        _triggerEvent(this, KeyEvent.KEY_UP_VISIBLE);
      }
    }
  }

  /** @ */
  void _triggerEvent(Key key, String type) {
    // Trigger requested keyboard event
    KeyEvent event = new KeyEvent(type, key.charCode, key.character);
    dispatchEvent(event);
  }

  /** @ */
  void _onShowAlternates() {
    // Place variants in the container
    Point pos = new Point(0, 0);
    for (Key altKey in variants) {
      _variantsContainer.addChild(altKey);
      altKey.x = pos.x;
      altKey.width = width;
      altKey.height = height;
      pos.x += altKey.width + 5;
    }

    // Dispatch event
    Event event = new KeyEvent(KeyEvent.SHOW_VARIANTS, charCode, character);
    dispatchEvent(event);
  }

  /**
   * Changes the case of the character, label and variants of the key. This only affects keys
   * whose <code>isVisible</code> property return <code>true</code>.
   *
   * @param keyCase Desired case: <code>TypographicCase.UPPERCASE</code> or
   * <code>TypographicCase.LOWERCASE</code>.
   */
  void changeCase(String keyCase) {
    if (keyCase == UPPERCASE) {
      uppercase();
    } else if (keyCase == LOWERCASE) {
      lowercase();
    }
  }

  /**
   * Uppercases the character, label and variants of the key. This only affects keys whose
   * <code>isVisible</code> property return <code>true</code>.
   */
  void uppercase() {
    if (isVisible == true) {
      _label.text = _label.text.toUpperCase();
      _character = character.toUpperCase();
      _charCode = _character.codeUnitAt(0);

      if (_variants != null) {
        for (Key k in _variants) {
          if (k.isVisible) k.uppercase();
        }
      }
    }
  }

  /**
   * Lowercases the character, label and variants of the key. This only affects keys whose
   * <code>isVisible</code> property return <code>true</code>.
   */
  void lowercase() {
    if (isVisible == true) {
      _label.text = _label.text.toLowerCase();
      _character = character.toLowerCase();
      _charCode = _character.codeUnitAt(0);

      if (_variants != null) {
        for (Key k in _variants) {
          if (k.isVisible) k.lowercase();
        }
      }
    }
  }

  /** @ */
  DisplayObject _buildGenericSkin() {
    // Temporarily draw into a Shape object
    Sprite canvas = GraphicsUtil.rectangle(0, 0, 44, 52, color: PaperColor.BLUE);
    return canvas;
  }

  /** Relative width of the key expressed as a ratio of the default key width. */
  num get relativeWidth {
    return _relativeWidth;
  }

  /** Relative height of the key expressed as a ratio of the default key height. */
  num get relativeHeight {
    return _relativeHeight;
  }

  /** The type of key (character, navigation, modifier, etc.). */
  String get type {
    return _type;
  }

  /** Listof keys accessible by pressing and holding the key. */
  List<Key> get variants {
    return _variants;
  }

  /** The single character associated to the key. */
  String get character {
    return _character;
  }

  /** The character code of the key. */
  int get charCode {
    return _charCode;
  }

  /**
   * Indicates if the key is associated with a printable character. Printable characters
   * include all letters, numbers and symbols as well as the ENTER, SPACE and TAB keys.
   */
  bool get isPrintable {
    return (type == CHARACTER_KEY ||
        type == NUMERIC_KEYPAD_KEY ||
        _charCode == CharCode.ENTER ||
        _charCode == CharCode.TAB);
  }

  /**
   * Indicates if the key is associated with a visible character. Visible characters include
   * all letters, numbers and symbols.
   */
  bool get isVisible {
    return ((type == CHARACTER_KEY || type == NUMERIC_KEYPAD_KEY) &&
        !(_charCode == CharCode.ENTER || _charCode == CharCode.TAB || _charCode == CharCode.SPACE));
  }

  /**
   * Indicates if the key is 'selected'. The selected state is currently only used for the
   * <code>CAPS_LOCK</code> key. When the <code>CAPS_LOCK</code> is engaged, a different icon
   * is shown.
   */
  bool get isSelected {
    return _isSelected;
  }

  /** @ */
  void set isSelected(bool value) {
    if (value == _isSelected) return;
    _isSelected = value;

    // Swap icon (if an appropriate one has been defined)
    if ((_isSelected && selectedIcon != null) || (!_isSelected && icon != null)) {
      int index = getChildIndex(_icon);
      _icon = _isSelected ? selectedIcon : icon;
      removeChildAt(index);
      addChildAt(_icon, index);
      //TODO don't know\ninvalidate(INVALIDATION_FLAG_SKIN);

    }
  }

  /**
   * Indicates if the key is 'special'. A 'special' key is any key that is not a regular
   * alpha-numeric character or the space character key.
   */
  bool get isSpecial {
    return (type != CHARACTER_KEY);
  }

  /** Indicates whether the key is a variant key (or as true) a primary key (false) */
  bool get isVariant {
    return _isVariant;
  }

  /** @ */
  void set isVariant(bool value) {
    _isVariant = value;
  }

  /** Indicates whether the key is a variant key (or as true) a primary key (false) */
  bool get hasVariants {
    return (_variants != null);
  }

  Sprite get variantsContainer {
    return _variantsContainer;
  }

  /** The Label object used by this key */
  Label get label {
    return _label;
  }

  /** @ */
  void set label(Label value) {
    _label = value;
  }
}
