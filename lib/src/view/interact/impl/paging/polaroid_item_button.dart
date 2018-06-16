part of acanvas_commons;

/**
	 * Written in 2014 by Nils Döhring, Block Forest
	 */
class PolaroidItemButton extends SelectableButton {
  int xPos;
  int yPos;
  num rot;

  Sprite _bg;
  ImageSprite _image;

  PolaroidItemButton(String href, int w, int h) : super() {
    _bg = new Sprite();
    addChild(_bg);

    _image = new ImageSprite(alignH: AlignH.LEFT, alignV: AlignV.TOP)
      ..addEventListener(Event.COMPLETE, _onImageLoadComplete);
    addChild(_image);

    span(w, h, refresh: false);

    if (_image != "") {
      _image.href = href;
    } else {
      refresh();
    }
  }

  void _onImageLoadComplete(Event event) {
    _image.removeEventListener(Event.COMPLETE, _onImageLoadComplete);
    refresh();
  }

  @override
  void refresh() {
    _image.mask = new Mask.rectangle(3, 3, spanWidth - 6, spanHeight - 20)..relativeToParent = true;
    _image.span(spanWidth - 6, spanHeight - 20, refresh: true);
    _image.x = ((spanWidth / 2 - _image.width / 2));

    AcGraphics.rectangle(0, 0, spanWidth, spanHeight, color: MdColor.WHITE, sprite: _bg);

    pivotX = spanWidth / 2;
    pivotY = spanHeight / 2;

    super.refresh();
  }
}
