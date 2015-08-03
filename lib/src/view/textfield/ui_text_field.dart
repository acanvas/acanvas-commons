part of stagexl_commons;

class UITextField extends TextField {

  UITextField(String value, TextFormat format, [bool html = true]) : super() {

    defaultTextFormat = format != null ? format : new TextFormat("Helvetica, Arial", 12, 0x000000);

    // Standardwerte für dynamische Textfelder setzen
    displayAsPassword = false;
    type = TextFieldType.DYNAMIC;
    maxChars = 0;
    //	restrict = null;

    // Mouse-Interaktion
    //mouseWheelEnabled = false;
    mouseEnabled = false;
    //selectable = false;

    // Textfeldverhalten
    autoSize = TextFieldAutoSize.LEFT;
    wordWrap = true;
    multiline = true;

    // Dekorationen
    background = false;
    backgroundColor = 0x0;
    border = false;
    borderColor = 0x0;

    text = value;

  }

  void keyDownAction(int keyCode) {
    //print(keyCode);
    dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, false, keyCode, KeyLocation.STANDARD, false, false, false));
  }

  void textInputAction(String text) {
    dispatchEvent(new TextEvent(TextEvent.TEXT_INPUT, false, text));
  }

  int get color {
    return (defaultTextFormat.color);
  }

  void set color(int value) {
    TextFormat format = defaultTextFormat;
    format.color = value;
    defaultTextFormat = (format);
  }

  bool get underline {
    return defaultTextFormat.underline;
  }

  void set underline(bool value) {
    TextFormat format = defaultTextFormat;
    format.underline = value;
    defaultTextFormat = (format);
  }

  @override
  num get width {
    return textWidth;
  }

  @override
  num get height {
    return textHeight;
  }
}
