part of dart_commons;


class PaperDialog extends SpriteComponent {

  num bgColor;
  bool enableRipple;
  Shape _bg;
  PaperText _title;
  VBox _vbox;
  HBox _hbox;

  PaperDialog(String title, {num fontColor : PaperColor.BLACK, this.bgColor: PaperColor.WHITE}) : super() {
    _bg = new Shape();
    addChild(_bg);
    
    _title = new PaperText(title, 22, fontColor);
    addChild(_title);
    
    _vbox = new VBox(20, true);
    _vbox.ignoreCallSetSize = true;
    addChild(_vbox);

    _hbox = new HBox(0, true);
    addChild(_hbox);
    
  }
  
  void addContent(InteractiveObject spr){
    _vbox.addChild(spr);
  }

  void addButton(Button btn){
    _hbox.addChild(btn);
  }


  @override void redraw() {
    super.redraw();
    
    _title.x = 20;
    _title.y = 20;
    _title.width = widthAsSet - 40;
    
    _vbox.x = 20;
    _vbox.y = _title.y + _title.textHeight + 22;
    _vbox.setSize(widthAsSet - 40, 0);

    _hbox.x = widthAsSet - _hbox.width - 20;
    _hbox.y = heightAsSet - _hbox.height - 30;
    
    _bg.graphics.clear();
    _bg.graphics.rect(0, 0, widthAsSet, heightAsSet);
    _bg.graphics.fillColor( bgColor );
    if(ContextTool.WEBGL){
      _bg.applyCache(0, 0, widthAsSet, heightAsSet);
    }

    filters = [ new DropShadowFilter(5, 90,PaperColor.GREY_SHADOW, 10, 10) ];
  }

}
