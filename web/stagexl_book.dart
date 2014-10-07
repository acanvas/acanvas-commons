import 'dart:html' as html;
import 'package:stagexl_commons/stagexl_commons.dart';
import 'package:stagexl/stagexl.dart';

Stage stage;

void main() {
  stage = new Stage(html.querySelector('#stage'), webGL: false, color: 0xFFf9f9f9);
  stage.scaleMode = StageScaleMode.NO_SCALE;
  stage.align = StageAlign.TOP_LEFT;
  ContextTool.WEBGL = stage.renderEngine == RenderEngine.WebGL ? true : false;
  new RenderLoop()..addStage(stage);
  BookSampleAssets.load(start);
}
void start() {
  
  BookView book = new BookView("book");
  book.setSize(900, 600);
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
  book.nextPage();  

}
