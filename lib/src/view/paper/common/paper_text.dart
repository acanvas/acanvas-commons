part of dart_commons;

class PaperText extends UITextField {
  PaperText(String text, [int size = 14, int color = PaperColor.BLACK]) : super(text, new TextFormat("Roboto, Helvetica, Arial", size, color), true) {
    format.leading = -2;
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
