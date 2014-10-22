part of stagexl_commons;

class SvgDisplayObject extends DisplayObject {

  RenderTexture _renderTexture;
  RenderTextureQuad _renderTextureQuad;

  SvgDisplayObject(String svg) {

    if(ContextTool.FIREFOX){
      //_firefox(html.window.btoa(svg));
      _allOthers("data:image/svg+xml;base64,${html.window.btoa(svg)}");
    }
    else{
      _allOthers("data:image/svg+xml;base64,${html.window.btoa(svg)}");
//      _allOthers("data:image/svg+xml;charset=utf-8,$svg");
    }

  }

  void _allOthers(String svg) {
    var imageElement = new html.ImageElement();
    imageElement.src = svg;
    imageElement.onLoad.listen((c) {
      _renderTexture = new RenderTexture.fromImage(imageElement, 1.0);
      _renderTextureQuad = _renderTexture.quad;
    });
  }

  void _firefox(String svg) {
    var blob = new html.Blob([svg], "image/svg+xml;base64");
    var url = html.Url.createObjectUrlFromBlob(blob);
    var imageElement = new html.ImageElement();
    imageElement.src = url;
    imageElement.onLoad.listen((e) {
      _renderTexture = new RenderTexture.fromImage(imageElement, 1.0);
      _renderTextureQuad = _renderTexture.quad;
      html.Url.revokeObjectUrl(url);
    });
  }

  render(RenderState renderState) {
    if (_renderTextureQuad != null) {
      renderState.renderQuad(_renderTextureQuad);
    }
  }
}
