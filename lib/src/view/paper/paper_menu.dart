part of stagexl_commons;


class PaperMenu extends ListSprite {

  bool shadow = false;

  PaperMenu(List data, {PaperListCell cell, this.shadow : true}) : super(data, cell != null ? cell : new PaperListCell(10), new DefaultScrollbar(), new DefaultScrollbar()) {

    snapToPages = false;
    doubleClickEnabled = false;
    doubleClickToZoom = false;
    mouseWheelEnabled = ContextTool.MOBILE ? false : true;
    touchable = ContextTool.MOBILE ? true : false;

    PaperShadow _paperShadow = new PaperShadow(type : PaperShadow.RECTANGLE, bgColor: PaperColor.WHITE, shadowEnabled : shadow);
    addChildAt(_paperShadow, 0);

    span(PaperDimensions.WIDTH_MENU, PaperDimensions.HEIGHT_MENU_CELL * data.length );
  }

}
