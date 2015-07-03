part of stagexl_commons;

class ComponentBitmapData extends SpriteComponent {
  BitmapData _bitmapDataSource;
  ComponentBitmapData(BitmapData bitmapData) : super() {
    _bitmapDataSource = bitmapData;
    addChild( new Bitmap(_bitmapDataSource) );
  }
  
  void scaleToWidth(num w) {
    num scale;
    scale = w / _bitmapDataSource.width;
    scaleX = scaleY = scale;
  }

  void scaleToHeight(num h) {
    num scale;
    scale = h / _bitmapDataSource.height;
    scaleX = scaleY = scale;
  }

  @override
  void redraw() {
    num scale;
    if (_bitmapDataSource.width > _bitmapDataSource.height) {
      scale = _heightAsSet / _bitmapDataSource.height;
      if(_bitmapDataSource.width * scale < _widthAsSet){
        scale = _widthAsSet / _bitmapDataSource.width;
      }
    } else {
      scale = _widthAsSet / _bitmapDataSource.width;
      if(_bitmapDataSource.height * scale < _heightAsSet){
        scale = _heightAsSet / _bitmapDataSource.height;
      }
    }
    
    scaleX = scaleY = scale;
    x = (widthAsSet/2 - width/2).round();
    y = (heightAsSet/2 - height/2).round();

    super.redraw();
  }

  @override
  void destroy() {
    super.destroy();
    graphics.clear();
  }
}
