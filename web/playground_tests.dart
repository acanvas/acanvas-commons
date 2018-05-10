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
  Sprite p = new Sprite();
  p.graphics.rect(0, 0, 200, 50);
  p.graphics.fillColor(Color.Red);
  p.addEventListener<MouseEvent>(MouseEvent.MOUSE_DOWN, _onSubmit);
  stage.addChild(p);
}

void _onSubmit(InputEvent e) {
  //MouseEvent me = e as MouseEvent;
  print("test: ${e.localX}");
}
