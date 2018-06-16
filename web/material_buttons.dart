import 'dart:async';
import 'dart:html' as html;
import 'package:acanvas_commons/acanvas_commons.dart';
import 'package:stagexl/stagexl.dart';

Stage stage;

Future main() async {
  var opts = new StageOptions();
  opts.maxPixelRatio = 1.0;
  opts.stageScaleMode = Ac.MOBILE ? StageScaleMode.NO_SCALE : StageScaleMode.NO_SCALE;
  opts.stageAlign = StageAlign.TOP_LEFT;
  opts.stageRenderMode = StageRenderMode.AUTO;
  opts.backgroundColor = 0xFFf9f9f9;
  opts.renderEngine = Ac.MOBILE ? RenderEngine.WebGL : RenderEngine.Canvas2D;
  opts.antialias = Ac.MOBILE ? false : true;
  opts.inputEventMode = Ac.MOBILE ? InputEventMode.TouchOnly : InputEventMode.MouseOnly;
  opts.preventDefaultOnTouch = true;
  opts.preventDefaultOnWheel = true;
  opts.preventDefaultOnKeyboard = false;

  stage = new Stage(html.querySelector('#stage') as html.CanvasElement, options: opts);
  new RenderLoop()..addStage(stage);

  Ac.STAGE = stage;
  AcFontUtil.addFont("Roboto:100,300");
  await AcFontUtil.loadFonts();
  start();
}

void gtest() {
  Shape s = new Shape()
    ..graphics.rect(0, 0, 30, 30)
    ..graphics.fillColor(0xFFFF0000);
  stage.addChild(s);
}

void testsimple() {
  //10% CPU
  MdButton button1 = new MdButton("SUBMIT", preset: MdButton.PRESET_WHITE)
    ..x = 30
    ..y = 30;
  stage.addChild(button1);
}

void test() {
  /* Vertical Container */
  Wrap vbox = new Wrap(spacing: 20, reflow: false)
    ..x = 10
    ..y = 10;

  Flow hbox1 = new Flow()
    ..inheritSpan = true
    ..reflow = true
    //..flowOrientation = FlowOrientation.VERTICAL
    ..spacing = 20;

  for (int i = 0; i < 20; i++) {
    //1 button: 10% CPU
    //10 buttons: 13% CPU
    MdButton button1 = new MdButton("SUBMIT", preset: MdButton.PRESET_WHITE);
    //..x = 30
    //..y = i*30;
    hbox1.addChild(button1);
  }

  vbox.addChild(hbox1);
  stage.addChild(vbox);
  vbox.span(stage.stageWidth - 10, stage.stageHeight - 10);
  //hbox1.span(400, 600);
}

void start() {
  /* Vertical Container */
  Wrap vbox = new Wrap(spacing: 20, reflow: false)
    ..x = 10
    ..y = 10
    ..flow.flowOrientation = FlowOrientation.VERTICAL;

  /*
   * 1st row: standard square buttons with preset colors
   */
  Flow hbox1 = new Flow()
    ..spacing = 20
    ..inheritSpan = true;

  MdButton button1 = new MdButton("SUBMIT", preset: MdButton.PRESET_WHITE);
  hbox1.addChild(button1);

  MdButton button2 = new MdButton("CANCEL", preset: MdButton.PRESET_GREY);
  hbox1.addChild(button2);

  MdButton button3 = new MdButton("COMPOSE", preset: MdButton.PRESET_BLUE);
  hbox1.addChild(button3);

  MdButton button4 = new MdButton("OK", preset: MdButton.PRESET_GREEN);
  hbox1.addChild(button4);

  vbox.addChild(hbox1);

  /*
   * 2nd row: standard square Md buttons with Md Ripple custom color override
   */
  Flow hbox2 = new Flow()
    ..spacing = 20
    ..inheritSpan = true;

  MdButton plusOneButton1 = new MdButton("+1", width: 60, preset: MdButton.PRESET_GREY, fontSize: 16);
  hbox2.addChild(plusOneButton1);

  MdButton plusOneButton2 =
      new MdButton("+1", width: 60, preset: MdButton.PRESET_GREY, fontSize: 16, fontColor: MdColor.BLUE);
  hbox2.addChild(plusOneButton2);

  MdButton plusOneButton3 =
      new MdButton("+1", width: 60, preset: MdButton.PRESET_GREY, fontSize: 16, fontColor: MdColor.RED);
  hbox2.addChild(plusOneButton3);

  vbox.addChild(hbox2);

  /*
   * 3rd row: transparent round Md buttons with Core Icons and Md Ripples
   */
  Flow hbox3 = new Flow()
    ..spacing = 20
    ..inheritSpan = true;

  MdFab iconButton1 =
      new MdFab(MdIcon.black(MdIconSet.menu), bgColor: MdColor.TRANSPARENT, rippleColor: MdColor.BLACK, shadow: false);
  hbox3.addChild(iconButton1);

  MdFab iconButton2 = new MdFab(MdIcon.black(MdIconSet.more_vert),
      bgColor: MdColor.TRANSPARENT, rippleColor: MdColor.BLACK, shadow: false);
  hbox3.addChild(iconButton2);

  MdFab iconButton3 =
      new MdFab(MdIcon.black(MdIconSet.delete), bgColor: MdColor.TRANSPARENT, rippleColor: MdColor.RED, shadow: false);
  hbox3.addChild(iconButton3);

  MdFab iconButton4 = new MdFab(MdIcon.black(MdIconSet.account_box),
      bgColor: MdColor.TRANSPARENT, rippleColor: MdColor.BLUE, shadow: false);
  hbox3.addChild(iconButton4);

  vbox.addChild(hbox3);

  /*
   * 4th row: standard Md Fabs with Core Icons and Md Ripples
   */
  Flow hbox4 = new Flow()
    ..spacing = 20
    ..inheritSpan = true;

  MdFab roundButton1 = new MdFab(MdIcon.white(MdIconSet.add), bgColor: MdColor.RED);
  hbox4.addChild(roundButton1);

  MdFab roundButton2 = new MdFab(MdIcon.white(MdIconSet.mail), bgColor: MdColor.BLUE);
  hbox4.addChild(roundButton2);

  MdFab roundButton3 = new MdFab(MdIcon.white(MdIconSet.create), bgColor: MdColor.GREEN);
  hbox4.addChild(roundButton3);

  vbox.addChild(hbox4);

  /*
   * 5th row: Md Menus with Md Items and Md Ripples
   */
  Flow hbox5 = new Flow()
    ..spacing = 20
    ..inheritSpan = true;

  List<Map<String, String>> testList = [];
  for (int i = 0; i < 40; i++) {
    Map<String, String> vo = {};
    vo['label'] = "Menu item #$i";
    vo['url'] = "";
    testList.add(vo);
  }

  MdMenu list1 = new MdMenu(testList, cell: new MdListCell(MdColor.GREY_DARK), shadow: false);
  //list.submitCallback = _onCellCommit;
  list1.touchable = true;
  hbox5.addChild(list1);
  list1.span(400, 400);

  MdMenu list2 = new MdMenu(testList, cell: new MdListCell(MdColor.BLUE), shadow: true);
  //list.submitCallback = _onCellCommit;
  hbox5.addChild(list2);
  list2.span(400, 400);

  vbox.addChild(hbox5);

  /*
   * 6th row: Md Dialog with Md Text and Md Buttons; also, Custom Cards
   */
  Flow hbox6 = new Flow()..spacing = 20;

  MdDialog dialog = new MdDialog("Permission");
  dialog.addContent(new MdText(
      "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam."));
  dialog.addButton(
      new MdButton("DECLINE", preset: MdButton.PRESET_RED, fontColor: MdColor.GREY_DARK, width: 90, background: false));
  dialog.addButton(
      new MdButton("ACCEPT", preset: MdButton.PRESET_BLUE, fontColor: MdColor.BLUE, width: 90, background: false));
  dialog.span(300, 240);
  hbox6.addChild(dialog);

  Button card = new Button();
  card.addChild(new MdShadow(type: MdShadow.RECTANGLE, bgColor: MdColor.WHITE, respondToClick: false));
  card.addChild(new MdRipple(color: MdColor.GREY_DARK));
  card.span(300, 240);
  hbox6.addChild(card);

  Button image = new Button();
  image.addChild(new MdShadow(type: MdShadow.RECTANGLE, bgColor: MdColor.WHITE, respondToClick: false));
  image.addChild(new ImageSprite()
    ..span(300, 240, refresh: false)
    ..href = "http://lorempixel.com/300/240/nature/");
  image.addChild(new MdRipple(color: MdColor.WHITE));
  image.span(300, 240);
  hbox6.addChild(image);

  vbox.addChild(hbox6);
  stage.addChild(vbox);
  vbox.span(stage.stageWidth - 10, stage.stageHeight - 10);

  int totalCount = _logStage(stage, 0);
  print("totalCount: $totalCount");

  //stage.renderMode = StageRenderMode.ONCE;
}

int _logStage(DisplayObjectContainer parent, int depth) {
  int count = 0;
  String str = "";
  for (int i = 0; i < depth; i++) {
    str += "-";
  }
  parent.children.forEach((child) {
    print("($depth) $str ${child}");
    count++;
    if (child is DisplayObjectContainer) {
      count += _logStage(child, depth + 1);
    }
  });

  return count;
}
