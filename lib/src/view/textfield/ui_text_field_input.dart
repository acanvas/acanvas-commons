part of stagexl_commons;

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
