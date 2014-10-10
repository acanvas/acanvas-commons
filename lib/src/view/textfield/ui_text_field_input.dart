part of stagexl_commons;

/**
	 * Copyright (2009 as c), Jung von Matt/Neckar
	 * All rights reserved.
	 *
	 * @author	Thomas Eckhardt
	 * @since	22.07.2009 12:11:50
	 */

class UITextFieldInput extends UITextField {

  UITextFieldInput(String value, TextFormat format) : super(value, format, false) {

    type = TextFieldType.INPUT;
    //selectable = true;
    mouseEnabled = true;
    autoSize = TextFieldAutoSize.NONE;
    wordWrap = false;
    multiline = false;
  }

  //TODO implement restrict
  String restrict = "";

  //TODO implement selectable
  bool selectable = false;

}
