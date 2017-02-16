import 'dart:async';
import 'dart:html' as html;
import 'package:rockdot_commons/rockdot_commons.dart';
import 'package:stagexl/stagexl.dart';

Stage stage;
Sprite _container;


Future main() async{
  var opts = new StageOptions();
  opts.renderEngine = RenderEngine.WebGL;
  opts.backgroundColor = 0xFFf9f9f9;
  opts.stageScaleMode = StageScaleMode.NO_SCALE;
  opts.stageAlign = StageAlign.TOP_LEFT;

  stage = new Stage(html.querySelector('#stage') as html.CanvasElement, options: opts);
  Rd.STAGE = stage;
  new RenderLoop()..addStage(stage);

  RdFontUtil.addFont("Roboto");
  await RdFontUtil.loadFonts();
  start();
}
void start() {


  Wrap vbox = new Wrap(spacing: 40, reflow: false)
    ..x = 10
    ..y = 10
  ..autoSpan = false;

  /*
   * Standard Input Field with Label
   */
  MdInput input1 = new MdInput("Type something", keyboard: true);
  vbox.addChild(input1);
  /*
   * Standard Input Field with Floating Label
   */
  MdInput input2 = new MdInput("Type something (floating)", floating : true);
  vbox.addChild(input2);

  /*
   * Mandatory Input Field
   */
  MdInput input3 = new MdInput("Type something", required : "This input requires a value.");
  vbox.addChild(input3);

  /*
   * Mandatory Input Field with Floating Label
   */
  MdInput input4 = new MdInput("Type something (floating)", required : "This input requires a value.", floating : true);
  vbox.addChild(input4);

  stage.addChild(vbox);
  vbox.span(stage.stageWidth - 20, stage.stageHeight - 20, refresh: true);
}
