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
   * Radio Button Group
   */
  RadioGroupV radioGroupV = new RadioGroupV(10);
  radioGroupV.addChild(new PaperRadioButton(label : "Hello"));
  radioGroupV.addChild(new PaperRadioButton(label : "Red pill?", activeColor : PaperColor.RED));
  radioGroupV.addChild(new PaperRadioButton(label : "Blue pill?", activeColor : PaperColor.BLUE));
  radioGroupV.addEventListener(RadioGroupEvent.BUTTON_SELECTED, _onSelected);
  vbox.addChild(radioGroupV);
  
  PaperCheckbox check1 = new PaperCheckbox(label : "Checkbox with blue label", activeColor: PaperColor.BLUE);
  vbox.addChild(check1);

  PaperCheckbox check2 = new PaperCheckbox(label : "Checkbox with green label and ripple", rippleColor : PaperColor.GREEN);
  vbox.addChild(check2);
  
  
  stage.addChild(vbox);
  vbox.setSize(320, 400);
  

}

void _onSelected(RadioGroupEvent event) {
}
