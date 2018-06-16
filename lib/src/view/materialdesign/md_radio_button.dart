part of acanvas_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class MdRadioButton extends SelectableButton {
  int RADIUS = 30;

  int activeColor;
  String label;

  Sprite _icon;
  Sprite _bg;
  MdText _paperLabel;

  MdRadioButton({int rippleColor: MdColor.GREY_DARK, this.activeColor: MdColor.GREEN, this.label: ""}) : super() {
    inheritSpan = true;

    MdRipple ripple = new MdRipple(type: MdRipple.CIRCLE, color: rippleColor, velocity: .2);
    ripple.inheritSpan = false;
    addChild(ripple);
    ripple.span(RADIUS * 2, RADIUS * 2);

    _bg = new Sprite();
    _bg.graphics.circle(30, 30, 8);
    _bg.graphics.strokeColor(MdColor.BLACK, 2);
    _bg.graphics.circle(30, 30, 30);
    _bg.graphics.fillColor(0x00555555);
    if (Ac.WEBGL) {
      //_bg.applyCache(0, 0, 60, 60);
    }
    addChild(_bg);

    _icon = new Sprite();
    _icon.graphics.circle(0, 0, 10);
    _icon.graphics.fillColor(activeColor);
    addChild(_icon);
    _icon.visible = false;

    if (label != "") {
      _paperLabel = new MdText(label, size: 16);
      addChild(_paperLabel);
    }

    enabled = true;
    _icon.scaleX = _icon.scaleY = .1;
  }

  @override
  void refresh() {
    _icon.x = _icon.y = 30;
    if (_paperLabel != null) {
      _paperLabel.x = 60;
      _paperLabel.y = 20;
    }
    super.refresh();
  }

  void selectAction() {
    _icon.scaleX = _icon.scaleY = .1;
    _icon.visible = true;
    Ac.JUGGLER.addTween(_icon, .1).animate..scaleX.to(1)..scaleY.to(1);
    if (_paperLabel != null) {
      _paperLabel.color = activeColor;
    }
  }

  void deselectAction() {
    Tween tw = new Tween(_icon, .2);
    tw.animate..scaleX.to(.1)..scaleY.to(.1);
    tw.onComplete = () => _icon.visible = false;
    Ac.JUGGLER.add(tw);
    if (_paperLabel != null) {
      _paperLabel.color = MdColor.BLACK;
    }
  }
}
