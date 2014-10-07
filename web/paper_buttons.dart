import 'dart:html' as html;
import 'package:dart_commons/dart_commons.dart';
import 'package:stagexl/stagexl.dart';

Stage stage;
Sprite _container;


void main() {
  stage = new Stage(html.querySelector('#stage'), webGL: true, color: 0xFFf9f9f9);
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
   * 1st row: standard square buttons with preset colors 
   */
  HBox hbox1 = new HBox(20);

  PaperButton button1 = new PaperButton(ContextTool.MOBILE ? "MOBILE" : "SUBMIT", preset: PaperButton.PRESET_WHITE);
  hbox1.addChild(button1);

  PaperButton button2 = new PaperButton("CANCEL", preset: PaperButton.PRESET_GREY);
  hbox1.addChild(button2);

  PaperButton button3 = new PaperButton("COMPOSE", preset: PaperButton.PRESET_BLUE);
  hbox1.addChild(button3);
  
  PaperButton button4 = new PaperButton("OK", preset: PaperButton.PRESET_GREEN);
  hbox1.addChild(button4);

  vbox.addChild(hbox1);
  

  /* 
   * 2nd row: standard square Paper buttons with Paper Ripple custom color override 
   */
  HBox hbox2 = new HBox(20);
  
  PaperButton plusOneButton1 = new PaperButton("+1", width: 60, preset: PaperButton.PRESET_GREY, fontSize: 16);
  hbox2.addChild(plusOneButton1);
  
  PaperButton plusOneButton2 = new PaperButton("+1", width: 60, preset: PaperButton.PRESET_GREY, fontSize: 16, fontColor: PaperColor.BLUE);
  hbox2.addChild(plusOneButton2);
  
  PaperButton plusOneButton3 = new PaperButton("+1", width: 60, preset: PaperButton.PRESET_GREY, fontSize: 16, fontColor: PaperColor.RED);
  hbox2.addChild(plusOneButton3);

  vbox.addChild(hbox2);

  
  /* 
   * 3rd row: transparent round Paper buttons with Core Icons and Paper Ripples
   */
  HBox hbox3 = new HBox(20);
  
  PaperButtonRound iconButton1 = new PaperButtonRound(PaperIcon.black(PaperIconSet.menu), bgColor: PaperColor.TRANSPARENT, rippleColor: PaperColor.BLACK);
  hbox3.addChild(iconButton1);
  
  PaperButtonRound iconButton2 = new PaperButtonRound(PaperIcon.black(PaperIconSet.more_vert), bgColor: PaperColor.TRANSPARENT, rippleColor: PaperColor.BLACK);
  hbox3.addChild(iconButton2);
  
  PaperButtonRound iconButton3 = new PaperButtonRound(PaperIcon.black(PaperIconSet.delete), bgColor: PaperColor.TRANSPARENT, rippleColor: PaperColor.RED);
  hbox3.addChild(iconButton3);
  
  PaperButtonRound iconButton4 = new PaperButtonRound(PaperIcon.black(PaperIconSet.account_box), bgColor: PaperColor.TRANSPARENT, rippleColor: PaperColor.BLUE);
  hbox3.addChild(iconButton4);
  
  vbox.addChild(hbox3);

  
  /* 
   * 4th row: standard Paper Fabs with Core Icons and Paper Ripples
   */
  HBox hbox4 = new HBox(20);
  
  PaperButtonRound roundButton1 = new PaperButtonRound(PaperIcon.white(PaperIconSet.add), bgColor: PaperColor.RED);
  hbox4.addChild(roundButton1);
  
  PaperButtonRound roundButton2 = new PaperButtonRound(PaperIcon.white(PaperIconSet.mail), bgColor: PaperColor.BLUE);
  hbox4.addChild(roundButton2);

  PaperButtonRound roundButton3 = new PaperButtonRound(PaperIcon.white(PaperIconSet.create), bgColor: PaperColor.GREEN);
  hbox4.addChild(roundButton3);
  
  vbox.addChild(hbox4);
  
  
  /* 
   * 5th row: Paper Menus with Paper Items and Paper Ripples
   */
  HBox hbox5 = new HBox(20);

  List testList = [];
  for(int i = 0; i < 4; i++){
    Map vo = {};
    vo['label'] = "Menu item #$i";
    vo['url'] = "";
    testList.add(vo);
  } 
  
  PaperMenu list1 = new PaperMenu( testList, color: PaperColor.GREY_DARK);
  //list.submitCallback = _onCellCommit;
  hbox5.addChild(list1); 

  PaperMenu list2 = new PaperMenu( testList, color: PaperColor.BLUE);
  //list.submitCallback = _onCellCommit;
  hbox5.addChild(list2); 
  
  vbox.addChild(hbox5);

  
  /* 
   * 6th row: Paper Dialog with Paper Text and Paper Buttons; also, Custom Cards
   */
  HBox hbox6 = new HBox(20);

  PaperDialog dialog = new PaperDialog("Permission");
  dialog.addContent(new PaperText("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam."));
  dialog.addButton( new PaperButton("DECLINE", preset: PaperButton.PRESET_RED, fontColor: PaperColor.GREY_DARK, width: 90, shadow : false) );
  dialog.addButton( new PaperButton("ACCEPT", preset: PaperButton.PRESET_BLUE, fontColor: PaperColor.BLUE, width: 90, shadow : false) );
  dialog.setSize(300, 240);
  hbox6.addChild(dialog); 

  Button card = new Button();
  card.addChild( new PaperShadow(type : PaperShadow.RECTANGLE, bgColor: PaperColor.WHITE, respondToClick: false) );
  card.addChild( new PaperRipple(color: PaperColor.GREY_DARK) );
  card.setSize(300, 240);
  hbox6.addChild(card); 

  Button image = new Button();
  image.addChild( new PaperShadow(type : PaperShadow.RECTANGLE, bgColor: PaperColor.WHITE, respondToClick: false) );
  image.addChild( new ComponentImageLoader("http://lorempixel.com/300/240/nature/", 300, 240) );
  image.addChild( new PaperRipple(color: PaperColor.WHITE) );
  image.setSize(300, 240);
  hbox6.addChild(image); 
  
  
  vbox.addChild(hbox6); 
  
  
  stage.addChild(vbox);
  

}
