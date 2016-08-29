import 'dart:html' as html;
import 'package:rockdot_commons/rockdot_commons.dart';
import 'package:stagexl/stagexl.dart';

Stage stage;
BookView book;

void main() {
  var opts = new StageOptions();
  opts.renderEngine = RenderEngine.Canvas2D;
  opts.backgroundColor = 0xFFf9f9f9;
  //opts.stageScaleMode = StageScaleMode.NO_SCALE;
  //opts.stageAlign = StageAlign.TOP_LEFT;
  opts.inputEventMode = Rd.MOBILE ? InputEventMode.TouchOnly : InputEventMode.MouseOnly;
  opts.preventDefaultOnTouch = true;
  opts.preventDefaultOnWheel = true;
  opts.preventDefaultOnKeyboard = false;
  //opts.maxPixelRatio = 1.0;

  stage = new Stage(html.querySelector('#stage'), width: 1020, height: 720, options: opts);

  Rd.STAGE = stage;
  new RenderLoop()..addStage(stage);
  BookSampleAssets.load(start);
}
void start() {
  
  book = new BookView("book");
  book.span(900, 600);
  book.x = 60;
  book.y = 60;
  book.openAt = 0;
  book.autoFlipDuration = 900;
  book.easing = 0.7;
  book.regionSize = 150;
  book.sideFlip = true;
  book.hardCover = false;
  book.hover = true;
  book.snap = false;
  book.flipOnClick = true;
  stage.addChild(book);

  /* Initialize stuff here. You can use _width and _height. */
  // first page

  Page page;
  for (int i = 1; i <= BookSampleAssets.NUM_PAGES - 1; i++) {
    page = new Page(BookSampleAssets.getPage(i));
    if(i==4){
      page.tearable = true;
      book.addChild( new MdSamplePage() );
    }
    book.addChild(page);
  }

  book.addEventListener(LifecycleEvent.INIT_COMPLETE, onBookInit);
  book.init();

}

void onBookInit(event) {
  book.removeEventListener(LifecycleEvent.INIT_COMPLETE, onBookInit);
 // book.nextPage();
}
