part of dart_commons;

class SvgDisplayObject extends DisplayObject {

  RenderTexture _renderTexture;
  RenderTextureQuad _renderTextureQuad;

  SvgDisplayObject(String svg) {

    var blob = new html.Blob([svg], "image/svg+xml;charset=utf-8");
    var url = html.Url.createObjectUrlFromBlob(blob);

    var imageElement = new html.ImageElement();
    imageElement.src = url;
    imageElement.onLoad.listen((c) {
      html.Url.revokeObjectUrl(url);
      //rerender workaround: http://stackoverflow.com/questions/25905041/ios8-uiwebview-svg-embaded-html-not-show
      imageElement.style.display = "none";
      var temp = imageElement.offsetHeight;
      imageElement.style.display = "block";
      _renderTexture = new RenderTexture.fromImage(imageElement, 1.0);
      _renderTextureQuad = _renderTexture.quad;
    });
  }

  render(RenderState renderState) {
    if (_renderTextureQuad != null) {
      renderState.renderQuad(_renderTextureQuad);
    }
  }
}