part of rockdot_commons;

class SvgDisplayObject extends DisplayObject {
  RenderTexture _renderTexture;
  RenderTextureQuad _renderTextureQuad;

  SvgDisplayObject(String svg, {int width = 24, int height = 24}) {
    _working(svg, width, height);

  }


  void _working(String svg, int width, int height) {
    width *= StageXL.environment.devicePixelRatio;
    height *= StageXL.environment.devicePixelRatio;

    var blob = new html.Blob([svg], "image/svg+xml;charset=utf-8");
    var url = html.Url.createObjectUrlFromBlob(blob);
    var imageElement = new html.ImageElement();
    imageElement.src = url;
    imageElement.width = width;
    imageElement.height = height;
    imageElement.onLoad.listen((e) {
      html.Url.revokeObjectUrl(url);
      _renderTexture = new RenderTexture.fromImageElement(imageElement);
      _renderTexture
          .canvas; // this copies the image to a canvas; workaround for https://github.com/bp74/StageXL/issues/198
      _renderTextureQuad = new RenderTextureQuad(_renderTexture,
          new Rectangle<int>(0, 0, width, height),
          new Rectangle<int>(0, 0, width, height), 0, StageXL.environment.devicePixelRatio);
    });
  }


    void _workaround(String svg, int width, int height) {
    String svgUrl = "data:image/svg+xml;base64,${html.window.btoa(svg)}";

    var imageElement = new html.ImageElement();
    imageElement.src = svgUrl;
    imageElement.width = width;
    imageElement.height = height;
    imageElement.onLoad.listen((c) {
      _renderTexture = new RenderTexture.fromImageElement(imageElement);
      _renderTexture
          .canvas; // this copies the image to a canvas; workaround for https://github.com/bp74/StageXL/issues/198
      _renderTextureQuad = _renderTexture.quad;
      html.Url.revokeObjectUrl(svgUrl);
    });
  }

  render(RenderState renderState) {
    if (_renderTextureQuad != null) {
      renderState.renderTextureQuad(_renderTextureQuad);
    }
  }

}
