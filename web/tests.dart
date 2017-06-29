import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:rockdot_commons/rockdot_commons.dart';

Stage stage;

void main() {

  var opts = new StageOptions();
  opts.maxPixelRatio = 3.0;
  opts.renderEngine = RenderEngine.WebGL;
  opts.backgroundColor = 0xFFf9f9f9;
  opts.stageScaleMode = StageScaleMode.NO_SCALE;
  opts.stageAlign = StageAlign.TOP_LEFT;
  opts.inputEventMode = InputEventMode.MouseAndTouch;

  stage = new Stage(html.querySelector('#stage') as html.CanvasElement, options: opts);
  Rd.STAGE = stage;

  new RenderLoop()..addStage(stage);

  start();
}

void start() {

  Button p = new Button();
  stage.addChild(p);

  Sprite c = new Sprite();
  c.graphics
    ..rect(0, 0, 200, 100)
    ..fillColor(Color.Red);
  c.mask = new Mask.circle(100, 50, 50);
  c.addTo(p);

  p.enable();

/*
  p.filters = [new ColorMatrixFilter.grayscale()];
*/

  //this is always true in SDK 1.24.1 on Dartium:
  print("html.TouchEvent.supported: ${html.TouchEvent.supported}");

}

void _onMouse(Event event) {
  print("MouseEvent: ${event.type}");
}
