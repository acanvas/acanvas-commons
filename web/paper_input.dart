import 'dart:html' as html;
import 'package:stagexl_commons/stagexl_commons.dart';
import 'package:stagexl/stagexl.dart';

Stage stage;
Sprite _container;


void main() {
  stage = new Stage(html.querySelector('#stage'), webGL: false, color: 0xFFf9f9f9);
  stage.scaleMode = StageScaleMode.NO_SCALE;
  stage.align = StageAlign.TOP_LEFT;
  ContextTool.WEBGL = stage.renderEngine == RenderEngine.WebGL ? true : false;
  new RenderLoop()..addStage(stage);

  FontTool.addFont("Roboto");
  FontTool.loadFonts(start);
}
void start() {
  
  /* Vertical Container */
  VBox vbox = new VBox(40);
  vbox.x = 10;
  vbox.y = 10;
  
  /* 
   * Standard Input Field with Label
   */
  PaperInput input1 = new PaperInput("Type something");
  vbox.addChild(input1); 

  /* 
   * Standard Input Field with Floating Label
   */
  PaperInput input2 = new PaperInput("Type something (floating)", floating : true);
  vbox.addChild(input2); 

  /* 
   * Mandatory Input Field
   */
  PaperInput input3 = new PaperInput("Type something", required : "This input requires a value.");
  vbox.addChild(input3); 

  /* 
   * Mandatory Input Field with Floating Label
   */
  PaperInput input4 = new PaperInput("Type something (floating)", required : "This input requires a value.", floating : true);
  vbox.addChild(input4); 
  
  
  stage.addChild(vbox);
  vbox.setSize(320, 400);
  

}
