part of stagexl_commons;


class PaperDialog extends BoxSprite {

  num bgColor;
  bool enableRipple;
  Shape _bg;
  PaperText _title;
  Flow _vbox;
  Flow _hbox;

  PaperDialog(String title, {num fontColor : PaperColor.BLACK, this.bgColor: PaperColor.WHITE, String fontName : PaperText.DEFAULT_FONT}) : super() {
    
    addChild( new PaperShadow(type : PaperShadow.RECTANGLE, bgColor: bgColor, respondToClick: false) );

    _title = new PaperText(title, size: 22, color: fontColor, fontName: fontName);
    addChild(_title);
    
    _vbox = new Flow()
      ..spacing = 20
      ..snapToPixels = true
      ..inheritSpan = false;
    addChild(_vbox);

    _hbox = new Flow()
      ..spacing = 20
      ..snapToPixels = true;
    addChild(_hbox);
    
    
  }
  
  void addContent(InteractiveObject spr){
    _vbox.addChild(spr);
  }

  void addButton(Button btn){
    _hbox.addChild(btn);
  }


  @override void refresh() {
    super.refresh();
    
    _title.x = 20;
    _title.y = 20;
    _title.width = spanWidth - 40;
    
    _vbox.x = 20;
    _vbox.y = _title.y + _title.textHeight + 22;
    _vbox.span(spanWidth - 40, 0);

    _hbox.x = (spanWidth - _hbox.width - 20).round();
    _hbox.y = (spanHeight - _hbox.height - 30).round();
    

    //filters = [ new DropShadowFilter(5, 90,PaperColor.GREY_SHADOW, 10, 10) ];
  }

}
