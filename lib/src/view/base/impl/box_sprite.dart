part of stagexl_commons;

class BoxSprite extends Sprite3D with MBox {

  //TODO logger
  Logger log;

  BoxSprite() {
    this.log = new Logger("$this (BoxSprite.${ new Random()..nextInt(1000000)})");
  }



  @override
  void span(spanWidth, spanHeight, {bool refresh: true}){
    if (this.spanWidth != spanWidth || this.spanHeight != spanHeight) {
      if (spanWidth > 0) this.spanWidth = spanWidth;
      if (spanHeight > 0) this.spanHeight = spanHeight;

      children.where((c) => c is MBox && c.inheritSpan).forEach( (child){
        child.span(spanWidth, spanHeight, refresh: refresh);
      });
      children.where((c) => c is TextField).forEach( (child){
        child.width = spanWidth;
      });

      if (refresh) {
        this.refresh();
      }
    }
  }

  @override
  void refresh() {
    //nothing to do here, but in sub classes
  }

  @override
  void dispose() {
    children.forEach( (child){
      disposeChild(child);
    });
    if (parent != null) {
      parent.removeChild(this);
    }
  }

  void disposeChild(DisplayObject dobj) {

    if (dobj is MBox && (dobj as MBox).inheritDispose && dobj != this) {
      (dobj as MBox).dispose();
      return;
    }
    if (dobj.parent != null) {
      dobj.parent.removeChild(dobj);
    }
    if (dobj is Bitmap) {
      //dobj.bitmapData.clear();
    }
    if (dobj is BitmapData) {
      //(dobj as BitmapData).clear();
    }
    if (dobj is Shape) {
      dobj.graphics.clear();
    }
    if (dobj is Sprite) {
      dobj.graphics.clear();
    }
    dobj = null;
  }

  @override
  void addChildAt(DisplayObject child, int index) {
    super.addChildAt(child, index);
    if (child is MBox && (child as MBox).inheritSpan) {
      (child as MBox).span(spanWidth, spanHeight);
    }
  }

  @override
  void removeChild(DisplayObject child) {
    super.removeChild(child);
    if (child is MBox && (child as MBox).inheritDispose) {
      (child as MBox).dispose();
    }
  }
}
