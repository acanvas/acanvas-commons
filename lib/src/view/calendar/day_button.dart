part of acanvas_commons;

class DayButton extends Button {
  UITextField _labelTF;
  int _tag;
  Sprite _bgOver;

  DayButton(String label, int w, int h) : super() {
    mouseChildren = false;

    _bgOver = AcGraphics.rectangle(0, 0, w, h, color: 0xFFFFE93F);
    _bgOver.alpha = 0;
    addChild(_bgOver);

    Sprite bg = AcGraphics.rectangle(0, 0, w, h, color: 0xFF000000);
    addChild(bg);

    TextFormat fm = new TextFormat("Arial", 18, 0xFFFFFFFF);
    fm.align = TextFormatAlign.CENTER;

    _labelTF = new UITextField(label, fm);
    _labelTF.width = w;
    _labelTF.wordWrap = true;
    _labelTF.multiline = false;
    _labelTF.height = h;
    _labelTF.autoSize = TextFieldAutoSize.CENTER;
    addChild(_labelTF);

    _labelTF.y = (h * .5 - _labelTF.height * .5).floor();
  }

  @override
  void rollOverAction([InputEvent event = null]) {
    if (stage != null) {
      //ContextTool.STAGE.removeTweens(_bgOver);
      Ac.JUGGLER.addTween(_bgOver, 0.3)..animate.alpha.to(1);
      _labelTF.textColor = 0xFF000000;
    } else if (_bgOver != null) {
      _bgOver.alpha = 1;
    }
  }

  @override
  void rollOutAction([InputEvent event = null]) {
    if (stage != null) {
      Ac.JUGGLER.addTween(_bgOver, 0.3)..animate.alpha.to(0);
      _labelTF.textColor = 0xFFFFFFFF;
    } else if (_bgOver != null) {
      _bgOver.alpha = 0;
    }
  }

  String get label {
    return _labelTF.text;
  }

  void set label(String value) {
    _labelTF.text = value;
  }

  int get tag {
    return _tag;
  }

  void set tag(int tag) {
    _tag = tag;
  }
}
