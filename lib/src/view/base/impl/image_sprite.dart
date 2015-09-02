part of stagexl_commons;

class ImageSprite extends BoxSprite {
  Bitmap _image;
  BitmapData _bitmapData;

  void set bitmapData(BitmapData bitmapData) {
    _bitmapData = bitmapData;
    _image = new Bitmap(_bitmapData);
    addChild(_image);
    refresh();
    dispatchEvent(new Event(Event.COMPLETE));
  }

  void setBitmapData(BitmapData bitmapData) {
    this.bitmapData = bitmapData;
  }

  String _href;

  void set href(String href) {
    _href = href;
    var opts = new BitmapDataLoadOptions();
    opts.corsEnabled = true;
    BitmapData.load(_href, opts).then(setBitmapData).catchError(onIoError);
  }

  ImageSprite() : super() {
  }

  void scaleToWidth(num w) {
    num scale;
    scale = w / _bitmapData.width;
    scaleX = scaleY = scale;
  }

  void scaleToHeight(num h) {
    num scale;
    scale = h / _bitmapData.height;
    scaleX = scaleY = scale;
  }

  @override
  void refresh() {

    if (spanWidth == 0 || spanHeight == 0) {
      return;
    }

    num scale = 0;
    if (_bitmapData != null) {
      if (_bitmapData.width > _bitmapData.height) {
        scale = spanHeight / _bitmapData.height;
        if (_bitmapData.width * scale < spanWidth) {
          scale = spanWidth / _bitmapData.width;
        }
      } else {
        scale = spanWidth / _bitmapData.width;
        if (_bitmapData.height * scale < spanHeight) {
          scale = spanHeight / _bitmapData.height;
        }
      }

      _image.x = (spanWidth  - _bitmapData.width)  / 2 ..floor();
      _image.y = (spanHeight - _bitmapData.height) / 2 ..floor();
    }

    scaleX = scaleY = scale;

    mask = new Mask.rectangle(0, 0, spanWidth, spanHeight)
      ..relativeToParent = true;

    super.refresh();
  }

  void onIoError(Error e) {
    this.logger.debug("IO error occured while loading image");
  }

}
