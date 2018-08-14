part of acanvas_commons;

class MdDialog extends BoxSprite {
  int bgColor;
  bool enableRipple;
  Shape _bg;
  MdText _title;
  Flow _vbox;
  Flow _hbox;

  MdDialog(String title,
      {int fontColor: MdColor.BLACK,
      this.bgColor: MdColor.WHITE,
      String fontName: MdText.DEFAULT_FONT})
      : super() {
    addChild(new MdShadow(
        type: MdShadow.RECTANGLE, bgColor: bgColor, respondToClick: false));

    _title = new MdText(title, size: 22, color: fontColor, fontName: fontName);
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

  void addContent(InteractiveObject spr) {
    _vbox.addChild(spr);
  }

  void addButton(Button btn) {
    _hbox.addChild(btn);
  }

  @override
  void refresh() {
    super.refresh();

    _title.x = 20;
    _title.y = 20;
    _title.width = spanWidth - 40;

    _vbox.x = 20;
    _vbox.y = _title.y + _title.textHeight + 22;
    _vbox.span(spanWidth - 40, 0); //also sets width of TextField children

    _hbox.refresh();
    _hbox.x = (spanWidth - _hbox.width - 20).round();
    _hbox.y = (spanHeight - _hbox.height - 30).round();

    //filters = [ new DropShadowFilter(5, 90,MdColor.GREY_SHADOW, 10, 10) ];
  }
}
