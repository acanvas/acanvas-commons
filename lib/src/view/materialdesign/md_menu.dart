part of rockdot_commons;

class MdMenu extends ListSprite {
  bool shadow = false;

  MdMenu(List data, {SelectableButton cell, this.shadow: true, int backgroundColor: MdColor.WHITE})
      : super(data, cell != null ? cell : new MdListCell()..selfSelect = false, new DefaultScrollbar(), new DefaultScrollbar()) {
    snapToPages = false;
    doubleClickEnabled = false;
    doubleClickToZoom = false;
    mouseWheelEnabled = Rd.MOBILE ? false : true;
    touchable = Rd.MOBILE ? true : false;

    MdShadow _paperShadow =
        new MdShadow(type: MdShadow.RECTANGLE, bgColor: backgroundColor, shadowEnabled: shadow);
    addChildAt(_paperShadow, 0);

    //TODO this leads to render everything?
    if(data.length > 0){
      span(MdDimensions.WIDTH_MENU, MdDimensions.HEIGHT_MENU_CELL * data.length);
    }
  }
}
