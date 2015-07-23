part of stagexl_commons;

class PaperToast extends BoxSprite {

  static const int BL = 1;
  static const int BR = 2;

  PaperText _title;
  PaperProgress _progress;
  int hideAfterSeconds;
  int position;
  Stage holder;

  PaperToast(String title, this.holder, {this.position: BL, 
      int bgColor: PaperColor.WHITE, int fontColor: PaperColor.BLACK, String fontName: PaperText.DEFAULT_FONT, int fontSize: 18,
      this.hideAfterSeconds: 3}) : super() {
    
    addChild(new PaperShadow(type: PaperShadow.RECTANGLE, bgColor: bgColor, respondToClick: false));

    _title = new PaperText(title, size: fontSize, color: fontColor, fontName: fontName);
    addChild(_title);

    _progress = new PaperProgress(0, 100, 300, bgColor: bgColor, barColor: fontColor);
    addChild(_progress);
    _progress.value = 0;

    holder.addChild(this);
    span(300, 50);

    ContextTool.STAGE.juggler.addTween(this, .3, Transition.easeOutBounce)..animate.y.to(ContextTool.STAGE.stageHeight - this.height - 20);

    if (hideAfterSeconds > 0) {

      hide();

      ContextTool.STAGE.juggler.addTranslation(0, 100, hideAfterSeconds, Transition.linear, (num val) => _progress.value = val);
    }
  }

  void hide() {
    ContextTool.STAGE.juggler.addTween(this, .3, Transition.easeOutBounce)
        ..animate.y.to(ContextTool.STAGE.stageHeight)
        ..delay = hideAfterSeconds
        ..onComplete = () => this.dispose();
  }

  @override void refresh() {
    super.refresh();

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
  }
}
