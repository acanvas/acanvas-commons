part of stagexl_commons;


class PaperDialog extends SpriteComponent {

  num bgColor;
  bool enableRipple;
  Shape _bg;
  PaperText _title;
  VBox _vbox;
  HBox _hbox;

  PaperDialog(String title, {num fontColor : PaperColor.BLACK, this.bgColor: PaperColor.WHITE, String fontName : PaperText.DEFAULT_FONT}) : super() {
    
    addChild( new PaperShadow(type : PaperShadow.RECTANGLE, bgColor: bgColor, respondToClick: false) );

    _title = new PaperText(title, size: 22, color: fontColor, fontName: fontName);
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
    

    //filters = [ new DropShadowFilter(5, 90,PaperColor.GREY_SHADOW, 10, 10) ];
  }

}