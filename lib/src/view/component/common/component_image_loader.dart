part of stagexl_commons;

class ComponentImageLoader extends SpriteComponent {
  Sprite _holder;
  Bitmap _img;
  String _href;

  ComponentImageLoader(String href, int w, int h) : super() {
    _widthAsSet = w;
    _heightAsSet = h;
    _href = href;

    if (_href == null) {
      onComplete();
      return;
    }
    
    _holder = new Sprite();
    addChild(_holder);

    var opts = new BitmapDataLoadOptions();
    opts.corsEnabled = true;
    BitmapData.load(_href, opts).then(onComplete).catchError(onIoError);

  }

  void onComplete([BitmapData data = null]) {
    if (data != null) {
      _img = new Bitmap(data);
    } else {
      Shape dobj = new Shape();
      dobj.graphics.rect(0, 0, widthAsSet, heightAsSet);
      dobj.graphics.fillColor(0xffff2222);
      BitmapData bmd = new BitmapData(widthAsSet, heightAsSet);
      bmd.draw(dobj);
      _img = new Bitmap(bmd);
    }

    // calculate and apply scale
    double scale = 0.0;
    if (_img.width > _img.height) {
      scale = _heightAsSet / _img.height;
    } else {
      scale = _widthAsSet / _img.width;
    }
    _img.scaleX = scale;
    _img.scaleY = scale;
    _img.x = (_widthAsSet - _img.width) / 2;
    _img.y = (_heightAsSet - _img.height) / 2;


    Mask mask = new Mask.rectangle(0, 0, _widthAsSet, _heightAsSet);
    _holder.mask = mask;
    _holder.addChild(_img);

    dispatchEvent(new Event(Event.COMPLETE, false));
  }


  @override
  int get height {
    return _heightAsSet;
  }
  void onIoError(Error e) {
    print("IO error occured while loading image");
    onComplete();
  }
  /*
		void onSecurityError(SecurityErrorEvent event)
		
		{
			print("Security error occured while loading image"));
			onComplete();
		}
		* */
}
