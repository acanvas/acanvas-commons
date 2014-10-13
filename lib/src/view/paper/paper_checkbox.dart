part of stagexl_commons;


/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
class PaperCheckbox extends ToggleButton {
  int RADIUS = 30;
  int BOXWIDTH = 20;

  int activeColor;
  String label;
  
  Shape _icon;
  Shape _bg;
  Shape _box;
  PaperText _paperLabel;

  PaperCheckbox({int rippleColor: PaperColor.GREY_DARK, this.activeColor : PaperColor.GREEN, this.label : ""}) : super() {
    ignoreCallSetSize = false;
    
    PaperRipple ripple = new PaperRipple(type: PaperRipple.CIRCLE, color: rippleColor, velocity : .2);
    ripple.ignoreCallSetSize = true;
    addChild(ripple);
    ripple.setSize(RADIUS * 2, RADIUS * 2);

    _bg = new Shape();
    _bg.graphics.rect(0, 0, RADIUS*2, RADIUS*2);
    _bg.graphics.fillColor(0x00555555);
    if (ContextTool.WEBGL) {
      _bg.applyCache(0, 0, RADIUS*2, RADIUS*2);
    }
    addChild(_bg);

    _box = new Shape();
    _box.graphics.rect(-BOXWIDTH/2, -BOXWIDTH/2, BOXWIDTH, BOXWIDTH);
    _box.graphics.strokeColor(PaperColor.BLACK, 2);
    if (ContextTool.WEBGL) {
      _box.applyCache(-(BOXWIDTH/2).round(), -(BOXWIDTH/2).round(), BOXWIDTH, BOXWIDTH);
    }
    addChild(_box);

    _icon = new Shape();
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

    if(label != ""){
      _paperLabel = new PaperText(label, size : 16);
      addChild(_paperLabel);
    }

    enabled = true;
    
  }

  @override void redraw() {
    _icon.x = 29;
    _icon.y = 37;
    _box.x = _box.y = 30;
    
    if(_paperLabel != null){
      _paperLabel.x = 60;
      _paperLabel.y = 20;
    }
    super.redraw();
  }

  @override
  void set isToggled(bool value) {
    if(value == isToggled) return;
    super.isToggled = value;
    
    if(isToggled){
      _icon.scaleX = _icon.scaleY = .3;
      _icon.visible = true;

      stage.juggler.tween(_box, .15).animate
        ..alpha.to(0)
        ..rotation.to(.8)
        ..scaleX.to(.3)
        ..scaleY.to(.3);
      
      stage.juggler.tween(_icon, .1)
        ..animate.scaleX.to(1)
        ..animate.scaleY.to(1)
        ..delay = .1;
      
      if(_paperLabel != null){
        _paperLabel.color = activeColor;
      }
    }
    else{
      Tween tw = new Tween(_icon, .2);
      tw.animate
      ..scaleX.to(.3)
      ..scaleY.to(.3);
      tw.onComplete = () { 
        _icon.visible = false;
        };
      stage.juggler.add(tw);

      stage.juggler.tween(_box, .1)
              ..animate.alpha.to(1)
              ..animate.rotation.to(0)
              ..animate.scaleX.to(1)
              ..animate.scaleY.to(1)
              ..delay = .15;
      
      if(_paperLabel != null){
        _paperLabel.color = PaperColor.BLACK;
      }
    }
    
  }
}