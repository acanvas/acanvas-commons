part of stagexl_commons;

class SvgDisplayObject extends DisplayObject {

  RenderTexture _renderTexture;
  RenderTextureQuad _renderTextureQuad;

  SvgDisplayObject(String svg) {

    if(ContextTool.FIREFOX){
      _firefox(svg);
    }
    else{
      _allOthers(svg);
    }

  }

  void _allOthers(String svg) {
    var imageElement = new html.ImageElement();
    imageElement.src = "data:image/svg+xml;charset=utf-8,$svg";
    imageElement.onLoad.listen((c) {
      _renderTexture = new RenderTexture.fromImage(imageElement, 1.0);
      _renderTextureQuad = _renderTexture.quad;
    });
  }

  void _firefox(String svg) {
    var blob = new html.Blob([svg], "image/svg+xml;charset=utf-8");
    var url = html.Url.createObjectUrlFromBlob(blob);
    var imageElement = new html.ImageElement();
    imageElement.src = url;
    imageElement.onLoad.listen((e) {
      html.Url.revokeObjectUrl(url);
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
