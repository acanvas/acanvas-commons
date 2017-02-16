part of rockdot_commons;

/**
 * @author nilsdoehring
 */

class BasicEffect implements IEffect {
  String _type;

  String get type {
    return _type;
  }

  void set type(String type) {
    _type = type;
  }

  num _initialAlpha;

  num get initialAlpha {
    return _initialAlpha;
  }

  void set initialAlpha(num initialAlpha) {
    _initialAlpha = initialAlpha;
  }

  num _duration;

  void set duration(num duration) {
    _duration = duration;
  }

  num get duration {
    return _duration;
  }

  Sprite _sprite;

  void set sprite(Sprite sprite) {
    _sprite = sprite;
  }

  Sprite get sprite {
    return _sprite;
  }

  bool _useSprite;

  bool useSprite() {
    return _useSprite;
  }

  bool _applyRecursively;

  bool get applyRecursively {
    return _useSprite == true ? false : _applyRecursively;
  }

  Stage _stage;

  BasicEffect() {
    _stage = Rd.STAGE;
    _duration = 0.5;
    _applyRecursively = false;
    _useSprite = false;
  }

  Bitmap registerBitmapSprite(BoxSprite target) {
    _applyRecursively = false;

    target.alpha = 1;
    Rectangle rect = target.getBounds(_stage);

    BitmapData output = new BitmapData((rect.width + 20).ceil(), (rect.height + 20).ceil(), 0x00000000);
    Matrix mat = target.transformationMatrix != null ? target.transformationMatrix : new Matrix(0, 0, 0, 0, 0, 0);
    _sprite.x = mat.tx;
    _sprite.y = mat.ty;

    mat.setTo(mat.a, mat.b, mat.c, mat.d, 0, 0);
    output.draw(target, mat);

    Bitmap outputBmp = new Bitmap(output);
    //outputBmp.applyCache(0, 0, output.width, output.height);
    target.alpha = 0;

    _sprite.addChild(outputBmp);
    return outputBmp;
  }

  //These two are the only methods you'll need to override @see BitmapAlphaEffect.
  void runInEffect(BoxSprite target, double duration, Function callback) {
    target.alpha = 0;

    var tween = new Tween(target, duration, Transition.easeInCubic);
    tween.animate.alpha.to(1.0); // target value = 0.0
    tween.onComplete = () => callback.call();
    Rd.JUGGLER.add(tween);
  }

  void runOutEffect(BoxSprite target, double duration, Function callback) {
    //target.visible = true;
    target.alpha = 1;

    var tween = new Tween(target, duration, Transition.easeInCubic);
    tween.animate.alpha.to(0); // target value = 0.0
    tween.onComplete = () => callback.call();
    Rd.JUGGLER.add(tween);
  }

  void cancel([BoxSprite target = null]) {
    if (target == null) return;

    Rd.JUGGLER.removeTweens(target);

    DisplayObject child;
    for (int i = 0; i < (target).numChildren; i++) {
      child = (target).getChildAt(i);
      if (child is BoxSprite) {
        cancel(child);
      }
    }
  }

  void onComplete([Bitmap target = null, BoxSprite page = null, Function callback = null]) {
    Rd.JUGGLER.removeTweens(target);

    if (target != null) {
      if (target.parent != null) {
        target.parent.removeChild(target);
      }
      target.bitmapData.clear();
    }

    if (page != null) {
      page.alpha = 1;
    }

    if (callback != null) {
      callback.call(null);
    }

    dispose();
  }

  void dispose({bool removeSelf: true}) {
    if (_sprite != null && useSprite()) {
      Rd.JUGGLER.removeTweens(_sprite);
      if (_sprite.parent != null) {
        _sprite.parent.removeChild(_sprite);
      }
      _sprite.removeChildren();
      // _sprite = null;
    }
  }
}
