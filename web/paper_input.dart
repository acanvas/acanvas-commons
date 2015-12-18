import 'dart:html' as html;
import 'package:stagexl_commons/stagexl_commons.dart';
import 'package:stagexl/stagexl.dart';

Stage stage;
Sprite _container;


void main() {
  var opts = new StageOptions();
  opts.renderEngine = RenderEngine.WebGL;
  opts.backgroundColor = 0xFFf9f9f9;
  opts.stageScaleMode = StageScaleMode.NO_SCALE;
  opts.stageAlign = StageAlign.TOP_LEFT;

  stage = new Stage(html.querySelector('#stage'), options: opts);
  Rd.STAGE = stage;
  new RenderLoop()..addStage(stage);

  RdFontUtil.addFont("Roboto");
  RdFontUtil.loadFonts(start);
}
void start() {


  Wrap vbox = new Wrap(spacing: 40, reflow: false)
    ..x = 10
    ..y = 10;

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
