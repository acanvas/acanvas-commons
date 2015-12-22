part of rockdot_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class MdToggleButton extends SelectableButton {
  int RADIUS = 30;

  int activeColor;
  String label;
  int labelOffset;

  Sprite _icon;
  Sprite _bg;
  Sprite _inactiveLine;
  Sprite _activeLine;
  MdText _paperLabel;

  MdRipple _ripple;
  BoxSprite _holder;

  MdToggleButton(
      {int rippleColor: MdColor.GREY_DARK,
      this.activeColor: MdColor.GREEN,
      this.label: "",
      this.labelOffset: 150})
      : super() {
    _holder = new BoxSprite();

    _ripple = new MdRipple(type: MdRipple.CIRCLE, color: rippleColor, velocity: .2);
    _ripple.inheritSpan = false;
    addChild(_ripple);
    _ripple.span(RADIUS * 2, RADIUS * 2);

    _inactiveLine = new Sprite();
    addChild(_inactiveLine);
    _drawLine(_inactiveLine, MdColor.BLACK, 1);

    _activeLine = new Sprite();
    addChild(_activeLine);
    _drawLine(_activeLine, activeColor, 1);
    _activeLine.visible = false;

    _bg = new Sprite();
    _bg.graphics.circle(30, 30, 8);
    _bg.graphics.strokeColor(MdColor.BLACK, 2);
    _bg.graphics.circle(30, 30, 30);
    _bg.graphics.fillColor(0x00555555);
    if (Rd.WEBGL) {
      _bg.applyCache(0, 0, 60, 60);
    }
    _holder.addChild(_bg);

    _icon = new Sprite();
    _icon.graphics.circle(0, 0, 10);
    _icon.graphics.fillColor(activeColor);
    _holder.addChild(_icon);
    _icon.visible = false;

    addChild(_holder);

    if (label != "") {
      _paperLabel = new MdText(label, size: 16);
      addChild(_paperLabel);
    }
  }

  @override void refresh() {
    _inactiveLine.x = labelOffset + 38;
    _activeLine.x = labelOffset + 38;
    _inactiveLine.y = _activeLine.y = 30;

    _holder.x = labelOffset;
    _ripple.x = labelOffset;
    _icon.x = 30;
    _icon.y = 30;

    if (_paperLabel != null) {
      _paperLabel.x = 20;
      _paperLabel.y = 20;
      _paperLabel.width = labelOffset - 20;
    }
    super.refresh();
    spanHeight -= 10;
  }

  @override void selectAction() {
    _icon.scaleX = _icon.scaleY = .1;
    _icon.visible = true;
    _activeLine.visible = true;
    Rd.JUGGLER.addTween(_icon, .1).animate..scaleX.to(1)..scaleY.to(1);
    Rd.JUGGLER.addTween(_holder, .1).animate..x.to(labelOffset + 48);
    Rd.JUGGLER.addTween(_ripple, .1).animate..x.to(labelOffset + 48);
    if (_paperLabel != null) {
      _paperLabel.color = activeColor;
    }
  }

  @override void deselectAction() {
    Rd.JUGGLER.addTween(_holder, .1).animate..x.to(labelOffset);
    Rd.JUGGLER.addTween(_ripple, .1).animate..x.to(labelOffset);
    Tween tw = new Tween(_icon, .2);
    tw.animate..scaleX.to(.1)..scaleY.to(.1);
    tw.onComplete = () {
      _icon.visible = false;
      _activeLine.visible = false;
    };
    Rd.JUGGLER.add(tw);
    if (_paperLabel != null) {
      _paperLabel.color = MdColor.BLACK;
    }
  }

  void _drawLine(Sprite line, int color, num strength) {
    line.graphics.beginPath();
    line.graphics.moveTo(0, 0);
    line.graphics.lineTo(32, 0);
    line.graphics.closePath();
    line.graphics.strokeColor(color, strength);
    if (Rd.WEBGL) {
      line.applyCache(0, 0, 32, strength);
    }
  }
}
