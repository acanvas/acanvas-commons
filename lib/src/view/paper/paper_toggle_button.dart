part of stagexl_commons;


/**
	 * @author Nils Doehring (nilsdoehring@gmail.com)
	 */
class PaperToggleButton extends ToggleButton {
  int RADIUS = 30;

  int activeColor;
  String label;
  int labelOffset;
  
  Shape _icon;
  Shape _bg;
  Shape _inactiveLine;
  Shape _activeLine;
  PaperText _paperLabel;

  PaperRipple _ripple;
  SpriteComponent _holder;

  PaperToggleButton({int rippleColor: PaperColor.GREY_DARK, this.activeColor : PaperColor.GREEN, this.label : "", this.labelOffset : 150}) : super() {
    ignoreCallSetSize = false;
    
    _holder = new SpriteComponent();
        
    _ripple = new PaperRipple(type: PaperRipple.CIRCLE, color: rippleColor, velocity : .2);
    _ripple.ignoreCallSetSize = true;
    addChild(_ripple);
    _ripple.setSize(RADIUS * 2, RADIUS * 2);

    _inactiveLine = new Shape();
    addChild(_inactiveLine);
    _drawLine(_inactiveLine, PaperColor.BLACK, 1);

    _activeLine = new Shape();
    addChild(_activeLine);
    _drawLine(_activeLine, activeColor, 1);
    _activeLine.visible = false;
    
    _bg = new Shape();
    _bg.graphics.circle(30, 30, 8);
    _bg.graphics.strokeColor(PaperColor.BLACK, 2);
    _bg.graphics.circle(30, 30, 30);
    _bg.graphics.fillColor(0x00555555);
    if (ContextTool.WEBGL) {
      _bg.applyCache(0, 0, 60, 60);
    }
    _holder.addChild(_bg);

    _icon = new Shape();
    _icon.graphics.circle(0, 0, 10);
    _icon.graphics.fillColor(activeColor);
    if (ContextTool.WEBGL) {
      _icon.applyCache(-10, -10, 20, 20);
    }
    _holder.addChild(_icon);
    _icon.visible = false;
    
    addChild(_holder);

    if(label != ""){
      _paperLabel = new PaperText(label, size : 16);
      addChild(_paperLabel);
    }
    
    enabled = true;
  }

  @override void redraw() {
    _inactiveLine.x = _activeLine.x = labelOffset + 38; 
    _inactiveLine.y = _activeLine.y = 30; 
    
    _holder.x = labelOffset;
    _ripple.x = labelOffset;
    _icon.x = 30; 
    _icon.y = 30;
    
    if(_paperLabel != null){
      _paperLabel.x = 20;
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
      _activeLine.visible = true;
      stage.juggler.tween(_icon, .1).animate
        ..scaleX.to(1)
        ..scaleY.to(1);
      stage.juggler.tween(_holder, .1).animate
        ..x.to(labelOffset + 48);
      stage.juggler.tween(_ripple, .1).animate
        ..x.to(labelOffset + 48);
      if(_paperLabel != null){
        _paperLabel.color = activeColor;
      }
    }
    else{
      stage.juggler.tween(_holder, .1).animate
        ..x.to(labelOffset);
      stage.juggler.tween(_ripple, .1).animate
        ..x.to(labelOffset);
      Tween tw = new Tween(_icon, .2);
      tw.animate
      ..scaleX.to(.1)
      ..scaleY.to(.1);
      tw.onComplete = () { 
        _icon.visible = false;
        _activeLine.visible = false;
      };
      stage.juggler.add(tw);
      if(_paperLabel != null){
        _paperLabel.color = PaperColor.BLACK;
      }
    }
    
  }
  
  void _drawLine(Shape line, int color, num strength) {
    line.graphics.clear();
    line.graphics.beginPath();
    line.graphics.moveTo(0, 0);
    line.graphics.lineTo(32, 0);
    line.graphics.strokeColor(color, strength);
    line.graphics.closePath();
    if (ContextTool.WEBGL) {
      line.applyCache(0, 0, 32, strength);
    }
  }
}
