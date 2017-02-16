import 'dart:async';
import 'dart:html' as html;
import 'package:rockdot_commons/rockdot_commons.dart';
import 'package:stagexl/stagexl.dart';

Stage stage;
Sprite _container;


Future main() async {
  var opts = new StageOptions();
  opts.renderEngine = RenderEngine.Canvas2D;
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

  MdTabs tab = new MdTabs(highlightColor : MdColor.BLUE, bgColor: MdColor.BLACK);
  tab.addTab(new MdButton("ITEM ONE", preset: MdButton.PRESET_WHITE, shadow: false));
  tab.addTab(new MdButton("ITEM TWO", preset: MdButton.PRESET_WHITE, shadow: false));
  tab.addTab(new MdButton("ITEM THREE", preset: MdButton.PRESET_WHITE, shadow: false));

  MdAppBar bar = new MdAppBar(highlightColor : MdColor.WHITE, bgColor: MdColor.BLUE);
  bar.addToTL(new MdIconButton(MdIcon.white(MdIconSet.menu), rippleColor: MdColor.WHITE));
  bar.addToTL(new MdText("Title", size: 24, color: MdColor.WHITE));
  bar.addToTR(new MdIconButton(MdIcon.white(MdIconSet.add_shopping_cart), rippleColor: MdColor.WHITE));
  bar.addMdTabs(tab);

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
  radioGroupV.addChild(new MdRadioButton(label : "Red pill", activeColor : MdColor.RED));
  radioGroupV.addChild(new MdRadioButton(label : "or"));
  radioGroupV.addChild(new MdRadioButton(label : "Blue pill?", activeColor : MdColor.BLUE));
  radioGroupV.addEventListener(RadioGroupEvent.BUTTON_SELECTED, _onSelected);
  vbox.addChild(radioGroupV);
  radioGroupV.refresh();

  MdCheckbox check1 = new MdCheckbox(label : "Checkbox with blue label", activeColor: MdColor.BLUE);
  vbox.addChild(check1);

  MdCheckbox check2 = new MdCheckbox(label : "Checkbox with green label and ripple", rippleColor : MdColor.GREEN);
  vbox.addChild(check2);

  MdToggleButton toggle1 = new MdToggleButton(label : "Wi-Fi");
  vbox.addChild(toggle1);

  MdToggleButton toggle2 = new MdToggleButton(label : "Bluetooth", activeColor : MdColor.BLUE, rippleColor : MdColor.BLUE);
  vbox.addChild(toggle2);

  stage.addChild(vbox);

  vbox.span(stage.stageWidth-20, stage.stageHeight - 120);

}

void _onSelected(RadioGroupEvent event) {
switch(event.index){
  case 0:
    new MdToast("You chose the Red pill.", stage, fontColor: MdColor.WHITE, bgColor : MdColor.RED);
  break;
  case 2:
    new MdToast("You chose the Blue pill.", stage, fontColor: MdColor.WHITE, bgColor : MdColor.BLUE, position: MdToast.BR);
  break;
  }
}
