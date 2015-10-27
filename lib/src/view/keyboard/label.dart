part of stagexl_commons;

class Label extends PaperText {
  List nameList = [];

  Label([String value = "", TextFormat format, bool html = true]) : super(value, color: PaperColor.WHITE, size: 24) {}
}
