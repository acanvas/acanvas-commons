part of dart_commons;

class PaperText extends UITextField {
  static const DEFAULT_FONT = "Roboto, Helvetica, Arial";
  
  PaperText(String text, {int size : 14, int color : PaperColor.BLACK, String fontName : DEFAULT_FONT}) : super(text, new TextFormat(fontName, size, color), true) {
    //format.leading = -2;
  }

  
  void set leading(double value) {
    TextFormat format = defaultTextFormat;
    format.leading = value;
    defaultTextFormat = format;
  }


  TextFormat get format {
    return defaultTextFormat;
  }


  void set format(TextFormat value) {
    defaultTextFormat = value;
  }
}
