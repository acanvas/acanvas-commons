part of rockdot_commons;

class ImageSprite extends BoxSprite {
  Bitmap _image;
  BitmapData _bitmapData;

  AlignH alignH;
  AlignV alignV;

  void set bitmapData(BitmapData bitmapData) {
    _bitmapData = bitmapData;
    if (_image != null) {
      removeChild(_image);
      _image = null;
    }
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

  ImageSprite({this.alignH: AlignH.CENTER, this.alignV: AlignV.TOP}) : super() {
    autoSpan = false;
  }

  void scaleToWidth(num w) {
    num scale;
    scale = w / _bitmapData.width;
    _image.scaleX = _image.scaleY = scale;
  }

  void scaleToHeight(num h) {
    num scale;
    scale = h / _bitmapData.height;
    _image.scaleX = _image.scaleY = scale;
  }

  @override
  void refresh() {
    if (spanWidth == 0 || spanHeight == 0 || _image == null) {
      return;
    }

    num scale = _image.scaleX = _image.scaleY = 1;

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

      _image.scaleX = _image.scaleY = scale;

      switch (alignH) {
        case AlignH.LEFT:
          _image.x = 0;
          break;
        case AlignH.CENTER:
          _image.x = (spanWidth - _image.width) / 2..floor();
          break;
        case AlignH.RIGHT:
          _image.x = (spanWidth - _image.width).floor();
          break;
      }

      switch (alignV) {
        case AlignV.TOP:
          _image.y = 0;
          break;
        case AlignV.CENTER:
          _image.y = (spanHeight - _image.height) / 2..floor();
          break;
        case AlignV.BOTTOM:
          _image.y = (spanHeight - _image.height).floor();
          break;
      }
    }

    mask = new Mask.rectangle(0, 0, spanWidth, spanHeight)..relativeToParent = true;

    super.refresh();
  }

  void onIoError(Error e) {
    this.logger.debug("IO error occured while loading image");
  }
}
