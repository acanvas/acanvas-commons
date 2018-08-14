part of acanvas_commons;

class Label extends MdText {
  List<String> nameList = [];

  Label([String value = "", TextFormat format, bool html = true])
      : super(value, color: MdColor.WHITE, size: 24) {}
}
