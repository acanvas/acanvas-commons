part of rockdot_commons;

class MdSamplePage extends Page {
  /**
   * Constructor
   */
  MdSamplePage() : super() {
    start();
  }

  void start() {
    RdGraphics.rectangle(0, 0, 450, 600, color: Color.White, sprite: this, clear: false);

    /* Vertical Container */
    Wrap vbox = new Wrap(spacing: 20, reflow: false)
      ..x = 10
      ..y = 10
      ..flow.flowOrientation = FlowOrientation.VERTICAL
      ..inheritSpan = false;

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
/*
    MdButton button4 = new MdButton("OK", preset: MdButton.PRESET_GREEN);
    hbox1.addChild(button4);
*/
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

    MdFab iconButton1 = new MdFab(MdIcon.black(MdIconSet.menu),
        bgColor: MdColor.TRANSPARENT, rippleColor: MdColor.BLACK, shadow: false);
    hbox3.addChild(iconButton1);

    MdFab iconButton2 = new MdFab(MdIcon.black(MdIconSet.more_vert),
        bgColor: MdColor.TRANSPARENT, rippleColor: MdColor.BLACK, shadow: false);
    hbox3.addChild(iconButton2);

    MdFab iconButton3 = new MdFab(MdIcon.black(MdIconSet.delete),
        bgColor: MdColor.TRANSPARENT, rippleColor: MdColor.RED, shadow: false);
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

    List testList = [];
    for (int i = 0; i < 40; i++) {
      Map vo = {};
      vo['label'] = "Menu item #$i";
      vo['url'] = "";
      testList.add(vo);
    }
/*
    MdMenu list1 = new MdMenu( testList, cell: new MdListCell(MdColor.GREY_DARK), shadow: false);
    //list.submitCallback = _onCellCommit;
    list1.touchable = true;
    hbox5.addChild(list1);
    list1.span(400, 400);
*/

    MdMenu list2 = new MdMenu(testList, cell: new MdListCell(MdColor.BLUE), shadow: true);
    //list.submitCallback = _onCellCommit;
    hbox5.addChild(list2);
    list2.span(400, 250);
    vbox.addChild(hbox5);

    /*
   * 6th row: Md Dialog with Md Text and Md Buttons; also, Custom Cards
   */
    Flow hbox6 = new Flow()
      ..spacing = 20
      ..inheritSpan = true;

    MdDialog dialog = new MdDialog("Permission");
    dialog.addContent(new MdText(
        "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam."));
    dialog.addButton(new MdButton("DECLINE",
        preset: MdButton.PRESET_RED, fontColor: MdColor.GREY_DARK, width: 90, background: false));
    dialog.addButton(
        new MdButton("ACCEPT", preset: MdButton.PRESET_BLUE, fontColor: MdColor.BLUE, width: 90, background: false));
    dialog.span(300, 240);
    hbox6.addChild(dialog);
/*
    Button card = new Button();
    card.addChild( new MdShadow(type : MdShadow.RECTANGLE, bgColor: MdColor.WHITE, respondToClick: false) );
    card.addChild( new MdRipple(color: MdColor.GREY_DARK) );
    card.span(300, 240);
    hbox6.addChild(card);

    Button image = new Button();
    image.addChild( new MdShadow(type : MdShadow.RECTANGLE, bgColor: MdColor.WHITE, respondToClick: false) );
    image.addChild( new ImageSprite()
      ..span(300, 240, refresh: false)
      ..href = "http://lorempixel.com/300/240/nature/"
    );
    image.addChild( new MdRipple(color: MdColor.WHITE) );
    image.span(300, 240);
    hbox6.addChild(image);
*/

    vbox.addChild(hbox6);
    addChild(vbox);
    vbox.span(430, 580);
  }

  /**
   * Draws itself on a BitmapData instance and returns it.
   *
   * @return	BitmapData
   */
  BitmapData getBitmapData() {
    BitmapData bmd = new BitmapData(_width.round(), _height.round(), 0x00ffffff);
    bmd.draw(this);
    return bmd;
  }
}
