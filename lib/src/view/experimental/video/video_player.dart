part of acanvas_commons;

class VideoPlayer extends BoxSprite {
  Pyro _video;
  VideoControls _videoControls;
  Type _videoControlsType;

  VideoPlayer(int w, int h, Type videoControlsType) : super() {
    _width = w;
    _height = h;
    _videoControlsType = videoControlsType;

    _video = new Pyro(_width, _height);
    addChild(_video);

    if (_videoControlsType) {
      _videoControls = new _videoControlsType(_video);
      addChild(_videoControls);
    }
  }

  Pyro get video {
    return _video;
  }

  VideoControls get videoControls {
    return VideoControls(_videoControls);
  }

  @override
  void render() {
    _video.width = _width;
    _video.height = _height;
  }
}
