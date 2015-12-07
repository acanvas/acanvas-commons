part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class MdListCell extends SelectableButton {
  MdText title;
  int fontColor;

  MdListCell([this.fontColor = MdColor.GREY_DARK]) : super() {
    MdRipple ripple = new MdRipple(color: fontColor);
    addChild(ripple);

    title = new MdText("empty", size: 14, color: fontColor);
    addChild(title);
  }

  @override
  SelectableButton clone() => new MdListCell(fontColor);

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
    super.span(w, MdDimensions.HEIGHT_MENU_CELL, refresh: refresh);
  }

  @override void refresh() {
    title.width = spanWidth - 10;
    title.x = 10;
    title.y = (spanHeight / 2 - title.textHeight / 2).round();

    graphics.clear();
    graphics.rect(0, 0, spanWidth, spanHeight);
    graphics.fillColor(MdColor.WHITE);

    super.refresh();
  }

  @override void selectAction() {
    downAction();
  }

  @override void deselectAction() {
    upAction();
  }
}
