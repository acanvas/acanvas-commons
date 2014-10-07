part of stagexl_commons;

abstract class IManagedSpriteComponent extends ISpriteComponent{

  void init([data = null]);
  
  void load([data = null]);

  void setData(data);

  bool getInitialized();
  bool getLoaded();
  
  String get name;
  void set enabled(bool enabled);
}
