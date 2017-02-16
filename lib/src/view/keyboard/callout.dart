part of rockdot_commons;

class Callout extends LifecycleSprite {
  List<String> nameList = [];
  static const String DIRECTION_UP = "DIRECTION_UP";
  static const String DIRECTION_DOWN = "DIRECTION_DOWN";

  Callout() : super("keyboard.callout") {}

  Callout.show(Sprite variantsContainer, Key key, String direction, bool arg3) : super("keyboard.callout") {}
}
