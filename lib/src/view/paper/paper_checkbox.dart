part of stagexl_commons;


/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class PaperCheckbox extends SelectableButton {
  int RADIUS = 30;
  int BOXWIDTH = 20;

  int boxColor;
  int activeColor;
  String label;

  Sprite _icon;
  Sprite _bg;
  Sprite _box;
  PaperText _paperLabel;

  PaperCheckbox({int rippleColor: PaperColor.GREY_DARK, this.activeColor : PaperColor.GREEN, this.label : "", this.boxColor : PaperColor.BLACK}) : super() {

    PaperRipple ripple = new PaperRipple(type: PaperRipple.CIRCLE, color: rippleColor, velocity : .2);
    ripple.inheritSpan = false;
    addChild(ripple);
    ripple.span(RADIUS * 2, RADIUS * 2);

    _bg = new Sprite();
    _bg.graphics.rect(0, 0, RADIUS * 2, RADIUS * 2);
    _bg.graphics.fillColor(0x00555555);
    addChild(_bg);

    _box = new Sprite();
    _box.graphics.rect(-BOXWIDTH / 2, -BOXWIDTH / 2, BOXWIDTH, BOXWIDTH);
    _box.graphics.strokeColor(boxColor, 2);
    if (ContextTool.WEBGL) {
      _box.applyCache(-(BOXWIDTH / 2).round(), -(BOXWIDTH / 2).round(), BOXWIDTH, BOXWIDTH);
    }
    addChild(_box);

    _icon = new Sprite();
    _icon.graphics.beginPath();
    _icon.graphics.moveTo(-6, -6);
    _icon.graphics.lineTo(0, 0);
    _icon.graphics.lineTo(15, -15);
    _icon.graphics.strokeColor(activeColor, 3);
    _icon.graphics.closePath();
    if (ContextTool.WEBGL) {
      _icon.applyCache(-8, -17, 26, 20);
    }
    addChild(_icon);
    _icon.visible = false;

    if (label != "") {
      _paperLabel = new PaperText(label, size : 16);
      addChild(_paperLabel);
    }

  }

  @override void refresh() {
    _icon.x = 29;
    _icon.y = 37;
    _box.x = _box.y = 30;

    if (_paperLabel != null) {
      _paperLabel.x = 60;
      _paperLabel.y = 20;
      _paperLabel.width = spanWidth - _paperLabel.x;
    }
    super.refresh();
    spanHeight -= 10;
  }

  @override void selectAction() {
    _icon.scaleX = _icon.scaleY = .3;
    _icon.visible = true;

    ContextTool.STAGE.juggler.addTween(_box, .15).animate
      ..alpha.to(0)
      ..rotation.to(.8)
      ..scaleX.to(.3)
      ..scaleY.to(.3);

    ContextTool.STAGE.juggler.addTween(_icon, .1)
      ..animate.scaleX.to(1)
      ..animate.scaleY.to(1)
      ..delay = .1;

    if (_paperLabel != null) {
      _paperLabel.color = activeColor;
    }
  }

  @override void deselectAction() {
    Tween tw = new Tween(_icon, .2);
    tw.animate
      ..scaleX.to(.3)
      ..scaleY.to(.3);
    tw.onComplete = () {
      _icon.visible = false;
    };
    ContextTool.STAGE.juggler.add(tw);

    ContextTool.STAGE.juggler.addTween(_box, .1)
      ..animate.alpha.to(1)
      ..animate.rotation.to(0)
      ..animate.scaleX.to(1)
      ..animate.scaleY.to(1)
      ..delay = .15;

    if (_paperLabel != null) {
      _paperLabel.color = PaperColor.BLACK;
    }
  }
}
