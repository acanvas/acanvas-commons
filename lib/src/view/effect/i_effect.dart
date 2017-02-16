part of rockdot_commons;

/**
 * @author nilsdoehring
 */

abstract class IEffect {
  void set duration(num duration);

  num get duration;

  void set initialAlpha(num initialAlpha);

  num get initialAlpha;

  void set type(String type);

  String get type;

  bool get applyRecursively;

  void set sprite(Sprite spr);

  Sprite get sprite;

  bool useSprite();

  void runInEffect(BoxSprite target, double duration, Function callback);

  void runOutEffect(BoxSprite target, double duration, Function callback);

  void cancel([BoxSprite target = null]);

  void dispose({bool removeSelf: true});
}
