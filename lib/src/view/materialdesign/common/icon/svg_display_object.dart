part of rockdot_commons;

class SvgDisplayObject extends DisplayObject {
  RenderTexture _renderTexture;
  RenderTextureQuad _renderTextureQuad;

  SvgDisplayObject(String svg, {int width = 24, int height = 24}) {
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


  /*

  "data:image/svg+xml;charset=utf-8,$svg"

  void _firefox(String svgUrl) {
    var blob = new html.Blob([svgUrl], "image/svg+xml;base64");
    var url = html.Url.createObjectUrlFromBlob(blob);
    var imageElement = new html.ImageElement();
    imageElement.src = url;
    imageElement.onLoad.listen((e) {
      _renderTexture = new RenderTexture.fromImageElement(imageElement);
      _renderTextureQuad = _renderTexture.quad;
      html.Url.revokeObjectUrl(url);
    });
  }
  */

  render(RenderState renderState) {
    if (_renderTextureQuad != null) {
      renderState.renderTextureQuad(_renderTextureQuad);
    }
  }
}
