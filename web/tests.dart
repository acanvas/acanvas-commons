import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:rockdot_commons/rockdot_commons.dart';

Stage stage;

void main() {
  var opts = new StageOptions();
  opts.renderEngine = RenderEngine.Canvas2D;
  opts.backgroundColor = 0xFFf9f9f9;
  opts.stageScaleMode = StageScaleMode.NO_SCALE;
  opts.stageAlign = StageAlign.TOP_LEFT;

  stage = new Stage(html.querySelector('#stage') as html.CanvasElement, options: opts);

  new RenderLoop()..addStage(stage);

  BookSampleAssets.load(start);
}

void start() {
  List<int> colors = [0x33FF0000, 0x3300FF00, 0x330000FF];

  Sprite s = new Sprite();
  stage.addChild(s);

  var bmd = new BitmapData(700, 30, colors[0]);

  for (int i = 0; i < 18; i++) {
    var m = new Matrix.fromIdentity();
    m.createBox(1, 1 / (i / 5));
    var pat = new GraphicsPattern.noRepeat(bmd.renderTextureQuad, m);

    s.graphics.beginPath();
    s.graphics.moveTo(i * 20, 0);
    s.graphics.lineTo(i * 20 + 20, 0);
    s.graphics.lineTo(i * 20 + 20, 20);
    s.graphics.lineTo(i * 20, 0);
    s.graphics.closePath();

    s.graphics.fillPattern(pat);

    s.graphics.beginPath();
    s.graphics.moveTo(i * 20, 0);
    s.graphics.lineTo(i * 20 + 20, 20);
    s.graphics.lineTo(i * 20, 20);
    s.graphics.lineTo(i * 20, 0);
    s.graphics.closePath();

    s.graphics.fillPattern(pat);
  }
}
