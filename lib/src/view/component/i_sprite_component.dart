part of stagexl_commons;

abstract class ISpriteComponent extends EventDispatcher implements Sprite{

  void setSize(num w, num h);

  void destroy();
  void appear([double duration = 0.5]);
  void disappear([double duration = 0.5, bool autoDestroy = false]);

  void redraw();

  num get widthAsSet;
  void set widthAsSet(num w);

  num get heightAsSet;
  void set heightAsSet(num h);

  bool get enabled;
  void set enabled(bool enabled);

  void set visible(bool visible);

  bool get ignoreSetEnabled;
  void set ignoreSetEnabled(bool enabled);

  bool get ignoreSetTouchEnabled;
  void set ignoreSetTouchEnabled(bool enabled);

  bool get ignoreCallSetSize;
  void set ignoreCallSetSize(bool enabled);

  bool get ignoreCallDestroy;
  void set ignoreCallDestroy(bool enabled);

  bool get resizeTextChildren;
  void set resizeTextChildren(bool enabled);

}
