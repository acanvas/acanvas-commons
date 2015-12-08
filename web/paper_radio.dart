import 'dart:html' as html;
import 'package:stagexl_commons/stagexl_commons.dart';
import 'package:stagexl/stagexl.dart';

Stage stage;
Sprite _container;


void main() {
  var opts = new StageOptions();
  opts.renderEngine = RenderEngine.Canvas2D;
  opts.backgroundColor = 0xFFf9f9f9;
  opts.stageScaleMode = StageScaleMode.NO_SCALE;
  opts.stageAlign = StageAlign.TOP_LEFT;

  stage = new Stage(html.querySelector('#stage'), options: opts);
  Rd.STAGE = stage;
  Rd.WEBGL = stage.renderEngine == RenderEngine.WebGL ? true : false;
  new RenderLoop()..addStage(stage);

  RdFontUtil.addFont("Roboto");
  RdFontUtil.loadFonts(start);
}
void start() {

  PaperTabs tab = new PaperTabs(highlightColor : PaperColor.BLUE, bgColor: PaperColor.BLACK);
  tab.addTab(new PaperButton("ITEM ONE", preset: PaperButton.PRESET_WHITE, shadow: false));
  tab.addTab(new PaperButton("ITEM TWO", preset: PaperButton.PRESET_WHITE, shadow: false));
  tab.addTab(new PaperButton("ITEM THREE", preset: PaperButton.PRESET_WHITE, shadow: false));

  PaperAppBar bar = new PaperAppBar(highlightColor : PaperColor.WHITE, bgColor: PaperColor.BLUE);
  bar.addToTL(new PaperIconButton(PaperIcon.white(PaperIconSet.menu), rippleColor: PaperColor.WHITE));
  bar.addToTL(new PaperText("Title", size: 24, color: PaperColor.WHITE));
  bar.addToTR(new PaperIconButton(PaperIcon.white(PaperIconSet.add_shopping_cart), rippleColor: PaperColor.WHITE));
  bar.addPaperTabs(tab);

  stage.addChild(bar);
  bar.span(stage.stageWidth, 100);
  
  /* Vertical Container */
  Wrap vbox = new Wrap(spacing: 0, reflow: false)
    ..x = 10
    ..y = 110;

  /* 
   * Radio Button Group
   */
  RadioGroup radioGroupV = new RadioGroup(flowOrientation: FlowOrientation.HORIZONTAL, spacing: 5.0)
  ..autoRefresh = false;
  radioGroupV.addChild(new PaperRadioButton(label : "Red pill", activeColor : PaperColor.RED));
  radioGroupV.addChild(new PaperRadioButton(label : "or"));
  radioGroupV.addChild(new PaperRadioButton(label : "Blue pill?", activeColor : PaperColor.BLUE));
  radioGroupV.addEventListener(RadioGroupEvent.BUTTON_SELECTED, _onSelected);
  vbox.addChild(radioGroupV);
  radioGroupV.refresh();

  PaperCheckbox check1 = new PaperCheckbox(label : "Checkbox with blue label", activeColor: PaperColor.BLUE);
  vbox.addChild(check1);

  PaperCheckbox check2 = new PaperCheckbox(label : "Checkbox with green label and ripple", rippleColor : PaperColor.GREEN);
  vbox.addChild(check2);

  PaperToggleButton toggle1 = new PaperToggleButton(label : "Wi-Fi");
  vbox.addChild(toggle1);

  PaperToggleButton toggle2 = new PaperToggleButton(label : "Bluetooth", activeColor : PaperColor.BLUE, rippleColor : PaperColor.BLUE);
  vbox.addChild(toggle2);

  stage.addChild(vbox);

  vbox.span(stage.stageWidth-20, stage.stageHeight - 120);

}

void _onSelected(RadioGroupEvent event) {
switch(event.index){
  case 0:
    new PaperToast("You chose the Red pill.", stage, fontColor: PaperColor.WHITE, bgColor : PaperColor.RED);
  break;
  case 2:
    new PaperToast("You chose the Blue pill.", stage, fontColor: PaperColor.WHITE, bgColor : PaperColor.BLUE, position: PaperToast.BR);
  break;
  }
}
