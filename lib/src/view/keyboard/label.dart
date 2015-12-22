part of rockdot_commons;

class Label extends MdText {
  List nameList = [];

  Label([String value = "", TextFormat format, bool html = true]) : super(value, color: MdColor.WHITE, size: 24) {}
}
