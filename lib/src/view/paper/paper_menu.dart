part of stagexl_commons;

class PaperMenu extends ListSprite {
  bool shadow = false;

  PaperMenu(List data, {SelectableButton cell, this.shadow: true, int backgroundColor: PaperColor.WHITE})
      : super(data, cell != null ? cell : new PaperListCell(), new DefaultScrollbar(), new DefaultScrollbar()) {
    snapToPages = false;
    doubleClickEnabled = false;
    doubleClickToZoom = false;
    mouseWheelEnabled = ContextTool.MOBILE ? false : true;
    touchable = ContextTool.MOBILE ? true : false;

    PaperShadow _paperShadow =
        new PaperShadow(type: PaperShadow.RECTANGLE, bgColor: backgroundColor, shadowEnabled: shadow);
    addChildAt(_paperShadow, 0);

    //TODO this leads to render everything?
    span(PaperDimensions.WIDTH_MENU, PaperDimensions.HEIGHT_MENU_CELL * data.length);
  }
}
