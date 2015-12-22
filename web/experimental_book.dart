import 'dart:html' as html;
import 'package:rockdot_commons/rockdot_commons.dart';
import 'package:stagexl/stagexl.dart';

Stage stage;
BookView book;

void main() {
  var opts = new StageOptions();
  opts.renderEngine = RenderEngine.Canvas2D;
  opts.backgroundColor = 0xFFf9f9f9;
  opts.stageScaleMode = StageScaleMode.NO_SCALE;
  opts.stageAlign = StageAlign.TOP_LEFT;

  stage = new Stage(html.querySelector('#stage'), options: opts);

  new RenderLoop()..addStage(stage);
  BookSampleAssets.load(start);
}
void start() {
  
  book = new BookView("book");
  book.span(900, 600);
  book.x = 20;
  book.y = 20;
  book.openAt = 0;
  book.autoFlipDuration = 600;
  book.easing = 0.7;
  book.regionSize = 150;
  book.sideFlip = true;
  book.hardCover = true;
  book.hover = true;
  book.snap = false;
  book.flipOnClick = true;
  stage.addChild(book);

  /* Initialize stuff here. You can use _width and _height. */
  // first page

  Page page;
  for (int i = 1; i <= BookSampleAssets.NUM_PAGES; i++) {
    page = new Page(BookSampleAssets.getPage(i));
    book.addChild(page);
  }

  book.init();
  book.addEventListener(LifecycleEvent.INIT_COMPLETE, onBookInit);

}

void onBookInit(event) {
  book.removeEventListener(LifecycleEvent.INIT_COMPLETE, onBookInit);
  book.nextPage();
}
