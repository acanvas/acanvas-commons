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
  ContextTool.STAGE = stage;
  ContextTool.WEBGL = stage.renderEngine == RenderEngine.WebGL ? true : false;
  new RenderLoop()..addStage(stage);

  FontTool.addFont("Roboto");
  FontTool.loadFonts(start);
}
void start() {

  /* Vertical Container */
  Wrap vbox = new Wrap(spacing: 20)
    ..x = 10
    ..y = 10;

  /*
   * 1st row: standard square buttons with preset colors
   */
  Flow hbox1 = new Flow()
    ..spacing = 20;

  PaperButton button1 = new PaperButton("SUBMIT", preset: PaperButton.PRESET_WHITE);
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
  Flow hbox2 = new Flow()
    ..spacing = 20;

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
  Flow hbox3 = new Flow()
    ..spacing = 20;

  PaperFab iconButton1 = new PaperFab(PaperIcon.black(PaperIconSet.menu), bgColor: PaperColor.TRANSPARENT, rippleColor: PaperColor.BLACK, shadow: false);
  hbox3.addChild(iconButton1);

  PaperFab iconButton2 = new PaperFab(PaperIcon.black(PaperIconSet.more_vert), bgColor: PaperColor.TRANSPARENT, rippleColor: PaperColor.BLACK, shadow: false);
  hbox3.addChild(iconButton2);

  PaperFab iconButton3 = new PaperFab(PaperIcon.black(PaperIconSet.delete), bgColor: PaperColor.TRANSPARENT, rippleColor: PaperColor.RED, shadow: false);
  hbox3.addChild(iconButton3);

  PaperFab iconButton4 = new PaperFab(PaperIcon.black(PaperIconSet.account_box), bgColor: PaperColor.TRANSPARENT, rippleColor: PaperColor.BLUE, shadow: false);
  hbox3.addChild(iconButton4);

  vbox.addChild(hbox3);


  /*
   * 4th row: standard Paper Fabs with Core Icons and Paper Ripples
   */
  Flow hbox4 = new Flow()
    ..spacing = 20;

  PaperFab roundButton1 = new PaperFab(PaperIcon.white(PaperIconSet.add), bgColor: PaperColor.RED);
  hbox4.addChild(roundButton1);

  PaperFab roundButton2 = new PaperFab(PaperIcon.white(PaperIconSet.mail), bgColor: PaperColor.BLUE);
  hbox4.addChild(roundButton2);

  PaperFab roundButton3 = new PaperFab(PaperIcon.white(PaperIconSet.create), bgColor: PaperColor.GREEN);
  hbox4.addChild(roundButton3);

  vbox.addChild(hbox4);


  /*
   * 5th row: Paper Menus with Paper Items and Paper Ripples
   */
  Flow hbox5 = new Flow()
    ..spacing = 20;

  List testList = [];
  for(int i = 0; i < 40; i++){
    Map vo = {};
    vo['label'] = "Menu item #$i";
    vo['url'] = "";
    testList.add(vo);
  }

  PaperMenu list1 = new PaperMenu( testList, cell: new PaperListCell(PaperColor.GREY_DARK), shadow: false);
  //list.submitCallback = _onCellCommit;
  list1.touchable = true;
  hbox5.addChild(list1);
  list1.span(400, 400);

  PaperMenu list2 = new PaperMenu( testList, cell: new PaperListCell(PaperColor.BLUE), shadow: true);
  //list.submitCallback = _onCellCommit;
  hbox5.addChild(list2);
  list2.span(400, 400);

  vbox.addChild(hbox5);


  /*
   * 6th row: Paper Dialog with Paper Text and Paper Buttons; also, Custom Cards
   */
  Flow hbox6 = new Flow()
    ..spacing = 20;

  PaperDialog dialog = new PaperDialog("Permission");
  dialog.addContent(new PaperText("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam."));
  dialog.addButton( new PaperButton("DECLINE", preset: PaperButton.PRESET_RED, fontColor: PaperColor.GREY_DARK, width: 90, background : false) );
  dialog.addButton( new PaperButton("ACCEPT", preset: PaperButton.PRESET_BLUE, fontColor: PaperColor.BLUE, width: 90, background : false) );
  dialog.span(300, 240);
  hbox6.addChild(dialog);

  Button card = new Button();
  card.addChild( new PaperShadow(type : PaperShadow.RECTANGLE, bgColor: PaperColor.WHITE, respondToClick: false) );
  card.addChild( new PaperRipple(color: PaperColor.GREY_DARK) );
  card.span(300, 240);
  hbox6.addChild(card);

  Button image = new Button();
  image.addChild( new PaperShadow(type : PaperShadow.RECTANGLE, bgColor: PaperColor.WHITE, respondToClick: false) );
  image.addChild( new ImageSprite()
                        ..span(300, 240, refresh: false)
                        ..href = "http://lorempixel.com/300/240/nature/"
  );
  image.addChild( new PaperRipple(color: PaperColor.WHITE) );
  image.span(300, 240);
  hbox6.addChild(image);


  vbox.addChild(hbox6);
  stage.addChild(vbox);
  vbox.span(stage.stageWidth - 10, stage.stageHeight - 10);



}
