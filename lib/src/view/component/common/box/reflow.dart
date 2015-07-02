part of stagexl_commons;

/**
 * @author Nils Doehring (nilsdoehring@gmail.com)
 */
class Reflow extends ComponentScrollable {

  int padding;
  bool pixelSnapping;
  VBox _vbox;
  List _childList = [];
  Sprite _background;

  Reflow({this.padding : 10, this.pixelSnapping : true, bool queryActualChildWidth: true, bool queryActualChildHeight: true}) {
    ignoreCallSetSize = false;

    _vbox = new VBox(padding, pixelSnapping);
    superConstructor(Orientation.VERTICAL, _vbox, new DefaultScrollbar(), queryActualChildWidth: queryActualChildWidth, queryActualChildHeight: queryActualChildHeight);

    snapToPage = false;
    doubleClickEnabled = false;
    keyboardEnabled = false;
    doubleClickToZoom = false;
    bounce = ContextTool.MOBILE ? true : false;
    mouseWheelEnabled = ContextTool.MOBILE ? false : true;
    touchEnabled = ContextTool.MOBILE ? true : false;
    hideScrollbarsOnIdle = false;
  }

  @override
  void redraw() {

    _view.removeChildren();

    HBox hbox = new HBox(padding, pixelSnapping);
    _view.addChild(hbox);

    _childList.forEach((DisplayObject child){
      if(widthAsSet != 0 && hbox.width + padding + child.width > widthAsSet){
        hbox = new HBox(padding, pixelSnapping);
        _view.addChild(  hbox );
      }
      hbox.addChild(child);
    });

    GraphicsUtil.rectangle(0, 0, widthAsSet, heightAsSet, color: 0x00000000, sprite: this);

    super.redraw();
  }

  @override
  void addChild(DisplayObject child) {
    _childList.add(child);
    redraw();
  }
}
