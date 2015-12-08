part of stagexl_commons;

class MdToast extends BoxSprite {
  static const int BL = 1;
  static const int BR = 2;

  MdText _title;
  MdProgress _progress;
  int hideAfterSeconds;
  int position;
  Stage holder;

  MdToast(String title, this.holder,
      {this.position: BL,
      int bgColor: MdColor.WHITE,
      int fontColor: MdColor.BLACK,
      String fontName: MdText.DEFAULT_FONT,
      int fontSize: 18,
      this.hideAfterSeconds: 3})
      : super() {
    addChild(new MdShadow(type: MdShadow.RECTANGLE, bgColor: bgColor, respondToClick: false));

    _title = new MdText(title, size: fontSize, color: fontColor, fontName: fontName);
    addChild(_title);

    _progress = new MdProgress(0, 100, 300, bgColor: bgColor, barColor: fontColor);
    addChild(_progress);
    _progress.value = 0;

    holder.addChild(this);
    span(300, 50);

    Rd.JUGGLER.addTween(this, .3, Transition.easeOutBounce)
      ..animate.y.to(Rd.STAGE.stageHeight - this.height - 20);

    if (hideAfterSeconds > 0) {
      hide();

      Rd.JUGGLER
          .addTranslation(0, 100, hideAfterSeconds, Transition.linear, (num val) => _progress.value = val);
    }
  }

  void hide() {
    Rd.JUGGLER.addTween(this, .3, Transition.easeOutBounce)
      ..animate.y.to(Rd.STAGE.stageHeight)
      ..delay = hideAfterSeconds
      ..onComplete = () => this.dispose();
  }

  @override void refresh() {
    _title.x = 20;
    _title.y = (spanHeight / 2 - _title.textHeight / 2).round();
    _title.width = spanWidth - 40;

    _progress.y = spanHeight - _progress.height;

    switch (position) {
      case BL:
        x = 20;
        y = holder.stageHeight;
        break;
      case BR:
        x = holder.stageWidth - spanWidth - 20;
        y = holder.stageHeight;
        break;
    }
    super.refresh();
  }
}
