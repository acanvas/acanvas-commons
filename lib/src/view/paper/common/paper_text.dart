part of stagexl_commons;

class PaperText extends UITextField {
  static const DEFAULT_FONT = "Roboto, Helvetica, Arial";

  PaperText(String text, {int size: 14, int color: PaperColor.BLACK, String fontName: DEFAULT_FONT, int weight: 400})
      : super(text, new TextFormat(fontName, size, color, weight: weight), true) {
    //format.leading = -2;
    width = 320;
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
