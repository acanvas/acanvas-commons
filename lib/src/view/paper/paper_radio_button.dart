part of stagexl_commons;


/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
class PaperRadioButton extends RadioButton {
  int RADIUS = 30;

  int activeColor;
  String label;
  
  Shape _icon;
  Shape _bg;
  PaperText _paperLabel;

  PaperRadioButton({int rippleColor: PaperColor.GREY_DARK, this.activeColor : PaperColor.GREEN, this.label : ""}) : super() {
    ignoreCallSetSize = false;
        
    PaperRipple ripple = new PaperRipple(type: PaperRipple.CIRCLE, color: rippleColor, velocity : .2);
    ripple.ignoreCallSetSize = true;
    addChild(ripple);
    ripple.setSize(RADIUS * 2, RADIUS * 2);

    _bg = new Shape();
    _bg.graphics.circle(30, 30, 8);
    _bg.graphics.strokeColor(PaperColor.BLACK, 2);
    _bg.graphics.circle(30, 30, 30);
    _bg.graphics.fillColor(0x00555555);
    if (ContextTool.WEBGL) {
      _bg.applyCache(0, 0, 60, 60);
    }
    addChild(_bg);

    _icon = new Shape();
    _icon.graphics.circle(0, 0, 10);
    _icon.graphics.fillColor(activeColor);
    if (ContextTool.WEBGL) {
      _icon.applyCache(-10, -10, 20, 20);
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
    _icon.x = _icon.y = 30;
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
      _icon.scaleX = _icon.scaleY = .1;
      _icon.visible = true;
      ContextTool.STAGE.juggler.addTween(_icon, .1).animate
        ..scaleX.to(1)
        ..scaleY.to(1);
      if(_paperLabel != null){
        _paperLabel.color = activeColor;
      }
    }
    else{
      Tween tw = new Tween(_icon, .2);
      tw.animate
      ..scaleX.to(.1)
      ..scaleY.to(.1);
      tw.onComplete = () => _icon.visible = false;
      ContextTool.STAGE.juggler.add(tw);
      if(_paperLabel != null){
        _paperLabel.color = PaperColor.BLACK;
      }
    }
    
  }
}
