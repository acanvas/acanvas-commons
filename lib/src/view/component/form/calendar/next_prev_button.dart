part of stagexl_commons;

class NextPrevButton extends Button {

  UITextField _labelTF;
  NextPrevButton(String label, int w, int h) : super() {
    mouseChildren = false;

    Shape bg = new Shape();
    bg.graphics.rect(0, 0, w, h);
    bg.graphics.fillColor(0x66000000);
    if (ContextTool.WEBGL) {
      bg.applyCache(0, 0, w, h);
    }
    addChild(bg);

    TextFormat fm = new TextFormat("Arial", 18, 0xFFFFFF);
    fm.align = TextFormatAlign.CENTER;

    _labelTF = new UITextField(label, fm);
    _labelTF.width = w;
    _labelTF.wordWrap = true;
    _labelTF.multiline = false;
    _labelTF.height = h;
    _labelTF.autoSize = TextFieldAutoSize.CENTER;
    addChild(_labelTF);

    _labelTF.y = ( h*.5 - _labelTF.textHeight*.5 ).floor();
  }
}
