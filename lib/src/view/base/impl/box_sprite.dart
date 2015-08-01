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
    //adjust inherited span size to actual size
    if(autoSpan){
      span(width, height, refresh: false);
    }
    if(this is MFlow){
      print("${this}: ${spanWidth}x${spanHeight}  ${width}x${height}");
      children.forEach((c){
        print("--${c}: ${c.width}x${c.height} x:${c.x} y:${c.y}");
      });
    }
  }

  @override
  void dispose() {

    //children.forEach doesn't work here, as dispose influences children<List>
    for(int i=0;i<numChildren;i++){
      disposeChild(getChildAt(i));
    }

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
    if (spanWidth > 0 && spanHeight > 0 && child is MBox && (child as MBox).inheritSpan) {
      (child as MBox).span(spanWidth, spanHeight);
    }

    //todo think of a better way to ensure refresh() globally
    if(child is MBox && (child as MBox).autoRefresh){
      (child as MBox).refresh();
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
