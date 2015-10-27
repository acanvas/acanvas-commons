part of stagexl_commons;

class PaperShadow extends BoxSprite implements IPaperButtonComponent {
  static const int RECTANGLE = 1;
  static const int CIRCLE = 2;

  static int QUALITY = ContextTool.MOBILE ? 1 : 3;

  int _blurXY = 1;
  int _initialDistance = 1;
  int _activeDistance = 4;
  DropShadowFilter _shadow;
  Translation _trans;

  int type;
  int bgColor;
  bool shadowEnabled;
  bool respondToClick;
  int shadowColor;
  int elevation;
  Sprite target;

  PaperShadow(
      {this.type: RECTANGLE,
      this.bgColor: 0xFFFFFFFF,
      this.shadowEnabled: true,
      this.shadowColor: PaperColor.GREY_SHADOW,
      this.respondToClick: true,
      this.elevation: 1,
      this.target})
      : super() {
    inheritSpan = true;
  }

  @override
  void refresh() {
    _drawShapes(shadowEnabled);
  }

  void _drawShapes(bool shadow) {
    switch (type) {
      case RECTANGLE:
        if (shadow) {
          GraphicsUtil.rectangle(0, -1, spanWidth, spanHeight,
              round: true, color: 0x11000000, sprite: target != null ? target : this, clear: true);
          GraphicsUtil.rectangle(-1, 0, spanWidth + 2, spanHeight + 1,
              round: true, color: 0x22000000, sprite: target != null ? target : this, clear: false);
          GraphicsUtil.rectangle(0, 0, spanWidth, spanHeight + 2,
              round: true, color: 0x33000000, sprite: target != null ? target : this, clear: false);
        }
        GraphicsUtil.rectangle(0, 0, spanWidth, spanHeight,
            round: true, color: bgColor, sprite: target != null ? target : this, clear: !shadow);
        break;
      case CIRCLE:
        if (shadow) {
          //GraphicsUtil.circle(spanWidth/2, spanWidth/2-1, spanWidth/2,   round : true, color: 0x11000000, sprite: target != null ? target : this, clear : true);
          //GraphicsUtil.circle(spanWidth/2-1, spanWidth/2, spanWidth/2+1, round : true, color: 0x22000000, sprite: target != null ? target : this, clear : false);
          GraphicsUtil.circle(spanWidth / 2, spanWidth / 2 + 1, spanWidth / 2 + 1,
              round: true, color: 0x33000000, sprite: target != null ? target : this, clear: true);
        }
        GraphicsUtil.circle(spanWidth / 2, spanWidth / 2, spanWidth / 2,
            round: true, color: bgColor, sprite: target != null ? target : this, clear: !shadow);
        break;
    }
  }

  @override
  downAction([Event e = null]) {
    if (!respondToClick || !shadowEnabled || !ContextTool.WEBGL) return;
    _prepareShadowAnimation();

    if (_trans != null && ContextTool.JUGGLER.contains(_trans)) {
      ContextTool.JUGGLER.remove(_trans);
    }
    _trans = new Translation(_initialDistance, _activeDistance, .15)
      ..onUpdate = (num val) {
        _shadow.distance = val;
        _shadow.blurX = (val * 4).round();
        _shadow.blurY = (val * 4).round();
      };

    ContextTool.JUGGLER.add(_trans);
  }

  @override
  upAction([Event e = null]) {
    if (!respondToClick || !shadowEnabled || !ContextTool.WEBGL) return;
    if (_trans != null && ContextTool.JUGGLER.contains(_trans)) {
      ContextTool.JUGGLER.remove(_trans);
    }
    _prepareShadowAnimation();
    _trans = new Translation(_activeDistance, _initialDistance, .15)
      ..onUpdate = (num val) {
        _shadow.distance = val;
        _shadow.blurX = (val * 4).round();
        _shadow.blurY = (val * 4).round();
      }
      ..onComplete = () => _killShadow();

    ContextTool.JUGGLER.add(_trans);
  }

  void _prepareShadowAnimation() {
    if (_shadow == null) {
      _shadow = new DropShadowFilter(_initialDistance, PI / 2, shadowColor, _blurXY, _blurXY, QUALITY);
      target != null ? target.filters = [_shadow] : filters = [_shadow];
    }
    _drawShapes(false);
  }

  void _killShadow() {
    _drawShapes(true);
    target != null ? target.filters = [] : filters = [];
    _shadow = null;
  }
}
