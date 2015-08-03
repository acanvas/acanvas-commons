part of stagexl_commons;


/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class PaperListCell extends SelectableButton {
  PaperText title;
  int fontColor;

  PaperListCell([this.fontColor = PaperColor.GREY_DARK]) :super() {

    PaperRipple ripple = new PaperRipple(color: fontColor);
    addChild(ripple);

    title = new PaperText("empty", size: 14, color: fontColor);
    addChild(title);
  }


  @override
  SelectableButton clone() => new PaperListCell(fontColor);


  @override
  void set data(Object newdata) {
    if (newdata != data) {
      super.data = newdata;
      if (data != null && data is Map) {
        title.text = (data as Map)["label"];
        refresh();
      }
    }
  }

  @override
  void span(num w, num h, {bool refresh: true}) {
    super.span(w, PaperDimensions.HEIGHT_MENU_CELL, refresh: refresh);
  }

  @override void refresh() {
    title.width = spanWidth - 10;
    title.x = 10;
    title.y = (spanHeight / 2 - title.textHeight / 2).round();

    graphics.clear();
    graphics.rect(0, 0, spanWidth, spanHeight);
    graphics.fillColor(PaperColor.WHITE);

    super.refresh();
  }

  @override void selectAction(){
    downAction();
  }

  @override void deselectAction(){
    upAction();
  }

}

